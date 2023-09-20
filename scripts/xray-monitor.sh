#!/bin/sh

# Path to the Xray process
XRAY_PROCESS="/tmp/etc/passwall/bin/xray"

# Path to the Passwall service script
PASSWALL_SERVICE="/etc/init.d/passwall"

# Path to the monitor script
MONITOR_SCRIPT="/usr/share/passwall/monitor.sh"

# Continuous loop
while true; do
  # Check if /usr/share/passwall/monitor.sh is running
  if pgrep -f "$MONITOR_SCRIPT" >/dev/null; then
    # /usr/share/passwall/monitor.sh is running, which means Passwall service is running
    echo "Passwall service is running. Checking Xray status..."
    
    # Check if Xray is running
    if pgrep -f "$XRAY_PROCESS" >/dev/null; then
      echo "Xray is running."
    else
      echo "Xray is not running. Restarting Passwall..."
      $PASSWALL_SERVICE restart
    fi
  else
    echo "Passwall service is not running."
  fi
  
  sleep 30  # Sleep for x seconds before the next check
done
