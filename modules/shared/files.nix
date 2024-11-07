{ pkgs, config, ... }:

# let
#  githubPublicKey = "ssh-ed25519 AAAA...";
# in
{

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  # Initializes Emacs with org-mode so we can tangle the main config
  ".emacs.d/init.el" = {
    text = builtins.readFile ../shared/config/emacs/init.el;
  };

  # Development directory structure
  # Only need deepest paths to create full directory tree
  "dev/nix/nix-secrets/.keep" = {
    text = "";
  };
  
  "dev/legal/related/.keep" = {
    text = "";
  };
  
  "dev/research/llm/.keep" = {
    text = "";
  };
  
  "dev/research/ui/syncfusion/.keep" = {
    text = "";
  };
  
  "dev/tools/.keep" = {
    text = "";
  };
  
  "dev/experimental/_archive/.keep" = {
    text = "";
  };
}
