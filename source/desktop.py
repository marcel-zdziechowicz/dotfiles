import decman
from decman.plugins import pacman, aur

class DesktopModule(decman.Module):

    def __init__(self):
        super().__init__("desktop")

    @pacman.packages
    def pkgs(self) -> set[str]:
        return {
            "dunst",
            "arc-icon-theme-git",
            "bibata-cursor-theme",
            "breeze-gtk",
            "cliphist",
            "eog",
            "fuzzel",
            "grim",
            "hypridle",
            "hyprland",
            "hyprlock",
            "hyprpaper",
            "mpv",
            "brave-bin",
            "nwg-look",
            "polkit-kde-agent",
            "qt6ct",
            "thunar",
            "spicetify-cli",
            "spicetify-marketplace-bin",
            "spotify",
            "slurp",
            "wl-clipboard",
            "xdg-desktop-portal-hyprland",
            "wallust-git",
            "otf-font-awesome",
            "papirus-icon-theme",
            "waybar",
        }
