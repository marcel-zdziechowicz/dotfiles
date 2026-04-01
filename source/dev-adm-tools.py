import decman
from decman.plugins import pacman, aur

class DevAdmToolsModule(decman.Module):

    def __init__(self):
        super().__init__("devadmtools")

    @pacman.packages
    def pkgs(self) -> set[str]:
        return {
            "nodejs",
            "npm",
            "bat",
            "btop",
            "clang",
            "eza",
            "fzf",
            "gdb",
            "ghostty",
            "git",
            "github-cli",
            "neovim",
            "luarocks",
            "qalculate-gtk",
            "zoxide",
            "yazi",
            "ripgrep",
            "yay",
            "yay-debug",
            "7zip",
            "seer-gdb",
            "unzip",
            "wget",
            "zip",
        }
