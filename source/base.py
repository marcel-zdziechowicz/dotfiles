import shutil
import decman
from decman.plugins import pacman, aur

class BaseModule(decman.Module):

    def __init__(self):
        super().__init__("base")

    @pacman.packages
    def pkgs(self) -> set[str]:
        retval = {}

        if shutil.which("efibootmgr"):
            retval |= { "efibootmgr" }

        return retval | {
            "base",
            "base-devel",
            "linux",
            "linux-firmware",
            "intel-ucode",
            "sudo",
            "zsh",
            "networkmanager",
            "neovim",
            "python",
            "man",
            "man-pages",
            "texinfo",
            "git"
        }

    @aur.packages
    def aurpkgs(self) -> set[str]
        return { "decman" }
