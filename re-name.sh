#!/bin/bash

if [ -z "$1" ]; then
    read -p "Enter username: " USERNAME
else
    USERNAME="$1"
fi

FILE="$HOME/.config/waybar/style.css"

sed -i "s#/home/kdrik#/home/$USERNAME#g" "$FILE"

echo "okey /home/$USERNAME в $FILE."
