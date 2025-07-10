{ pkgs, ... }:
{
  programs.git = {
    userName = "incogshift";
    userEmail = "incog267@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
    enable = true;
    lfs.enable = true;
  };
  home.packages = with pkgs; [
    git-crypt # cli #encryption #git-tools
    lazygit # tui #vcs #git-tools
    git-remote-gcrypt # cli #encryption-plugin-for-git #git-tools
    git-credential-manager
    git-annex-remote-rclone
  ];
}
