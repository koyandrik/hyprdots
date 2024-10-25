#!/bin/zsh

setopt extended_glob

wallpapers=("$HOME/wallpapers"/*.(jpg|gif|png)(N))
[[ -z $wallpapers ]] && exit 1

index_file="$HOME/.config/hypr/last_wallpaper_index"

if [[ ! -f $index_file ]]; then
  echo 0 > "$index_file"
fi

index=$(<"$index_file")
wall=${wallpapers[index % ${#wallpapers[@]}]}
echo $(( (index + 1) % ${#wallpapers[@]} )) > "$index_file"

swww img "$wall" --transition-type left --transition-duration 1 --transition-fps 30

[[ -f ~/myenv/bin/activate ]] && source ~/myenv/bin/activate

wpg -ns "$wall" 2>/dev/null
wal -R 2>/dev/null

if [[ -f ~/.cache/wal/colors ]]; then
  active_border_color=$(sed -n '1p' ~/.cache/wal/colors)
  sed -i "s/col.active_border = .*/col.active_border = 0xff${active_border_color:5}/" ~/.config/hypr/cfg/general.conf
fi

sleep 1
