#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=vim
export TERMINAL=kitty

#show all the possibilites
bind "set show-all-if-ambiguous on"

alias vim="nvim"

# Color codes
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
MAGENTA='\[\033[0;35 \]'
CYAN='\[\033[0;36m\]'
WHITE='\[\033[0;37m\]'
RESET='\[\033[0m\]'

export PS1="${GREEN}\u${WHITE}@${BLUE}\h${WHITE}:${YELLOW}\w${WHITE}\$ ${RESET}"

# KeyMaps
alias ll='ls -la'
alias la='ls -a'
alias lg='lazygit'
alias ld='lazydocker'
alias btop='btop --utf-force'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias tof='tmux set-option status off'
alias ton='tmux set-option status on'
alias ..='cd ..'
alias ...='cd ../..'
alias tmux='tmux -u'
alias msv='mpv "$(fd -e mp4 -e mkv -e avi -e mov -e flv -e wmv | fzf)"'

alias msm='mpv "$(fd -e mp3 -e wav -e flac -e aac -e ogg -e m4a | fzf)"'
#nvim files only

#open function
#1234

op() {
	local file

	# If no arguments are provided, use fzf to select a file
	if [ -z "$1" ]; then
		file=$(fzf)
		# Check if fzf was canceled
		if [ -z "$file" ]; then
			echo "Selection canceled"
			return 1
		fi
	else
		file="$1"
	fi

	case "${file,,}" in
	*.txt | *.md | *.sh | *.py | *.c | *.cpp | *.java | *.html | *.css | *.js)
		nvim "$file"
		;;
	*.pdf | *.epub | *.mobi)
		koodo-reader "$file"
		;;
	*.mp4 | *.mkv | *.avi | *.mov | *.flv | *.wmv)
		mpv "$file"
		;;
	*.mp3 | *.wav | *.flac | *.aac | *.ogg | *.m4a)
		mpv "$file"
		;;
	*.jpg | *.jpeg | *.png | *.gif | *.bmp | *.tif | *.tiff)
		feh "$file"
		;;
	*)
		xdg-open "$file" 2>/dev/null || open "$file"
		;;
	esac
}

#find the direactory

lsd() {
	local dir
	dir=$(find ~ -type d | fzf)
	[ -n "$dir" ] && cd "$dir"
}
lsv() {
	nvim $(fzf)
}
lsz() {
	zeditor $(fzf)
}

gc() {
	git clone
}
# Increase history size
HISTSIZE=10000
HISTFILESIZE=20000

# Avoid duplicate entries
HISTCONTROL=ignoredups:erasedups

# Append to the history file, don't overwrite it
shopt -s histappend

HISTTIMEFORMAT="%d/%m/%y %T "

mkcd() {
	mkdir -p "$1" && cd "$1"
}

# Function to parse Git branch
parse_git_branch() {
	git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Function to show the current directory name
parse_directory() {
	basename "$PWD"
}

# Function to show the timestamp
show_timestamp() {
	if [ "$PWD" == "$HOME" ]; then
		# Show current time in home directory
		date "+ %m-%d %H:%M"
	else
		# Show last modified time of .bashrc in other directories
		date "+ %m-%d %H:%M"
	fi
}

# Minimal PS1 prompt: username, current folder name, Git branch on one line, timestamp on the next line, input on the next line
export PS1="   \u  \[\033[01;34m\]\W \[\033[01;36m\]\$(parse_git_branch) "

# Add these lines to your .bashrc
# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
	eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

#
#historyappend

fzf_history_append() {
	# Use fzf to search through the history and select a command
	local selected_command=$(history | awk '{$1=""; print substr($0,2)}' | fzf --tac)

	# If a command was selected, append it to the history and execute it
	if [ -n "$selected_command" ]; then
		history -s "$selected_command"
		READLINE_LINE="$selected_command"
		READLINE_POINT=${#selected_command}
		echo "Appended to history: $selected_command"
		# Execute the selected command
		eval "$selected_command"
	else
		echo "No command selected."
	fi
}

# Bind the function to Ctrl+r
bind -x '"\C-r": fzf_history_append'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

fastfetch
export PATH=$HOME/.local/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
