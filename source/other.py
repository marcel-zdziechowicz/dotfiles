import decman
from decman import pacman, aur

class OtherModule(decman.Module):
    def __init__(self):
        super().__init__("other")

    @pacman.packages
    def pkgs(self) -> set[str]:
        return {
            "brightnessctl",
            "dmenu",
            "python-gobject",
        }
