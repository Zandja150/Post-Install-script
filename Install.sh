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

# 1. Update Package Lists
echo ">>> Running: apt update" | tee -a "$LOG_FILE"
$SUDO apt update | tee -a "$LOG_FILE"

# 2. Upgrade installed packages (non-distro breaking)
echo -e "\n>>> Running: apt upgrade" | tee -a "$LOG_FILE"
$SUDO apt upgrade -y | tee -a "$LOG_FILE"

# 3. Perform Full System Upgrade (Handles Kernel/Major Updates)
echo -e "\n>>> Running: apt full-upgrade (Automatic Yes)" | tee -a "$LOG_FILE"
$SUDO apt full-upgrade -y | tee -a "$LOG_FILE"

# 4. Remove Obsolete/Unused Packages
echo -e "\n>>> Running: apt autoremove (Cleanup)" | tee -a "$LOG_FILE"
$SUDO apt autoremove -y | tee -a "$LOG_FILE"

# 5. Clean Package Cache
echo -e "\n>>> Running: apt clean (Clear cache)" | tee -a "$LOG_FILE"
$SUDO apt clean | tee -a "$LOG_FILE"

echo -e "\n--- Maintenance Complete ---" | tee -a "$LOG_FILE"
echo "Log saved to: $LOG_FILE"
