#!/bin/zsh

setopt extended_glob

wallpapers=("$HOME/wallpapers"/*.(jpg|gif|png)(N))
[[ -z $wallpapers ]] && exit 1

wallpaper_list=$(for wall in "${wallpapers[@]}"; do echo $wall; done | rofi -dmenu -p "Выберите обои:")

[[ -z $wallpaper_list ]] && exit 1

swww img "$wallpaper_list" --transition-type left --transition-duration 1 --transition-fps 30

[[ -f ~/myenv/bin/activate ]] && source ~/myenv/bin/activate
wpg -ns "$wallpaper_list" 2>/dev/null
wal -R 2>/dev/null

if [[ -f ~/.cache/wal/colors ]]; then
  active_border_color=$(sed -n '1p' ~/.cache/wal/colors)
  sed -i "s/col.active_border = .*/col.active_border = 0xff${active_border_color:5}/" ~/.config/hypr/cfg/general.conf
fi
