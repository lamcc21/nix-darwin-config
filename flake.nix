{
  description = "Nix-Darwin configuration for Lachlan's MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, nix-darwin, home-manager, rust-overlay, ... }:
    let
      system = "aarch64-darwin";
      username = "lamcc21";
      hostname = "Lachlans-MacBook-Air";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
    in {
      darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
        inherit system pkgs;

        modules = [
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.config.allowUnfree = true;

            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            services.nix-daemon.enable = true;

            system.stateVersion = 4;

            users.users.${username} = {
              name = "${username}";
              home = "/Users/${username}";
            };

            programs.zsh.enable = true;
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    };
}
