# XDG Base Directory
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export TMUX_CONF="$XDG_CONFIG_HOME/tmux/tmux.conf"

# Keep $HOME free of stray dotfiles (see xdg-ninja).
# npm needs both: USERCONFIG stops it writing ~/.npmrc,
# CACHE stops it creating ~/.npm
export GOPATH="$XDG_DATA_HOME/go"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "${ZDOTDIR}/.zshrc"

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst
PROMPT=$'%F{blue}╭─%f %F{cyan}%n@%m%f %F{yellow}%~%f %F{magenta}${vcs_info_msg_0_}%f\n%F{blue}╰─➤ %f'

autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# HISTFILE must be set after compinit, which is why it is
# down here and not with the other XDG exports above.
mkdir -p "$XDG_STATE_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -e
bindkey '^[[Z' autosuggest-accept

export EDITOR=nvim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"

eval "$(zoxide init zsh)"

alias ls=eza
alias cat=bat
alias cd=z
# wget has no env var for the HSTS db, only this flag
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias reflect="sudo reflector --country Poland,Germany --latest 30 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.spicetify"
