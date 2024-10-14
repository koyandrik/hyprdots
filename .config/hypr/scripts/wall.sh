#!/bin/env zsh

hyprctl hyprpaper unload all

wallpapers=($(ls -d ~/wallpapers/*.jpg  2>/dev/null))


wall=${wallpapers[$RANDOM % ${#wallpapers[@]}]}

hyprctl hyprpaper preload "$wall"
hyprctl hyprpaper wallpaper ,"$wall"


source ~/myenv/bin/activate

wpg -ns "$wall"

wal -R

active_border_color=$(sed -n '1p' ~/.cache/wal/colors)
sed -i "s/col.active_border = .*/col.active_border = 0xff${active_border_color:5}/" ~/.config/hypr/cfg/general.conf

hyprctl reload

sleep 2
