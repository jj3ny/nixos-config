{ pkgs }:

with pkgs; [
  # General packages for development and system management
  # alacritty
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  curl                      # Added: HTTP client
  git                       # Added: Version control
  killall
  neofetch
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose
  google-cloud-sdk         # Added: GCP tools


  # Media-related packages
  emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
  python311
  poetry
  mach-nix
]
