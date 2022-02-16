function change_background --argument mode
  # change alacritty
  switch $mode
    case dark
      alacritty-theme gruvbox_dark
    case light
      alacritty-theme gruvbox_light
  end
end
