function alacritty_font --argument fontsize
  if ! test -f ~/.alacritty.yml
    echo "file ~/.alacritty.yml doesn't exist"
    return
  end

  # sed doesn't like symlinks, get the absolute path
  set -l config_path (realpath ~/.alacritty.yml)

  sed -i "" -e "s#size: ....#size: $fontsize#g" $config_path

  echo "fontsize set to $fontsize"
end
