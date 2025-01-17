{ pkgs }:

with pkgs; [
  # Learning & CLI Enhancement
  tldr          # + NEW: Simplified man pages
  # tealdeer      # + NEW: Faster tldr implementation (disabled)
  navi          # + NEW: Interactive cheatsheet
  zoxide        # + NEW: Smart cd replacement
  thefuck       # + NEW: Command correction
  mcfly         # + NEW: Smart history search
  # atuin         # + NEW: AI-powered history (disabled)
  direnv        # + NEW: Environment configuration for Nix by directory
  
  # Modern CLI Tools
  bat           # = KEPT: Better cat
  eza           # + NEW: Modern ls replacement
  fd            # = KEPT: Find replacement
  fzf           # = KEPT: Fuzzy finder
  difftastic    # = KEPT: Better diff
  # du-dust     # = KEPT: Disk usage (disabled)
  broot       # + NEW: Better tree
  duf         # + NEW: Better df
  # ncdu        # + NEW: Disk analyzer (disabled)
  bottom      # + NEW: Modern system monitor
  xh          # + NEW: Curl alternative
  dog         # + NEW: Dig alternative
  glances     # + NEW: System monitor
  
  # Core Development
  git                # = KEPT
  lazygit            # + NEW: Git UI
  delta              # + NEW: Git diff tool
  gh                 # = KEPT: GitHub CLI
  copilot-cli        # + NEW: GitHub Copilot
  # - git-filter-repo  # - REMOVED: Specialized tool
  curl               # + NEW
  wget               # = KEPT
  gcc                # = KEPT
  pandoc             # = KEPT
  
# Python Development
  python312                    # Keep: Still useful as system Python
  python312.pkgs.tkinter    # Keep: If you need GUI development
  tcl                         # Keep: Required for tkinter
  tk                          # Keep: Required for tkinter
  # python312Packages.virtualenv # Remove: uv handles this better
  # poetry                     # Remove: Replace with uv
  uv                          # New package manager
  black                       # Keep: Still useful as system tool
  ruff                       # Added: Python linter
# Node.js Development
  nodejs_22                # = UPDATED: Using Node.js 22
  nodePackages.pnpm         # = KEPT
  nodePackages.prettier    # = KEPT
  nodePackages.nodemon     # = KEPT
  nodePackages.live-server # = KEPT
  nodePackages.serverless  # + NEW
  # nodePackages.repomix   # + NEW: Repo access for AI (disabled)

  # Document & PDF Tools (All New)
  poppler_utils # + NEW: PDF utilities
  tesseract     # + NEW: OCR engine
  # ocrmypdf      # + NEW: PDF OCR
  pdftk         # + NEW: PDF toolkit
  glow            # ^ MOVED from Media category
  ollama          # + NEW: LLM CLI
  
  # Media & File Processing
  ffmpeg        # = KEPT
  yt-dlp        # + NEW
  imagemagick   # = KEPT
  jpegoptim     # = KEPT
  pngquant      # = KEPT
  # - dejavu_fonts   # - REMOVED: Using other fonts
  # - font-awesome   # - REMOVED: Not needed
  # - hack-font      # - REMOVED: Using JetBrains Mono
  
  # Cloud & Container Tools
  docker             # = KEPT (was commented out)
  docker-compose     # = KEPT (was commented out)
  google-cloud-sdk   # = KEPT
  act                # = KEPT
  # - flyctl         # - REMOVED
  # - go             # - REMOVED: Not needed for Python/Next.js
  # - gopls          # - REMOVED: Go tooling
  # - terraform      # - REMOVED: Infrastructure tooling
  # - terraform-ls   # - REMOVED
  # - tflint         # - REMOVED
  
  # Terminal & Editor
  # vim              # + NEW (disabled)
  warp-terminal      # + NEW: AI-powered terminal
  tmux               # = KEPT
  speedtest-cli      # + NEW: Internet speed test
  # - alacritty      # - REMOVED: Using Warp instead
  # - neofetch       # - REMOVED: Not essential
  # - slack          # - REMOVED: Using system app
  # - jetbrains.phpstorm # - REMOVED: PHP tooling
  
  # Security & Encryption
  age               # = KEPT
  age-plugin-yubikey # = KEPT
  gnupg             # = KEPT
  openssh           # = KEPT
  _1password-cli        # - REMOVED: Using system app
  # - libfido2      # - REMOVED: Not essential
  openvpn           # + NEW: OpenVPN client
   
  # Fonts & Display
  jetbrains-mono           # = KEPT
  noto-fonts              # = KEPT
  noto-fonts-emoji        # = KEPT
  meslo-lgs-nf            # = KEPT
  emacs-all-the-icons-fonts # = KEPT
  
  # System & Shell
  zsh-powerlevel10k     # = KEPT
  zsh-autosuggestions # + NEW
  bash-completion       # = KEPT
  coreutils            # = KEPT
  htop                 # = KEPT
  tree                 # = KEPT
  unzip               # = KEPT
  unrar               # = KEPT
  sqlite              # = KEPT
  # - killall         # - REMOVED: Not essential
  # - iftop          # - REMOVED: Not essential
  
  # Text Processing & Spelling
  aspell         # = KEPT
  aspellDicts.en # = KEPT
  hunspell       # = KEPT
  
  # other
  realvnc-vnc-viewer

  # Removed Categories:
  # - All PHP packages and tools
  # - Most infrastructure tools (Terraform etc.)
]