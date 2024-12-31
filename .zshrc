#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export EDITOR= zed
export VISUAL= zed
export TERMINAL=kitty

# Show all possibilities
bindkey '^I' expand-or-complete

eval "$(zoxide init zsh)"


#Andriod
export ANDROID_SDK_ROOT=/home/mvgs/Android/Sdk
export ANDROID_HOME=/home/mvgs/Android/Sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

#lua
export LUA_PATH="$HOME/.luarocks/share/lua/5.4/?.lua;$LUA_PATH"
export LUA_CPATH="$HOME/.luarocks/lib/lua/5.4/?.so;$LUA_CPATH"


# Aliases
alias vim="nvim"

alias runa="npx expo run:android"


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

# Basic Git Commands
alias gs='git status'          # Show the working tree status
alias gpl='git pull'            # Fetch and merge changes from the remote repository
alias gd='git diff'            # Show changes between commits, working tree, etc.
alias ga='git add .'           # Stage all changes for the next commit
alias gc='git commit -m'       # Commit with a message
alias gco='git checkout'       # Switch branches or restore working tree files
alias gb='git branch'          # List, create, or delete branches
alias gcb='git checkout -b'    # Create and switch to a new branch

function gps() {
  # Check if the current directory is a Git repository
  if [ ! -d ".git" ]; then
    # If not a Git repo, ask the user if they want to create a new repo
    echo "This is not a Git repository."
    echo "Do you want to initialize a new repo? (y/n): "
    read create_repo
    if [[ "$create_repo" =~ ^[Yy]$ ]]; then
      # Prompt for the repository name
      echo "Enter the repository name: "
      read repo_name

      # Initialize the new Git repository
      echo -e "${pine}Initializing a new Git repository...${reset}"
      git init || { echo -e "${gold}Git init failed. Exiting.${reset}"; return 1; }

      # Create a new repository on GitHub using GitHub CLI
      echo -e "${rose}Creating GitHub repository using 'gh'...${reset}"
      gh repo create "$repo_name" --public --confirm || { echo -e "${gold}GitHub repo creation failed. Exiting.${reset}"; return 1; }

      # Add the newly created GitHub repository as the remote
      git remote add origin "https://github.com/vigneshbalan-mvgs/$repo_name.git" || { echo -e "${gold}Failed to add remote. Exiting.${reset}"; return 1; }

      # Proceed with the commit and push
      echo -e "${rose}Adding changes...${reset}"
      git add . || { echo -e "${gold}Git add failed. Exiting.${reset}"; return 1; }

      echo -e "${rose}Committing changes...${reset}"
      git commit -m "Initial commit" || { echo -e "${gold}Git commit failed. Exiting.${reset}"; return 1; }

      echo -e "${pine}Pushing to remote...${reset}"
      git push -u origin master || { echo -e "${gold}Git push failed. Exiting.${reset}"; return 1; }

      echo -e "${pine}✔ New repository created and pushed successfully!${reset}"
      return 0
    else
      echo -e "${gold}Exiting. Not creating a new repository.${reset}"
      return 1
    fi
  fi

  # Use the current date and time as the default commit message if not provided
  local msg=${1:-"Commit on $(date '+%Y-%m-%d %H:%M:%S')"}

  # Define Rose Pine-inspired colors
  local rose="\033[38;5;207m"  # Soft pink
  local pine="\033[38;5;151m"  # Soft green
  local gold="\033[38;5;214m"  # Soft gold
  local reset="\033[0m"

  # Add all changes to the staging area
  echo -e "${rose}Adding changes...${reset}"
  git add . || { echo -e "${gold}Git add failed. Exiting.${reset}"; return 1; }

  # Commit the changes with the provided message
  echo -e "${rose}Committing changes...${reset}"
  git commit -m "$msg" || { echo -e "${gold}Git commit failed. Exiting.${reset}"; return 1; }

  # Push the changes to the remote repository
  echo -e "${pine}Pushing to remote...${reset}"
  git push || { echo -e "${gold}Git push failed. Exiting.${reset}"; return 1; }

  # Success message
  echo -e "${pine}✔ Git push completed successfully!${reset}"
}

