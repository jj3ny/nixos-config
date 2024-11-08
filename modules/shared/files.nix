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

  ".pnpm-packages/bin/.keep" = {
    text = "";
  };
  
  "Development/legal/related/.keep" = {
    text = "";
  };
  
  "Development/research/llm/.keep" = {
    text = "";
  };
  
  "Development/research/ui/syncfusion/.keep" = {
    text = "";
  };
  
  "Development/tools/.keep" = {
    text = "";
  };
  
  "Development/experimental/_archive/.keep" = {
    text = "";
  };
}
