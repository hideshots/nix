if [ -r "$HOME/.antidote/antidote.zsh" ]; then
  source "$HOME/.antidote/antidote.zsh"
elif [ -r "/usr/share/antidote/antidote.zsh" ]; then
  source "/usr/share/antidote/antidote.zsh"
elif [ -r "$HOME/.local/share/antidote/antidote.zsh" ]; then
  source "$HOME/.local/share/antidote/antidote.zsh"
fi

zstyle ':antidote:bundle' use-friendly-names 'yes'
autoload -Uz compinit
compinit

(( $+functions[antidote] )) && antidote load "${ZDOTDIR:-$HOME}/.zsh_plugins.txt"

HISTSIZE=50000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

alias yay='paru'
alias vim='nvim'
alias vi='nvim'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'
alias ncdum='sudo ncdu --exclude /mnt /'
alias free='free -h'

nvdots() {
  command nvim ~/dotfiles/flake.nix
}
alias dfn='nvdots'
alias rebuild='sudo nixos-rebuild switch --flake ~/dotfiles#lenovo'
alias hms='home-manager switch --flake ~/dotfiles'

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

if command -v fzf >/dev/null 2>&1; then
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
    [ -f "$HOME/.nix-profile/share/fzf/key-bindings.zsh" ] && source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
    [ -f "$HOME/.nix-profile/share/fzf/completion.zsh" ] && source "$HOME/.nix-profile/share/fzf/completion.zsh"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

export EDITOR=nvim
export VISUAL=nvim
export MPD_HOST="$HOME/.config/mpd/socket"

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/home/horrid/.spicetify"
export PATH="$HOME/.local/share/npm-global/bin:$HOME/.local/bin:$PATH"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"

# bun completions
[ -s "/home/drama/.bun/_bun" ] && source "/home/drama/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
