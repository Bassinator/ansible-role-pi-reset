#!/bin/bash
set -e

if [ -f "/etc/xdg/autostart/piwiz.desktop" ]; then
  # disable setup wizard in graphics mode
  mv /etc/xdg/autostart/piwiz.desktop /etc/xdg/autostart/piwiz.bak

  # create menu entry for epicRaspberry provisioning script
  cat <<EOF > /usr/share/applications/provision.desktop
[Desktop Entry]
Type=Application
Name=Setup EpicRaspberries
Name[en_GB]=Setup EpicRaspberries
GenericName=Setup EpicRaspberries
GenericName[en_GB]=Setup EpicRaspberries
Comment=install all needed tools for EpicRaspberry setup
Comment[en_GB]=install all needed tools for EpicRaspberry setup
Icon=rpi
Exec=/bin/provision.sh
NotShowIn=GNOME;XFCE;
StartupNotify=true
Terminal=true
Categories=Settings;DesktopSettings;GTK;X-LXDE-Settings;
EOF

  # start vnc server
  systemctl start vncserver-x11-serviced
  systemctl enable vncserver-x11-serviced
fi


echo "curl -L http://tiny.cc/epicRaspberries | bash" > /bin/provision.sh
chmod a+x /bin/provision.sh

touch /firstboot_was_here
