{ pkgs, pkgs-stable, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs-stable.git;
      userName = "incogshift";
      userEmail = "incog267@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";
      };
      lfs.enable = true;
    };
    lazygit = {
      enable = true;
      package = pkgs-stable.lazygit;
      settings = {
        os.editPreset = "nvim";
      };
    };
  };
  home.packages = with pkgs-stable; [
    git-crypt # cli #encryption #git-tools
    git-remote-gcrypt # cli #encryption-plugin-for-git #git-tools
    git-credential-manager
    git-annex-remote-rclone
  ];
}
