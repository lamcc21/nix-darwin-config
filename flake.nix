{
  description = "Home Manager configuration for WSL Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      username = "lamcc21";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ rust-overlay.overlays.default ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit pkgs-unstable; };

        modules = [
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    };
}
