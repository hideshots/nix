{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim.imports = [
    ./treesitter.nix
    ./telescope.nix
    ./terminal.nix
    ./keymaps.nix
    ./yazi.nix
    ./core.nix
    ./lsp.nix
    ./ui.nix
  ];
}
