# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY 

# cargo
PATH=$PATH:~/.cargo/bin

# go path
PATH=$PATH:~/go/bin

# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Flatpak export path
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share:$XDG_DATA_DIRS

# Update PATH if not already in PATH
[[ ":$PATH:" != *":/home/incog267/.local/bin:"* ]] && export PATH=$PATH:/home/incog267/.local/bin

# Start SSH agent if not running and set SSH_AUTH_SOCK
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
export SSH_AUTH_SOCK=${SSH_AUTH_SOCK:-/run/user/$UID/keyring/ssh}

# Load Antidote for plugin management
source ~/.antidote/antidote.zsh

# export NVIM_LISTEN_ADDRESS=/tmp/nvim-server

antidote load

# Set up aliases
alias sup="~/custom/updates/updates.sh"
alias in="sudo dnf in -y"
alias un="sudo dnf rm -y"
alias se="dnf se"
alias bt-ear="echo '8C:64:A2:F2:A8:BD'; echo '8C:64:A2:F2:A8:BD' | wl-copy"

# Prompt setup
#NEWLINE=$'\n'
#PROMPT="%B%F{black}%K{green}%n%k%f%b %U%~%u ${NEWLINE}%% "
#RPROMPT="%F{green}%@%f"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim

# zoxide stuff
eval "$(zoxide init zsh)"

url() {
    local link="$1"
    local name="$2"
    local filepath="./${name}.url"

    echo "[InternetShortcut]
URL=${link}" > "$filepath"

    chmod +x "$filepath"
    echo "Shortcut created: $filepath"
}


if [ -e /home/incog267/.nix-profile/etc/profile.d/nix.sh ]; then . /home/incog267/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
