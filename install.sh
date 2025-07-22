#!/bin/bash

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "[i] The id_ed25519 file does not exist."
     read -p "Do you want to continue (y/n)? " choice

    case "$choice" in
        n|N )
            echo "Exiting..."
            exit 0
            ;;
        * )
            echo "Continuing..."
            exit 1
            ;;
    esac
fi


get_latest_github_release_file() {
    local repo="$1"
    local file_name="$2"

    latest_tag=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep '"tag_name":' | cut -d '"' -f 4)
    download_url="https://github.com/${repo}/releases/download/${latest_tag}/${file_name}"

    echo "$download_url"
}

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER



echo "[i] Installing Packages..."
sudo apt update && sudo apt upgrade -y

sudo apt-get install -y wget curl git thunar xclip alacritty seclists feroxbuster
sudo apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson 
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev 
sudo apt-get install -y libstartup-notification0-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-cursor-dev libxcb-keysyms1-dev libxcb-icccm4-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev libpcre2-dev libairo-dev librust-pangocairo-dev libev-dev

echo "[i] Installing Nerd Font..."
mkdir -p ~/.local/share/fonts/

echo "[i] Finding latest version of the JetBrainsMono nerd font..."
nerd_font_url=$(get_latest_github_release_file "ryanoasis/nerd-fonts" "JetBrainsMono.zip")
echo "Downloading JetBrainsMono nerd font from: $nerd_font_url"
wget "$nerd_font_url"

sudo unzip JetBrainsMono.zip -d /usr/local/share/fonts/
sudo fc-cache -fv

echo "[i] Setting up i3..."
git clone https://github.com/i3/i3 i3
cd i3 && mkdir -p build && cd build && meson ..
ninja
sudo ninja install
cd ../..

pip3 install pywal

echo "[i] Copying config..."
mkdir -p ~/.config/i3
mkdir -p ~/.config/compton
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
cp .config/i3/config ~/.config/i3/config
cp .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp .config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
cp .config/compton/compton.conf ~/.config/compton/compton.conf
cp .config/rofi/config ~/.config/rofi/config
cp .fehbg ~/.fehbg
cp .config/i3/clipboard_fix.sh ~/.config/i3/clipboard_fix.sh
cp -r .wallpaper ~/.wallpaper

echo "[i] Setting up tmux..."
cp .config/tmux/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

if [ -f ~/.ssh/id_ed25519 ]; then
	echo "[i] Cloning private Repositories..."
	git clone git@github.com:Ampferl/toolkit ~/.toolkit
	git clone --recurse-submodules git@github.com:Ampferl/hacking ~/hacking
fi

cp aliases.zsh ~/aliases.zsh
echo "source ~/aliases.zsh" >> ~/.zshrc


echo "[i] Setting up Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh

echo "[i] After the reboot select i3"
sudo reboot now
