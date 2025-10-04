#!/bin/bash
# =========================================================
# System Maintenance Script for Debian/Proxmox
# =========================================================

set -e
LOG_FILE="/var/log/system_update_$(date +%Y%m%d_%H%M%S).log"
echo "Starting Full System Maintenance on $(hostname) at $(date)" | tee -a "$LOG_FILE"
echo "---------------------------------------------------------" | tee -a "$LOG_FILE"

# Determine if sudo is necessary
if [ "$(id -u)" -ne 0 ]; then
SUDO="sudo"
else
SUDO=""
fi

echo "__________                    .__                                         "
echo "\______   \ ____   ____  __ __|  | _____ _______                          "
echo " |       _// __ \ / ___\|  |  \  | \__  \\_  __ \                         "
echo " |    |   \  ___// /_/  >  |  /  |__/ __ \|  | \/                         "
echo " |____|_  /\___  >___  /|____/|____(____  /__|                            "
echo "        \/     \/_____/                 \/                                "
echo "__________               __    .___                 __         .__  .__   "
echo "\______   \____  _______/  |_  |   | ____   _______/  |______  |  | |  |  "
echo " |     ___/  _ \/  ___/\   __\ |   |/    \ /  ___/\   __\__  \ |  | |  |  "
echo " |    |  (  <_> )___ \  |  |   |   |   |  \\___ \  |  |  / __ \|  |_|  |__"
echo " |____|   \____/____  > |__|   |___|___|  /____  > |__| (____  /____/____/"
echo "                    \/                  \/     \/            \/           "
echo "  _________            .__        __                                      "
echo " /   _____/ ___________|__|______/  |_                                    "
echo " \_____  \_/ ___\_  __ \  \____ \   __\                                   "
echo " /        \  \___|  | \/  |  |_> >  |                                     "
echo "/_______  /\___  >__|  |__|   __/|__|                                     "
echo "        \/     \/         |__|                                            "
echo " By: Jacob/Zandja150							"

# 1. Sleep command to show the title ascii art
sleep 5

# 2. Update Package Lists
echo ">>> Running: apt update" | tee -a "$LOG_FILE"
$SUDO apt update | tee -a "$LOG_FILE"

# 3. Upgrade installed packages (non-distro breaking)
echo -e "\n>>> Running: apt upgrade" | tee -a "$LOG_FILE"
$SUDO apt upgrade -y | tee -a "$LOG_FILE"

# 4. Perform Full System Upgrade (Handles Kernel/Major Updates)
echo -e "\n>>> Running: apt full-upgrade (Automatic Yes)" | tee -a "$LOG_FILE"
$SUDO apt full-upgrade -y | tee -a "$LOG_FILE"

# 5. Perform Full System Upgrade (Handles Kernel/Major Updates)
echo -e "\n>>> installing net-tools (Automatic Yes)" | tee -a "$LOG_FILE"
$SUDO apt install net-tools -y | tee -a "$LOG_FILE"

# 6. Perform Full System Upgrade (Handles Kernel/Major Updates)
echo -e "\n>>> installing btop (Automatic Yes)" | tee -a "$LOG_FILE"
$SUDO apt install btop -y | tee -a "$LOG_FILE"

# 7. Perform Full System Upgrade (Handles Kernel/Major Updates)
echo -e "\n>>> installing neofetch (Automatic Yes)" | tee -a "$LOG_FILE"
$SUDO apt install neofetch -y | tee -a "$LOG_FILE"

# 8. Remove Obsolete/Unused Packages
echo -e "\n>>> Running: apt autoremove (Cleanup)" | tee -a "$LOG_FILE"
$SUDO apt autoremove -y | tee -a "$LOG_FILE"

# 9. Clean Package Cache
echo -e "\n>>> Running: apt clean (Clear cache)" | tee -a "$LOG_FILE"
$SUDO apt clean | tee -a "$LOG_FILE"

# 10. Displays finished ascii art
echo " ___________.___ _______  .___  _________ ___ ______________________    "
echo " \_   _____/|   |\      \ |   |/   _____//   |   \_   _____/\______ \   "
echo "  |    __)  |   |/   |   \|   |\_____  \/    ~    \    __)_  |    |  \  "
echo "  |     \   |   /    |    \   |/        \    Y    /        \ |    '   \ "
echo "  \___  /   |___\____|__  /___/_______  /\___|_  /_______  //_______  / "
echo "      \/                \/            \/       \/        \/         \/  "
