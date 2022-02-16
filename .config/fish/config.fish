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

abbr vim nvim
abbr vi nvim

# Better ls.
alias ll="ls -lha"

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
set -gx EDITOR nvim
set -gx VISUAL nvim

# PATH
fish_add_path /usr/local/opt/node@16/bin
# fish_add_path /usr/local/opt/llvm/bin
fish_add_path ~/Library/Python/3.9/bin
fish_add_path ~/dev/flutter/bin
fish_add_path  ~/Library/Android/sdk/tools/bin
fish_add_path  ~/dev/pact/bin

# GO
fish_add_path ~/go/bin
set -gx GOBIN ~/go/bin

# Java
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# Fzf
export FZF_TMUX_OPTS='-p80%,60%'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
