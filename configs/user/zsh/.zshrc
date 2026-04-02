zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/coffee/.zshrc'

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst
PROMPT=$'%F{blue}╭─%f %F{cyan}%n@%m%f %F{yellow}%~%f %F{magenta}${vcs_info_msg_0_}%f\n%F{blue}╰─➤ %f'

autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -e
bindkey '^[[Z' autosuggest-accept

export EDITOR=nvim
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=gtk3

eval "$(zoxide init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$PATH:/home/coffee/.spicetify
export PATH=$PATH:~/.spicetify
