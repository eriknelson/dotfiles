#!/bin/bash
touchpadString="Synaptics"
touchpadID=$(xinput list | grep "$touchpadString" | awk -F " " '{print $6}' | awk -F "=" '{print $2}')
touchpadEnabled=$( \
  xinput list-props $touchpadID | \
  grep "Device Enabled" | awk -F ":" '{print $2}' | xargs echo)

echo "ID: $touchpadID"
echo "Enabled: $touchpadEnabled"

# Check for arguments on the command line
if [ $# -eq 1 ]; then               # Any arguments?
    arg1=$(echo $1 | tr [:upper:] [:lower:])    # Yes, convert to lower case
    cliArg=1                    # Set flag that we have one
else                        # There is no argument.
    cliArg=0                    # Clear flag
fi

if [ $cliArg -eq 1 ]; then          # Did we get an argument?
    if [ $arg1 = 'on' ]; then           # Yes, was it "on"?
    xinput --set-prop $touchpadID "Device Enabled" 1
                        # Yes, enable the touchpad
    elif [ $arg1 = 'off' ]; then        # No, was it "off"?
    xinput --set-prop $touchpadID "Device Enabled" 0
                        # Yes, disable the touchpad
    else                    # None of the above, so...
    sleep 1                 # ...sleep one second, exit
    fi

else                        # No argument, toggle state
    if [ $touchpadEnabled -eq 1 ]; then     # Enabled now?
    xinput --set-prop $touchpadID "Device Enabled" 0
                        # Yes, so disable it
    else                    # Must be disabled, so...
    xinput --set-prop $touchpadID "Device Enabled" 1
                        # ...enable it
    fi
fi
