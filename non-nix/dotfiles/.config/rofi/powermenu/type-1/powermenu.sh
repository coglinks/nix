#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="~/.config/rofi/powermenu/type-1"
theme='style-1'

# Options

hibernatesh="h"
shutdownsh="p"
rebootsh="r"
logoutsh="l"

hibernate="${hibernatesh}) 󰒲 | Hibernate"
shutdown="${shutdownsh}) ⏻ | Poweroff"
reboot="${rebootsh})  | Reboot"
lock="${locksh})  | Lock"
suspend="${suspendsh}) 󰒲 | Suspend"
logout="${logoutsh}) 󰠚 | Logout"
yes='Yes'
no='No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
    -matching prefix \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$logout\n$reboot\n$shutdown\n$hibernate" | \
		rofi -dmenu \
		-theme "${dir}/${theme}.rasi" \
		-kb-custom-1 "${logoutsh}" \
		-kb-custom-2 "${rebootsh}" \
		-kb-custom-3 "${shutdownsh}" \
		-kb-custom-4 "${hibernatesh}"
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			playerctl pause
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
				hyprctl dispatch exit
    elif [[ $1 == '--hibernate' ]]; then
      systemctl hibernate
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    *Shutdown*) run_cmd --shutdown ;;
    *Reboot*) run_cmd --reboot ;;
    *Lock*) [[ -x '/etc/profiles/per-user/incogshift/bin/hyprlock' ]] && hyprlock ;;
    *Suspend*) run_cmd --suspend ;;
    *Logout*) run_cmd --logout ;;
    *Hibernate*) run_cmd --hibernate ;;
esac
