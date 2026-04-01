import decman
from decman.plugins import pacman, aur

class VirtualizationModule(decman.Module):
    def __init__(self):
        super().__init__("virtualization")

    @pacman.packages
    def pkgs(self) -> set[str]:
        return {
            "libvirt",
            "qemu-full",
            "virt-manager",
        }
