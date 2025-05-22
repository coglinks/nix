{ ... }:

{
  xdg.desktopEntries = {
    bzmenu = {
      name = "bzmenu";
      exec = "bzmenu -l custom --launcher-command \"rofi -i -dmenu -kb-custom-1 Control-Delete -kb-custom-2 Alt-Delete -config ~/.config/rofi/launchers/type-3/config-clipboard.rasi\"";
      terminal = false;
      categories = ["Utility"];
    };
    iwmenu = {
      name = "iwmenu";
      exec = "iwmenu -l custom --launcher-command \"rofi -i -dmenu -kb-custom-1 Control-Delete -kb-custom-2 Alt-Delete -config ~/.config/rofi/launchers/type-3/config-clipboard.rasi\"";
      terminal = false;
      categories = ["Utility"];
    };
  };
}
