if [ "$(id -u)" -ne 0 ]; then
SUDO="sudo"
else
SUDO=""
fi

$SUDO apt update | tee -a "$LOG_FILE"
$SUDO apt upgrade | tee -a "$LOG_FILE"
#$SUDO apt update | tee -a "$LOG_FILE"
