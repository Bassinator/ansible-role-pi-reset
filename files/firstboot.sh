#!/bin/bash
set -e

# disable setup wizard in graphics mode
if [ -f "/etc/xdg/autostart/piwiz.desktop" ]; then
  mv /etc/xdg/autostart/piwiz.desktop /etc/xdg/autostart/piwiz.bak
  
  # start vnc server
  systemctl start vncserver-x11-serviced
  systemctl enable vncserver-x11-serviced
fi


curl -L http://tiny.cc/epicRaspberries | bash
touch /firstboot_was_here
