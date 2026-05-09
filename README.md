# Sigma dotfiles

## About

This repo contains all the necessary tools to configure Arch from live ISO to working and configured desktop environment with just a few commands. The end result is an operating system with only the necessary tools for me to use the machine. While it's tailored specifically for me anyone can use this repo and do anything with it. Enjoy:D

## Usage

While in live ISO connect to the Internet. You can do that with `iwctl` when using Wi-Fi with this command:

```sh
iwctl station <interface> connect <SSID>
```

After that you need to install `git` and clone the dotfiles.

```sh
pacman -Sy git && git clone https://codeberg.org/marcel-zdziechowicz/dotfiles.git
```

Then edit `dotfiles/scripts/variables.sh` with the editor of your choice and set the variables to fit your needs best. For example:

```sh
vim dotfiles/scripts/variables.sh
```

Now the last part of the live ISO config is running the script

```sh
chmod +x dotfiles/scripts/live-iso-conf.sh
dotfiles/scripts/live-iso-conf.sh
```

Now your Arch should be ready to boot. Reboot the machine, login to your account with credentials specified earlier in the `variables.sh` and follow next steps.

```sh
reboot
```

This part is for now split into separate scripts, but it's still faster than if you were to install everything manually

```sh
cd dotfiles/scripts
./install.sh
./sys-conf.sh
./user-conf.sh
./cleanup.sh
```

After that your machine is set up. You can access the desktop environment with:

```sh
start-hyprland
```
