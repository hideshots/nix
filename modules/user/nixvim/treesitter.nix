{ pkgs, ... }:

{
  plugins = {
    "tmux-navigator".enable = true;

    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        javascript
        typescript
        markdown
        python
        vimdoc
        html
        rust
        lua
        css
        sql
        c
      ];
    };
  };
}
