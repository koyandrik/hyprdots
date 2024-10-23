git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#install dots
cd 
cd hyprdots
yay -S brightnessctl python-pywalfox hyprshot nwg-look pamixer nwg-look hyprlock wpgtk pywal wlogout pavucontrol nautilus gnome-keyring xdg-desktop-portal-hyprland xdg-desktop-portal-gtk libnotify rofi cliphist grim cava playerctl python ttf-font-awesome fastfetch ttf-jetbrains-mono-nerd bluez bluez-utils blueman waybar hyprpaper firefox
cp -r .bashrc ~/
cp -r .local ~/
cp -r .config ~/
cp -r wallpapers ~/
cp -r myenv ~/
wal -i ~/wallpapers/2.jpg
clear
sleep 2
echo "Welcome to my Hypr Setup"
sleep 1
chmod +x .local/share/bin/volumecontrol.sh
chmod +x .local/share/bin/brightnesscontrol.sh
chmod +x .local/share/bin/globalcontrol.sh
sudo systemctl start bluetooth
clear
/usr/lib/xdg-desktop-portal -rv
clear
sleep 1
echo "Enter:  win+m"
