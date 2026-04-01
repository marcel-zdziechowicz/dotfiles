import decman
from decman.plugins import pacman

class HardwareModule(decman.Module):

    def __init__(self):
        super().__init__("hardware")

    @pacman.packages
    def pkgs(self) -> set[str]:
        return {
            "parted",
            "cups",
            "brlaser",
            "brother-dcp-l2530dw",
            "system-config-printer",
            "blueman",
            "bluez-utils",
            "alsa-utils",
            "pipewire-alsa",
            "pipewire-jack",
            "pipewire-pulse",
            "wireplumber",
            "dnsmasq",
            "fail2ban",
            "bridge-utils",
            "iptables-nft",
            "iwd",
            "network-manager-applet",
            "networkmanager",
            "ufw",
        }
