{ pkgs, inputs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    plugins = {
      inherit (pkgs.yaziPlugins)
        recycle-bin
        toggle-pane
        bookmarks
        no-status
        chmod
        ouch
        git;

      exifaudio =
        inputs.nix-yazi-plugins.packages.${pkgs.stdenv.hostPlatform.system}.exifaudio;
    };

    extraPackages = with pkgs; [
      imagemagick
      poppler
      resvg
      file
      _7zz
      fd

      xdg-utils
      miller
    ];

    initLua = ''
      require("recycle-bin"):setup()
      require("no-status"):setup()
      require("git"):setup({
        order = 1500,
      })

      require("bookmarks"):setup({
        persist = "all",
        desc_format = "parent",
        show_keys = true,
        notify = {
          enable = false,
        },
      })
    '';

    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_dir_first = true;
        ratio = [ 0 1 1 ];
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
        max_width = 9200;
        max_height = 9200;
        image_quality = 75;
      };

      opener = {
        edit = [
          {
            run = "nvim %s";
            block = true;
            for = "unix";
          }
        ];

        play = [
          {
            run = "mpv %s";
            orphan = true;
            for = "unix";
          }
        ];

        image = [
          {
            run = "xdg-open %s";
            orphan = true;
            for = "linux";
          }
        ];

        pdf = [
          {
            run = "xdg-open %s";
            orphan = true;
            for = "linux";
          }
        ];

        open = [
          {
            run = "xdg-open %s";
            desc = "Open";
            for = "linux";
          }
        ];

        bottles = [
          {
            run = ''bottles-cli run -b "Global" -e %s1'';
            orphan = true;
            for = "linux";
          }
        ];
      };

      open = {
        prepend_rules = [
          { url = "*.exe"; use = "bottles"; }
          { mime = "text/*"; use = "edit"; }
          { mime = "video/*"; use = "play"; }
          { mime = "image/*"; use = "image"; }
          { mime = "application/pdf"; use = "pdf"; }
        ];
      };

      plugin = {
        prepend_previewers = [
          { mime = "audio/*"; run = "exifaudio"; }
          { mime = "text/csv"; run = "miller"; }
          {
            mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
            run = "ouch";
          }
        ];

        prepend_fetchers = [
          { id = "git"; url = "*"; run = "git"; }
          { id = "git"; url = "*/"; run = "git"; }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "F";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize preview pane";
        }

        {
          on = [ "g" "d" ];
          run = "cd /home/drama/Downloads";
          desc = "Go to Downloads";
        }
        {
          on = [ "g" "v" ];
          run = "cd /home/drama/Videos";
          desc = "Go to Videos";
        }
        {
          on = [ "g" "p" ];
          run = "cd /home/drama/Pictures";
          desc = "Go to Pictures";
        }
        {
          on = [ "g" "m" ];
          run = "cd /home/drama/Music";
          desc = "Go to Music";
        }
        {
          on = [ "g" "3" ];
          run = "cd /home/drama/Graphics";
          desc = "Go to Graphics";
        }
        {
          on = [ "g" "G" ];
          run = "cd /mnt/hdd/Games";
          desc = "Go to Games";
        }
        {
          on = [ "g" "c" ];
          run = "cd /home/drama/dotfiles";
          desc = "Go to dotfiles";
        }
        {
          on = [ "g" "P" ];
          run = "cd /mnt/hdd/Projects";
          desc = "Go to Projects";
        }
        {
          on = [ "g" "H" ];
          run = "cd /mnt/hdd";
          desc = "Go to hdd";
        }
        {
          on = [ "g" "S" ];
          run = "cd /mnt/ssd";
          desc = "Go to ssd";
        }
        {
          on = [ "g" "D" ];
          run = "cd /mnt/dev";
          desc = "Go to dev";
        }

        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }

        {
          on = "m";
          run = "plugin bookmarks save";
          desc = "Save bookmark";
        }
        {
          on = "'";
          run = "plugin bookmarks jump";
          desc = "Jump to bookmark";
        }
        {
          on = [ "b" "d" ];
          run = "plugin bookmarks delete";
          desc = "Delete bookmark";
        }
        {
          on = [ "b" "D" ];
          run = "plugin bookmarks delete_all";
          desc = "Delete all bookmarks";
        }

        {
          on = [ "R" "o" ];
          run = "plugin recycle-bin -- open";
          desc = "Open Trash";
        }
        {
          on = [ "R" "e" ];
          run = "plugin recycle-bin -- empty";
          desc = "Empty Trash";
        }
        {
          on = [ "R" "D" ];
          run = "plugin recycle-bin -- emptyDays";
          desc = "Empty by days deleted";
        }
        {
          on = [ "R" "d" ];
          run = "plugin recycle-bin -- delete";
          desc = "Delete from Trash";
        }
        {
          on = [ "R" "r" ];
          run = "plugin recycle-bin -- restore";
          desc = "Restore from Trash";
        }
      ];
    };
  };
}
