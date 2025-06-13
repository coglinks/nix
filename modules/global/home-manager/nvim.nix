
{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
		viAlias = true;
		plugins = [
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
		aider-chat
		sqlite
		libgcc
    libgcc #nvim dependancy
		deno
		marksman
    nodejs
		python313Packages.pylatexenc
		luajitPackages.jsregexp
    lua5_1 # cli #programming-language
    luarocks # cli #package-manager
	];

	# Fallback
	programs.vim.enable = true;
}
