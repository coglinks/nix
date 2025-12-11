{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = # bash
      ''
        function bw-pretty
          bw list items $argv \
          | jq -r '.[] | [.name, .login.username, .login.password, .login.uris[0].uri] | @tsv' \
          | begin
              printf "Name\tUsername\tPassword\tURI\n"
              cat
            end \
          | column -t -s \t
        end
      '';
  };
}
