#!/bin/bash

## Copr Repos Setup
copr_repos=(
  "peterwu/iosevka"
  "lilay/topgrade"
)

# Enabling Copr Repos
for repo in "${copr_repos[@]}"; do
  sudo dnf copr enable "$repo"
done

# Installing Copr Packages
copr_pkgs=(
  "topgrade"
  "iosevka-term-ss14-fonts"
)

## DNF Installations

# General Software
dnf_pkgs=(
"zsh" "xournal" "ranger" "firewalld" "cryptsetup" "man" "kvantum" "brightnessctl" "playerctl" "pavucontrol" "golang-bin" "gnome-themes-extra" "gtk-murrine-engine" "cmake" "cpio" "meson" "cascadia-code-nf-fonts" "hyprutils-devel" "aquamarine-devel" "seahorse" "akmod-nvidia" "xorg-x11-drv-nvidia-cuda" "nmtui" "blueman" "etckeeper" "nm-applet"
)

styling=(
  "materia-gtk-theme" "papirus-icon-theme"
  )

# Python Packages
python_pkgs=(
  "python3-matplotlib" "python3-plotly"
)

# Dependencies
dependencies=(
  "wayland-protocols" "hyprpolkitagent" "git-credential-libsecret" "lua-5.1" "luarocks" "zathura-pdf-mupdf" "qt6ct" "qt5ct" "pamixer" "R-tinytex" "gcc" "gcc-c++" "make"
)

# Development Dependencies
devel_pkgs=(
  "udis86-devel" "mesa-libGLES-devel" "mesa-libGLU-devel" "libxkbcommon-devel" "libuuid-devel" "wayland-devel" "cairo-devel" "pango-devel" "pixman-devel" "libXcursor-devel" "libdrm-devel" "libinput-devel" "mesa-libgbm-devel" "glib2-devel" "hyprlang-devel" "hyprcursor-devel" "wayland-protocols-devel" "hyprwayland-scanner-devel" "xorg-x11-proto-devel" "xcb-util-errors-devel" "tomlplusplus-devel" "libgudev-devel" "hyprland-devel" "hyprland-protocols-devel" "R-devel" "libcurl-devel" "libxml2-devel" "openssl-devel"
)

# Merging all dnf packages into one array
official_fedora_pkgs=(
  "${copr_pkgs[@]}"
  "${dnf_pkgs[@]}"
  "${styling[@]}"
  "${solopasha_pkgs[@]}"
  "${python_pkgs[@]}"
  "${dependencies[@]}"
  "${devel_pkgs[@]}"
  "@virtualization"
)

# Install all DNF packages
sudo dnf install "${official_fedora_pkgs[@]}"

## Git Credential Helper Setup
git config --global credential.helper /usr/libexec/git-core/git-credential-libsecret

## Visual Studio Code Installation
vscode_repo="https://packages.microsoft.com/keys/microsoft.asc"
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo rpm --import "$vscode_repo"
sudo dnf check-update
sudo dnf install code

## Cargo Installations
cargo_pkgs=(
  "wallust" "cargo-update" "yazi-fm" "yazi-cli"
)

cargo install "${cargo_pkgs[@]}"

## Flatpak Installation
flatpak_pkgs=(
  "bitwarden"
)

flatpak install "${flatpak_pkgs[@]}"

## Hyprpm Installations
hyprpm_pkgs=(
  "https://github.com/raybbian/hyprtasking"
  "https://github.com/KZDKM/Hyprspace"
)

hyprpm update
for pkg in "${hyprpm_pkgs[@]}"; do
  hyprpm add "$pkg"
done
hyprpm enable Hyprspace

## Source Code Installation (nwg-look)
nwg_look_repo="https://github.com/nwg-piotr/nwg-look.git"
git clone "$nwg_look_repo"
cd nwg-look
make build
sudo make install

## Virtualization Setup 
sudo systemctl start libvirtd
sudo systemctl enable --now libvirtd
lsmod | grep kvm

## Optional Copr Software (sbctl)
# sbctl

## R Setup
sudo R -e "install.packages('xfun')"
sudo R -e "install.packages('rmarkdown', dependencies=TRUE)"