# Remote Operations
alias gp='git push'           # Push changes to the remote repository
alias gcl='git clone'          # Clone a repository into a new directory
alias gfetch='git fetch'       # Download objects and refs from another repository

# Log and History
alias gl='git log --oneline'   # Show a concise commit history
alias glg='git log --graph --oneline --all' # Display commits as a graph with one-line summaries
alias gsh='git show'           # Show details about a specific commit

# Merging and Rebasing
alias gmg='git merge'          # Merge branches
alias grb='git rebase'         # Reapply commits on top of another base tip

# Stashing
alias gstash='git stash'       # Save changes temporarily
alias gstashpop='git stash pop' # Apply the most recent stash

# Resetting and Cleaning
alias grs='git reset'          # Reset the current HEAD to a specified state
alias grh='git reset --hard'   # Reset and discard all local changes
alias gclean='git clean -fd'   # Remove untracked files and directories

# Tagging
alias gtag='git tag'           # List tags
alias gtagadd='git tag -a'     # Create an annotated tag
alias gtagpush='git push origin --tags' # Push all tags to the remote

# Cherry-Picking
alias gcpick='git cherry-pick' # Apply a specific commit from another branch

# Aliases for Quick Updates
alias gup='git fetch && git pull' # Fetch and pull updates from the remote
alias gsync='git fetch --all && git pull --all' # Sync all branches with remote

# File Operations
alias gblame='git blame'       # Show what revision and author last modified each line of a file
alias gundo='git checkout --'  # Discard local changes in a file

# Branch Cleanup
alias gbd='git branch -d'      # Delete a branch
alias gbda='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d' # Delete all merged branches

# Submodules
alias gsubup='git submodule update --init --recursive' # Initialize and update all submodules
alias gsubsync='git submodule sync --recursive'        # Sync submodules with remote

# Miscellaneous
alias gclonebare='git clone --bare'   # Clone a repository as a bare repo
alias gdiffstaged='git diff --staged' # Show differences of staged changes
alias gtags='git tag --list'          # List all tags



# KeyMaps
alias ll='ls -la'
alias la='ls -a'
alias lg='lazygit'
alias ld='lazydocker'
alias anid='ani-cli --dub'
alias ani='ani-cli'
alias anisc='ani-cli -c'
alias anidc='ani-cli --dub -c'
alias anicr='ani-cli --rofi -c'
alias anidcr='ani-cli --dub -c --rofi'
alias anidr='ani-cli --dub --rofi'
alias btop='btop --utf-force'
alias tof='tmux set-option status off'
alias ton='tmux set-option status on'
alias ..='cd ..'
alias ...='cd ../..'
alias tmux='tmux -u'
alias msv='mpv "$(fd -e mp4 -e mkv -e avi -e mov -e flv -e wmv | fzf -m)"'
alias msm='mpv "$(fd -e mp3 -e wav -e flac -e aac -e ogg -e m4a | fzf -m)"'
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
  dir=$(find ~/*/*/ -type d | fzf)
  [ -n "$dir" ] && cd "$dir"
}
lsg() {
  local dir
  dir=$(ls -d ~/git/*/ | fzf)
  [ -n "$dir" ] && nvim "$dir"
}

lsp() {
  local dir
  dir=$(ls -d ~/git/personal/*/  | fzf)
  [ -n "$dir" ] && nvim "$dir"
}

lsv() {
  nvim $(fzf)
}

lsw(){
  local dir
  dir=$(find ~/git/Work/*/ -type d | fzf)
  [ -n "$dir" ] && cd "$dir"
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
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

# bun completions
[ -s "/home/mvgs/.bun/_bun" ] && source "/home/mvgs/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
