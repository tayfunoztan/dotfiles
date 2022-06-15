#------------------------------------------------------------------------------
# ALIASES
#------------------------------------------------------------------------------
alias ls="ls -la --color=auto"
alias grep='grep --color'
alias vi='nvim'
alias vim='nvim'


zmodload zsh/datetime

# ZSH only and most performant way to check existence of an executable
# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
exists() { (( $+commands[$1] )); }

# _comp_options+=(globdots) # Include hidden files.

if exists brew; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# Init completions
autoload -Uz compinit
compinit

autoload -U colors && colors # Enable colors in prompt

#-------------------------------------------------------------------------------
#           SOURCE PLUGINS
#-------------------------------------------------------------------------------
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#-------------------------------------------------------------------------------
#               COMPLETION
#-------------------------------------------------------------------------------
# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# persistent reshahing i.e puts new executables in the $path
# if no command is set typing in a line will cd by default
zstyle ':completion:*' rehash true

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
# Style the group names
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# Added by running `compinstall`
zstyle ':completion:*' expand suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
# End of lines added by compinstall

# Make completion:
# (stolen from Wincent)
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#-------------------------------------------------------------------------------
#               OPTIONS
#-------------------------------------------------------------------------------
setopt AUTO_CD
setopt RM_STAR_WAIT
setopt CORRECT                  # command auto-correction
setopt COMPLETE_ALIASES
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt AUTOPARAMSLASH            # tab completing directory appends a slash
setopt SHARE_HISTORY             # Share your history across all your terminal windows
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt AUTO_PUSHD                # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.

# Keep a ton of history.
HISTSIZE=2048
SAVEHIST=2048
# HISTFILE=$ZSH_CACHE_DIR/.zsh_history

#-------------------------------------------------------------------------------
#               VI-MODE
#-------------------------------------------------------------------------------
# # @see: https://thevaluable.dev/zsh-install-configure-mouseless/
# bindkey -v # enables vi mode, using -e = emacs
# export KEYTIMEOUT=1

# # Add vi-mode text objects e.g. da" ca(
# autoload -Uz select-bracketed select-quoted
# zle -N select-quoted
# zle -N select-bracketed
# for km in viopp visual; do
#   bindkey -M $km -- '-' vi-up-line-or-history
#   for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
#     bindkey -M $km $c select-quoted
#   done
#   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#     bindkey -M $km $c select-bracketed
#   done
# done
# # Mimic tpope's vim-surround
# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -M vicmd cs change-surround
# bindkey -M vicmd ds delete-surround
# bindkey -M vicmd ys add-surround
# bindkey -M visual S add-surround

# # https://superuser.com/questions/151803/how-do-i-customize-zshs-vim-mode
# # http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
# vim_insert_mode="aaaaaaaaa"
# vim_normal_mode="%F{green} %f"
# vim_mode=$vim_insert_mode

# function zle-line-finish {
#   vim_mode=$vim_insert_mode
# }
# zle -N zle-line-finish

# # When you C-c in CMD mode and you'd be prompted with CMD mode indicator,
# # while in fact you would be in INS mode Fixed by catching SIGINT (C-c),
# # set vim_mode to INS and then repropagate the SIGINT,
# # so if anything else depends on it, we will not break it
# function TRAPINT() {
#   vim_mode=$vim_insert_mode
#   return $(( 128 + $1 ))
# }

# cursor_mode() {
#   # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#   cursor_block='\e[2 q'
#   cursor_beam='\e[6 q'

#   function zle-keymap-select {
#     vim_mode="${${KEYMAP/vicmd/${vim_normal_mode}}/(main|viins)/${vim_insert_mode}}"
#     zle && zle reset-prompt

#     if [[ ${KEYMAP} == vicmd ]] ||
#         [[ $1 = 'block' ]]; then
#         echo -ne $cursor_block
#     elif [[ ${KEYMAP} == main ]] ||
#         [[ ${KEYMAP} == viins ]] ||
#         [[ ${KEYMAP} = '' ]] ||
#         [[ $1 = 'beam' ]]; then
#         echo -ne $cursor_beam
#     fi
#   }

#   zle-line-init() {
#     echo -ne $cursor_beam
#   }

#   zle -N zle-keymap-select
#   zle -N zle-line-init
# }

# cursor_mode

#-------------------------------------------------------------------------------
#               Version control
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#               Prompt
#-------------------------------------------------------------------------------
setopt PROMPT_SUBST

# PROMPT="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT="%(?:%{$fg_bold[green]%}$:%{$fg_bold[red]%}$)"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function git_prompt_info() {
  local ref
  if [[ "$(command git config --get customzsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')

  if [[ "$(command git config --get customzsh.hide-dirty)" != "1" ]]; then
    FLAGS+='--ignore-submodules=dirty'
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi

  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}


#-------------------------------------------------------------------------------
#  Functions
#-------------------------------------------------------------------------------
function usego() {
  version=$1
  if [ -z $version ]; then
    echo "Usage: usego [version]"
    return
  fi

  go_bin_path=$(command -v "go$version")

  if ! command -v "go$version" > /dev/null 2>&1; then
    echo "go ${version} does not exist, installing with commands: "
    echo "  go install golang.org/dl/go${version}@latest"
    echo "  go${version} download"
    echo ""

    go install "golang.org/dl/go${version}@latest"
    go${version} download
    go_bin_path=$(command -v "go${version}")
  fi

  echo "Switched to ${go_bin_path}"
  ln -sf "$go_bin_path" "$GOBIN/go"
}

#-------------------------------------------------------------------------------
#  PLUGINS
#-------------------------------------------------------------------------------
if exists zoxide; then
  eval "$(zoxide init zsh)"
fi

#-------------------------------------------------------------------------------
#               MAPPINGS
#-------------------------------------------------------------------------------
export KEYTIMEOUT=1
# bindkey ‘^R’ history-incremental-search-backward
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^U' autosuggest-accept
bindkey '^]' clear-screen
bindkey '^e' end-of-line
bindkey '^f' forward-word

# Edit line in vim with v whilst in normal mod in vi mode
# autoload -Uz edit-command-line;
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
