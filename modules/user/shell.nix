{ config, pkgs, ... }:

{
  imports = [
    ./fastfetch.nix
    ./yazi.nix
    ./tmux.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.spicetify"
    "${config.home.homeDirectory}/.local/share/npm-global/bin"
  ];

  home.packages = with pkgs; [
    ripgrep
    zoxide
    tree
    curl
    wget
    ncdu
    fzf
    git
    jq
    gh
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autocd = true;

    oh-my-zsh = {
      enable = true;
      theme = "bureau";
      plugins = [
        "git"
        "sudo"
        "colored-man-pages"
        "command-not-found"
      ];
    };

    history = {
      size = 50000;
      save = 50000;
    };

    shellAliases = {
      man = "qman";
      vim = "nvim";
      vi = "nvim";

      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      mkdir = "mkdir -pv";
      df = "df -h";
      du = "du -h";
      free = "free -h";

      dfn = "nvdots";
      ncdum = "sudo ncdu --exclude /mnt /";

      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#lenovo";
    };

    initContent = ''
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt SHARE_HISTORY

      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_SILENT

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      nvdots() {
        command nvim +"lua vim.schedule(function()
          local keys = vim.api.nvim_replace_termcodes('<Space>e', true, false, true)
          vim.api.nvim_feedkeys(keys, 'm', false)
        end)" ~/dotfiles/users/drama/common.nix
      }
    '';
  };
}
