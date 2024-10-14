sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd 
cd hyprdots
yay -S brightnessctl pipewire nautilus gnome-keyring qt5ct qt6ct xdg-desktop-portal-hyprland rofi cliphist grim cava playerctl python ttf-font-awesome fastfetch ttf-jetbrains-mono-nerd bluez bluez-utils blueman waybar hyprpaper firefox
cp -r .bashrc ~/
cp -r .bash_logout ~/
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
./re-name.sh
echo "Enter:  win+m"
