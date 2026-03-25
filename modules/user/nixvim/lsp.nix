{ ... }:

{
  plugins = {
    "blink-cmp" = {
      enable = true;
      settings = {
        sources.default = [ "lsp" "path" "snippets" "buffer" ];
        completion.documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        keymap = {
          preset = "enter";
          "<C-y>" = [ "select_and_accept" ];
        };
      };
    };

    lsp = {
      enable = true;

      servers = {
        marksman.enable = true;
        bashls.enable = true;
        jsonls.enable = true;

        qmlls = {
          enable = true;
          cmd = [ "qmlls6" ];
          filetypes = [ "qml" "qmljs" ];
          extraOptions.single_file_support = true;
        };
      };
    };
  };
}
