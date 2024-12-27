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

  "Development/career/startup/.keep" = {
    text = "";
  };
  
  ".config/repomix/repomix.config.json" = {
    text = ''
      {
        "output": {
          "filePath": "repomix-output.xml",
          "style": "xml",
          "removeComments": false,
          "removeEmptyLines": false,
          "copyToClipboard": true,
          "topFilesLength": 25,
          "showLineNumbers": false,
          "instructionFilePath": ""
        },
        "include": [],
        "ignore": {
          "useGitignore": true,
          "useDefaultPatterns": true,
          "customPatterns": [
            ".cursorrules"
          ]
        },
        "security": {
          "enableSecurityCheck": true
        }
      }
    '';
  };

  ".aliases.helpme" = {
    text = ''
      # CLI Helper Tools Reference
      echo "tldr: Shows simplified man pages for commands"
      echo "fd: A faster, user-friendly alternative to 'find'"
      echo "bat: Enhanced 'cat' with syntax highlighting"
      echo "rg: A faster, more intuitive alternative to 'grep'"
      echo "broot: An interactive 'tree' command for better directory exploration"
      echo "delta: A better way to view git diffs with color and syntax highlighting"
      echo "lazygit: A simple, terminal UI for git commands"
      echo "difftastic: Syntax-aware diffing for better code comparison"

      # To display this list, use the 'helpme' alias
    '';
  };
}
