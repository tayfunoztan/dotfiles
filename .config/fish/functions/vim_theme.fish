function vim-theme --argument theme
  if ! test -f ~/.config/nvim/init.vim
    echo "file ~/.config/nvim/init.vim doesn't exist"
    return
  end

  # sed doesn't like symlinks, get the absolute path
  set -l config_path (realpath ~/.config/nvim/init.vim)

  # sed -i "" -e "s#^set background= \**#colors: *$theme#g" $config_path
  sed -e 's/set background=([a-z]+):set background=$theme' $config_path

  echo "switched to $theme."
end 
