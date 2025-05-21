# window mgr and sys utils
sys=(
  hyprland alacritty git trash-cli kitty waybar curl man tldr   nmtui zsh swaybg brightnessctl wget rsync  stow openssh networkmanager sudo sbctl libsecret
  )

# gui utils
gui=(
  swww swaylock swaync hyprpolkitagent blueman hyprlang hyprcursor cliphist seahorse rofi hyprlock hypridle grim slurp swappy 
  )

# pkg mgrs
pkgmgrs=(
  flatpak cargo R golang-bin pipx
  )

# editors
editors=(
  vim neovim xournal gimp pdftk
  )

# drivers
drivers=( akmod-nvidia xorg-x11-drv-nvidia-cuda
  )
# guaranteed dependencies
dependencies=(
  cmake cpio meson lua-5.1 luarocks hyprutils-devel aquamarine aquamarine-devel
  )

 # why:
 # cmake cpio meson = hyprpm
 # pamixer = controls volume
 # zathura-pdf-mupdf = pdf plugin for zathura
 # lua-5.1 luarocks = for lazy.nvim
 # R-devel R-tinytex gcc gcc-c++ make libcurl-devel libxml2-devel openssl-devel = for quarto

# maybe dependencies
# pacman -S --noconfirm udis86-devel mesa-libGLES-devel mesa-libGLU-devel libxkbcommon-devel libuuid-devel wayland-devel wayland-protocols cairo-devel pango-devel pixman-devel libXcursor-devel libdrm-devel libinput-devel mesa-libgbm-devel glib2-devel hyprlang-devel hyprcursor-devel wayland-protocols-devel hyprwayland-scanner-devel xorg-x11-proto-devel xcb-util-errors-devel tomlplusplus-devel libgudev-devel hyprland-devel hyprland-protocols-devel zathura-pdf-mupdf qt6ct qt5ct pamixer R-tinytex R-devel gcc gcc-c++ make libcurl-devel libxml2-devel openssl-devel

extras=(
  kvantum  playerctl pavucontrol gnome-themes-extra gtk-murrine-engine sassc materia-gtk-theme papirus-icon-theme   
  )
  
# apps i use
# multimedia: nautilus
# encryption: cryptsetup veracrypt

# storage utils
storageUtils=(
  borgbackup zip unzip btrfs-progs cryptsetup
  )

# browsers

browsers=(
  fzf zoxide firefox zathura feh mpv thunar
  )


# install cmd
pacstrap -K /mnt base linux linux-firmware linux-lts ${sys[@]} ${browsers[@]} ${storageUtils[@]} ${dependencies[@]} ${drivers[@]} ${editors[@]} ${pkgmgrs[@]} ${gui[@]} ${extras[@]}
