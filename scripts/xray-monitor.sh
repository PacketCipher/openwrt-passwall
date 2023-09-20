#!/bin/sh

while true; do
    # Path to the Xray process
    XRAY_PROCESS="/tmp/etc/passwall/bin/xray"

    # Path to the Passwall service script
    PASSWALL_SERVICE="/etc/init.d/passwall"

    # Flag file to track the service's status
    SERVICE_FLAG="/var/run/passwall_status"

    # Check if Xray is running
    if ! pgrep -x "$(basename $XRAY_PROCESS)" >/dev/null; then
    echo "Xray is not running. Checking Passwall service status..."
    
    # Check if the Passwall service flag file exists (service was running before)
    if [ -f "$SERVICE_FLAG" ]; then
        echo "Passwall service is crashed. Restarting..."
        $PASSWALL_SERVICE restart
    else
        echo "Passwall service was not running before."
    fi
    else
    # If Xray is running, create or update the flag file
    touch "$SERVICE_FLAG"
    fi
    
    sleep 60  # Sleep for 60 seconds before the next check
done
