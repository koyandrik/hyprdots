git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd 
cd hyprdots
yay -S brightnessctl nwg-look qt6ct pamixer nwg-look hyprlock wpgtk pywal wlogout pavucontrol nautilus gnome-keyring qt5ct qt6ct xdg-desktop-portal-hyprland libnotify rofi cliphist grim cava playerctl python ttf-font-awesome fastfetch ttf-jetbrains-mono-nerd bluez bluez-utils blueman waybar hyprpaper firefox
cp -r .bashrc ~/
cp -r .bash_profile ~/
cp -r .local ~/
cp -r .config ~/
cp -r wallpapers ~/
cp -r myenv ~/
wal -i ~/wallpapers/1.jpg
clear
sleep 2
echo "Welcome to my Hypr Setup"
sleep 1
chmod +x re-name.sh
/usr/lib/xdg-desktop-portal -rv
chmod +x .local/share/bin/volumecontrol.sh
chmod +x .local/share/bin/brightnesscontrol.sh
chmod +x .local/share/bin/globalcontrol.sh
clear
./re-name.sh
sleep 1
echo "Enter:  win+m"
