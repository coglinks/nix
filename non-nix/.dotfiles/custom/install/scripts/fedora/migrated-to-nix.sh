nix=(
"hyprland"
"discord"
"firefox"
"zathura"
"alacritty"
"xournalpp"
"git"
"trash-cli"
"kitty"
"waybar"
"gimp"
"stow"
"rofi"
"wget"
"wofi"
"nautilus"
"curl"
"rsync"
"neovim"
"grim"
"openssh"
"vim"
"slurp"
"swappy"
"swaynotificationcenter"
"cargo"
"mpv"
"flatpak"
"go"
"feh"
"pipx"
"swaybg"
"sassc"
"rofi"
"waybar"
"swaylock"
"hyprutils"
"aquamarine"
"hyprlang"
"hyprcursor"
"tldr"
"borgbackup"
"pdftk"
"fzf"
"zoxide"
"steam"
"wine"
"kicad"
"lutris"
)


old_dnf_pkgs=(
"firefox" "zathura" "zsh" "alacritty" "xournal" "ranger" "git" "trash-cli" "kitty" "waybar" "gimp" "stow" "firewalld" "rofi" "wget" "cryptsetup" "wofi" "nautilus" "curl" "man" "rsync" "neovim" "grim" "openssh" "vim" "slurp" "swappy" "swaync" "cargo" "mpv" "kvantum" "brightnessctl" "playerctl" "pavucontrol" "flatpak" "golang-bin" "feh" "pipx" "swaybg" "gnome-themes-extra" "gtk-murrine-engine" "sassc" "rofi" "cmake" "cpio" "meson" "waybar" "swaylock" "swaync" "cascadia-code-nf-fonts" "hyprutils" "hyprutils-devel" "aquamarine" "aquamarine-devel" "hyprlang" "hyprcursor" "tldr" "seahorse" "akmod-nvidia" "xorg-x11-drv-nvidia-cuda" "nmtui" "blueman" "borgbackup" "pdftk" "fzf" "zoxide" "steam" "wine" "kicad" "etckeeper" "lutris" "nm-applet"
)


# Convert arrays to associative arrays for faster lookup
declare -A nix_map
for item in "${nix[@]}"; do
  nix_map["$item"]=1
done

# Find and print elements in old_dnf_pkgs that are not in nix
for item in "${old_dnf_pkgs[@]}"; do
  if [[ -z "${nix_map["$item"]}" ]]; then
    echo "\"$item\""
  fi
done
