
{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = false;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
    defaultEditor = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      image-nvim
      markview-nvim
      quarto-nvim
      lazy-nvim
      blink-cmp
      jupytext-nvim
      mason-nvim
      molten-nvim
      snacks-nvim
      telescope-nvim
      nvim-treesitter.withAllGrammars
      fzf-lua
      outline-nvim
      {
        plugin = sqlite-lua;
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}'";
      }
    ];
    extraLuaConfig = 
    # lua
    ''
    dofile(vim.fn.stdpath("config") .. "/user-init.lua")
    '';
  };
#  home.packages = with pkgs; [
#    mercurialFull
#    lua-language-server
#    quarto
#    rocmPackages.llvm.clang # cli #compiler
#    tree-sitter
#    ripgrep
#    aider-chat
#    sqlite
#    libgcc
#    libgcc    deno
#    marksman
#    nodejs
#    python313Packages.pylatexenc
#    luajitPackages.jsregexp
#    lua5_1 # cli #programming-language
#    luarocks # cli #package-manager
#  ];
}
