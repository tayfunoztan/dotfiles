# No greeting.
set fish_greeting
set fish_emoji_width 2

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command; end

# Aliases
# --------------------------------------------------------------------

# Better ls.
alias ll="ls -lha"

alias vim="nvim"

# Exports
# --------------------------------------------------------------------
# US English (UTF-8)
set -x LC_COLLATE en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x LC_MESSAGES en_US.UTF-8
set -x LC_MONETARY en_US.UTF-8
set -x LC_NUMERIC en_US.UTF-8
set -x LC_TIME en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x LESSCHARSET utf-8

# Set default editor to Vim.
set -x EDITOR nvim
set -x VISUAL nvim

# PATH
set -gxp PATH /usr/local/sbin $HOME/go/bin /usr/local/opt/openjdk@11/bin

set -gxp PATH $HOME/Library/Python/3.9/bin

# llvm PATH
# set -gxp PATH /usr/local/opt/llvm/bin

# GO
set -gx GOBIN $HOME/go/bin

# llvm PATH
set -gxp PATH ~/dev/flutter/bin

# Java
set JAVA_HOME /usr/local/Cellar/openjdk@11/11.0.10/libexec/openjdk.jdk/Contents/Home

# Fzf
export FZF_TMUX_OPTS='-p80%,60%'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

