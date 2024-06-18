#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export TERMINAL=kitty

# Show all possibilities
bindkey '^I' expand-or-complete

# Aliases
alias vim="nvim"


source ${(q-)PWD}/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Color codes
RED='%F{red}'
GREEN='%F{green}'
YELLOW='%F{yellow}'
BLUE='%F{blue}'
MAGENTA='%F{magenta}'
CYAN='%F{cyan}'
WHITE='%F{white}'
RESET='%f'

# PS1 prompt
#export PS1='
#%{$GREEN%}   %n %{$YELLOW%}%F{blue}%1~%{$WHITE%}$(parse_git_branch) %{$MAGENTA%}$(parse_virtualenv)%{$RED%}$(parse_last_exit_status)%{$CYAN%} $(date +"%H:%M:%S") %{$WHITE%}%f
#\$ '
## Ensure Ctrl+P is bound to previous history entry
bindkey '^P' up-line-or-history
# KeyMaps
alias ll='ls -la'
alias la='ls -a'
alias lg='lazygit'
alias ld='lazydocker'
alias anid='ani-cli --dub'
alias anisc='ani-cli -c'
alias anidc='ani-cli --dub -c'
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

# Open function
op() {
  local file

  if [ -z "$1" ]; then
    file=$(fzf)
    if [ -z "$file" ]; then
      echo "Selection canceled"
      return 1
    fi
  else
    file="$1"
  fi

  case "${file:l}" in
    *.txt|*.md|*.sh|*.py|*.c|*.cpp|*.java|*.html|*.css|*.js)
      nvim "$file"
      ;;
    *.pdf|*.epub|*.mobi)
      koodo-reader "$file"
      ;;
    *.mp4|*.mkv|*.avi|*.mov|*.flv|*.wmv)
      mpv "$file"
      ;;
    *.mp3|*.wav|*.flac|*.aac|*.ogg|*.m4a)
      mpv "$file"
      ;;
    *.jpg|*.jpeg|*.png|*.gif|*.bmp|*.tif|*.tiff)
      feh "$file"
      ;;
    *)
      xdg-open "$file" 2>/dev/null || open "$file"
      ;;
  esac
}

# Find the directory
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
SAVEHIST=20000
HISTFILE=~/.zsh_history

# Avoid duplicate entries
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Append to the history file, don't overwrite it
setopt APPEND_HISTORY

# Timestamp format for history
HISTTIMEFORMAT="%d/%m/%y %T "

# Make directory and change to it
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
  if [ "$PWD" = "$HOME" ]; then
    date "+ %m-%d %H:%M"
  else
    date "+ %m-%d %H:%M"
  fi
}

# Minimal PS1 prompt: username, current folder name, Git branch on one line, timestamp on the next line, input on the next line
export PS1="   %n  %F{blue}%1~ %F{cyan}$(parse_git_branch) %f"

# Enable color support for ls and grep
if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# History append
fzf_history_append() {
  local selected_command=$(history | awk '{$1=""; print substr($0,2)}' | fzf --tac)

  if [ -n "$selected_command" ]; then
    history -s "$selected_command"
    BUFFER="$selected_command"
    zle accept-line
  else
    echo "No command selected."
  fi
}
zle -N fzf_history_append
bindkey '^R' fzf_history_append

if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

fastfetch
export PATH=$HOME/.local/bin:$PATH

