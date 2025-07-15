{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    rust-bin.stable."1.83.0".default
    solana-cli
    curl git zsh neovim
    nodejs_20 bun pnpm yarn
    fd ripgrep htop eza jq
    zoxide starship tmux fira-code
    go nixd nil
    openjdk
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      eval "$(zoxide init zsh)"
      alias vi="nvim"

      # Set up PNPM_HOME and update PATH
      export PNPM_HOME="$HOME/.local/share/pnpm"
      export PATH="$PNPM_HOME:$PATH"

      export PATH="$HOME/.cargo/bin:$PATH"
      export FLYCTL_INSTALL="/Users/lamcc21/.fly"
      export PATH="$FLYCTL_INSTALL/bin:$PATH"

      # Alias for pushing the current branch to origin with upstream tracking
      alias gp='git push -u origin $(git symbolic-ref --short HEAD)'

      rgs() {
        local file
  	file="$(find /private/var/folders -type f -name screen.txt 2>/dev/null | sort -t/ -k9 -r | head -n1)"
        rg "$@" "$file"
      }

      # Alias for git commit with a message
      alias gcm='git commit -m'
    '';

    loginExtra = ''
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      filter_mode = "global";
    };
  };

  programs.starship.enable = true;

  programs.git = {
    enable = true;
    userName = "Lachlan McCrae";
    userEmail = "lachlan@mccrae.nz";
  };

  programs.tmux.enable = true;
}
