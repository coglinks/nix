
{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
    defaultEditor = true;
    viAlias = true;
    plugins = [
      pkgs.vimPlugins.image-nvim
      pkgs.vimPlugins.markview-nvim
      pkgs.vimPlugins.quarto-nvim
      pkgs.vimPlugins.blink-cmp
      pkgs.vimPlugins.jupytext-nvim
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.molten-nvim
      pkgs.vimPlugins.snacks-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.fzf-lua
      pkgs.vimPlugins.outline-nvim
      {
        plugin = pkgs.vimPlugins.sqlite-lua;
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}'";
      }
      {
        plugin = pkgs.vimPlugins.blink-cmp;
      }
    ];
    extraLuaConfig = ''
    dofile(vim.fn.stdpath("config") .. "/user-init.lua")
    '';
  };
  home.packages = with pkgs; [
    mercurialFull
    lua-language-server
    quarto
    rocmPackages.llvm.clang # cli #compiler
    tree-sitter
    ripgrep
    aider-chat
    sqlite
    libgcc
    libgcc    deno
    marksman
    nodejs
    python313Packages.pylatexenc
    luajitPackages.jsregexp
    lua5_1 # cli #programming-language
    luarocks # cli #package-manager
  ];
}
