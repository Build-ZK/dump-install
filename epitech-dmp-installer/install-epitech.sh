#!/bin/bash

echo "Start installation script for epitech"

### BASE ###
sudo apt update && sudo apt -y upgrade
echo "Packages updated."
sudo apt -y install curl
echo "curl installed."
sudo apt -y install wget
echo "wget installed."
sudo apt -y install git
echo "git installed."
sudo apt -y install make
echo "make installed."
sudo apt -y install terminator
echo "terminator installed."
sudo apt -y install tree
echo "tree installed."
sudo apt -y install gcc
echo "gcc installed."
sudo apt -y install valgrind
echo "valgrind installed."
sudo apt -y install neofetch
echo "neofetch installed."

### LIB ###
sudo apt -y install libncurses6
echo "ncurses installed."
sudo apt -y install libcsfml-dev
echo "csfml installed."

### EMACS ###
sudo apt -y install emacs
echo "emacs installed."
sudo git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
sudo git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh local
echo "Epitech Emacs installed."
cd .. && sudo rm -rf epitech-emacs

### CRITERION ###
sudo curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.0/criterion-2.4.0-linux-x86_64.tar.xz" -o criterion-2.4.0.tar.xz
sudo tar xf criterion-2.4.0.tar.xz
sudo cp -r criterion-2.4.0/* /usr/local/
sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
sudo ldconfig
echo "Criterion installed."
sudo rm -rf criterion-2.4.0.tar.xz criterion-2.4.0/

### CODING-STYLE-CHECKER ###
sudo apt -y install docker
echo "docker installed."
sudo apt -y install docker-compose
echo "docker-compose installed."
sudo cp coding-style.sh /usr/bin/coding-style
sudo chmod +x /usr/bin/coding-style
echo "coding-style-checker installed."

### ZSH ###
echo "Do you want to install oh-my-zsh and my config ? (y/n)"
read install_zsh
if [[ "$install_zsh" == "y" ]]; then
    sudo apt -y install zsh
    echo "zsh installed."
    sudo apt -y install zsh-syntax-highlighting
    echo "zsh-syntax-highlighting installed."
    sudo apt -y install zsh-autosuggestions
    echo "zsh-autosuggestions installed."
    sudo apt -y install zsh-common
    echo "zsh-common installed."
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo cp zk.zsh-theme $HOME/.oh-my-zsh/themes/
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="zk"/' ~/.zshrc
    echo "zsh configurations copied."
    echo "Do you want to import your aliases ? (y/n)"
    read answer
    if [[ "$answer" == "y" ]]; then
        echo "Please specify the path of the alias file : "
        read alias_file
        if [ -f "$alias_file" ]; then
            if grep -qE '^alias [a-zA-Z0-9_]+\=' "$alias_file"; then
                sudo sh -c "echo '\n# Custom Aliases\n' >> $HOME/.oh-my-zsh/themes/zk.zsh-theme"
                sudo sh -c "cat '$alias_file' >> $HOME/.oh-my-zsh/themes/zk.zsh-theme"
                echo "Alias loaded."
            else
                echo  "The specified alias file does not contain valid aliases."
            fi
        else
            echo "File not found."
        fi
    else
        echo "alias aborted"
    fi
else
    echo "zsh aborted"
fi

### BOOT MENU ###
echo "Do you want to change grub ? (y/n)"
read grub
if [[ "$grub" == "y" ]]; then
    sudo cp -r themes/ /boot/grub/
    echo "Themes copied to /boot/grub/."
    sudo cp grub /etc/default/grub
    echo "GRUB configurations copied."
    sudo update-grub
    echo "GRUB updated."
else
    echo "grub aborted"
fi

### SSH-KEY ###
echo "Do you want to generate ssh key ? (y/n)"
read ssh_key
if [[ "$ssh_key" == "y" ]]; then
    echo "Your email : "
    read email
    ssh-keygen -t ed25519 -C "$email"
    echo "SSH key generated."
    echo "Your public key : (copy it and paste it in your github account)"
    cat ~/.ssh/id_ed25519.pub
    sleep 15
else
    echo "ssh key aborted"
fi

echo "Installation completed!"
