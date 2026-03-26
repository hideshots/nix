{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    sensibleOnTop = true;

    terminal = "tmux-256color";
    historyLimit = 5000;
    prefix = "C-s";
    keyMode = "vi";
    baseIndex = 1;
    mouse = true;

    extraConfig = ''
      set -g renumber-windows on
      set -as terminal-overrides ',*:Tc'

      bind P display-popup -E "
        find ~/Projects ~/ ~/.config -mindepth 1 -maxdepth 1 -type d 2>/dev/null |
        fzf --reverse --header 'Select directory:' |
        xargs -r -I{} tmux new-session -Ad -s \"\$(basename '{}')\" -c '{}'
      "

      bind r source-file ~/.config/tmux/tmux.conf \; display-message 'tmux reloaded'

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
    '';

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      vim-tmux-navigator
      resurrect
      {
        plugin = minimal-tmux-status;
        extraConfig = ''
          if-shell '[ -f ~/.cache/wal/tmux-theme.conf ]' \
            'source-file ~/.cache/wal/tmux-theme.conf'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };

  xdg.configFile."wal/templates/tmux-theme.conf".text = ''
    set -g @minimal-tmux-fg "{foreground}"
    set -g @minimal-tmux-bg "{color1}"
  '';
}
