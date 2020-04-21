#!/bin/bash
set -e

# disable setup wizard
rm /etc/xdg/autostart/piwiz.desktop

# start vnc server
# ln -s /usr/lib/systemd/system/vncserver-x11-serviced.service /etc/systemd/system/multi-user.target.wants/vncserver-x11-serviced.service
systemctl start vncserver-x11-serviced
systemctl enable vncserver-x11-serviced

# wait 20 seconds for graphical login to complete
sleep 20

# inform user, that provisioning is finished DOES NOT WORK :(
# if [ -f "/home/pi/.Xauthority" ]; then
#   export DISPLAY=:0
#   export XAUTHORITY=~pi/.Xauthority
#   echo "Initial setup complete.
# You can now provision your raspi for epicRasperries
# by using the following command:
# curl -L http://tiny.cc/zu7lgz | sudo bash" | xmessage -file - &
# fi

echo "curl -L http://tiny.cc/zu7lgz | sudo bash" > /home/pi/Desktop/provision.sh
touch /firstboot_was_here
