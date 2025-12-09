{ pkgs, pkgs-unstable, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    rust-bin.stable."1.83.0".default
    solana-cli
    curl git zsh neovim
    pkgs-unstable.nodejs_24 bun pnpm yarn
    fd ripgrep htop eza jq
    zoxide starship tmux fira-code
    go nixd nil
    terraform
    openjdk
    dotnet-sdk
    (python3.withPackages (ps: with ps; [
      pip
      requests
    ]))
    docker
    docker-compose
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

      # Tmux quick reference
      alias tmux-help='cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                    TMUX QUICK REFERENCE                      ║
╠══════════════════════════════════════════════════════════════╣
║ PREFIX = Ctrl-a (press & release, then press next key)      ║
╠══════════════════════════════════════════════════════════════╣
║ SESSIONS                                                     ║
║   tmux new -s name     Start new session                     ║
║   tmux ls              List sessions                         ║
║   tmux attach -t name  Attach to session                     ║
║   prefix d             Detach from session                   ║
║   prefix s             Switch sessions (interactive)         ║
╠══════════════════════════════════════════════════════════════╣
║ PANES (splits)                                               ║
║   prefix |             Split vertical (left/right)           ║
║   prefix -             Split horizontal (top/bottom)         ║
║   prefix h/j/k/l       Navigate panes (vim-style)            ║
║   prefix Ctrl-h/j/k/l  Resize panes                          ║
║   prefix z             Zoom/unzoom current pane              ║
║   prefix x             Close current pane                    ║
╠══════════════════════════════════════════════════════════════╣
║ WINDOWS (tabs)                                               ║
║   prefix c             Create new window                     ║
║   prefix n             Next window                           ║
║   prefix p             Previous window                       ║
║   prefix 0-9           Jump to window number                 ║
║   prefix ,             Rename window                         ║
╠══════════════════════════════════════════════════════════════╣
║ COPY/SCROLL                                                  ║
║   prefix [             Enter copy mode (scroll/search)       ║
║   q                    Exit copy mode                        ║
║   Mouse scroll         Auto copy mode (enabled)              ║
╠══════════════════════════════════════════════════════════════╣
║ OTHER                                                        ║
║   prefix ?             Show all keybindings                  ║
║   prefix r             Reload tmux config                    ║
╚══════════════════════════════════════════════════════════════╝
EOF
'
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

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 10000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      resurrect
      continuum
      tokyo-night-tmux
    ];

    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Better prefix (Ctrl-a instead of Ctrl-b)
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # New windows in current path
      bind c new-window -c "#{pane_current_path}"

      # Vim-style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes with Ctrl+hjkl
      bind -r C-h resize-pane -L 5
      bind -r C-j resize-pane -D 5
      bind -r C-k resize-pane -U 5
      bind -r C-l resize-pane -R 5

      # Easy reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Continuum settings
      set -g @continuum-restore 'on'
      set -g @resurrect-capture-pane-contents 'on'
    '';
  };
}
