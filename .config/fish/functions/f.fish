function f -d "Fuzzy-find and open a file in current directory"
  nvim (fzf-tmux --height 40% --info inline --border --reverse --preview 'bat --color=always {}')
end
