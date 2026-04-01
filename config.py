import decman
from decman import File, Directory

from "source/base.py" import BaseModule
from "source/hardware.py" import HardwareModule
from "source/desktop.py" import DesktopModule
from "source/dev-adm-tools.py" import DevAdmToolsModule
from "source/other.py" import OtherModule
decman.modules += [
    BaseModule(),
    HardwareModule(),
    DesktopModule(),
    DevAdmToolsModule(),
    OtherModule()
]
