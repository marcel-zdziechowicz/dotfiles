#!/usr/bin/env bash
RUN_SCRIPT="~/dotfiles/scripts/arch"

chmod +x ~/dotfiles/scripts/variables.sh
chmod -R +x "$RUN_SCRIPT"

"${RUN_SCRIPT}/install.sh"
"${RUN_SCRIPT}/sys-conf.sh"
"${RUN_SCRIPT}/user-conf.sh"
"${RUN_SCRIPT}/cleanup.sh"
