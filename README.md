# Sigma dotfiles

## About

This repo contains all the necessary tools to configure Arch from live ISO or OpenBSD (after installation) to working and configured desktop environment with just a few commands. The end result is an operating system with only the necessary tools to efficiently use the machine. While it's tailored specifically for me anyone can use this repo and do anything with it. Enjoy:D

## Arch Installation Guide

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
chmod +x dotfiles/scripts/arch/live-iso-conf.sh
dotfiles/scripts/arch/live-iso-conf.sh
```

Now your Arch should be ready to boot. Reboot the machine, login to your account with credentials specified earlier in the `variables.sh` and continue following next steps.

```sh
reboot
```

And after you log in just run:

```sh
dotfiles/scripts/arch/postinstall.sh
```

And that's it. Your machine is set up. You can access the desktop environment with:

```sh
start-hyprland
```

## OpenBSD Configuration Guide

Since OpenBSD isn't installed the same way Arch Linux is (or I am ignorant - sorry in advance) I created a set of scripts to configure my machine and bundled them all in one `postinstall.sh`. In order to run this script you need to establish an Internet connection and install `git` and `bash`. Anyway here are the steps:

Let's configure the doas.conf...just kidding. The default configuration will do, but we need to create the file at /etc/doas.conf. So let's type

```sh
su
cp /etc/examples/doas.conf /etc/doas.conf
```

To connect to WiFi just run:


```sh
ifconfig <interface> nwid "SSID" wpakey "PASSPHRASE"
dhcpleasectl <interface>
```

Now let's leave the root in peace

```sh
exit
```

Almost there. Now, install `git` and `bash`

```sh
doas pkg_add git bash
```

Clone the dotfiles

```sh
cd
git clone https://codeberg.org/marcel-zdziechowicz/dotfiles.git
```

Now edit the `dotfiles/scripts/variables.sh` with `vi` for example. Note, you only need to adjust the network settings (SSID and PASSPHRASE) and if you want OPENBSD_PKGS.

```sh
vi dotfiles/scripts/variables.sh
```

That's the last step. Run

```sh
chmod +x dotfiles/scripts/openbsd/postinstall.sh
dotfiles/scripts/openbsd/postinstall.sh
```

To access your desktop just type

```sh
startx
```
