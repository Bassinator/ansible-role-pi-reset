#!/bin/sh
#supports_backup in PINN

set -ex

# shellcheck disable=SC2154
if [ -z "$part1" ] || [ -z "$part2" ]; then
  printf "Error: missing environment variable part1 or part2\n" 1>&2
  exit 1
fi

mkdir -p /tmp/1 /tmp/2

mount "$part1" /tmp/1
mount "$part2" /tmp/2

sed /tmp/1/cmdline.txt -i -e "s|root=[^ ]*|root=${part2}|"
sed /tmp/2/etc/fstab -i -e "s|^[^#].* / |${part2}  / |"
sed /tmp/2/etc/fstab -i -e "s|^[^#].* /boot |${part1}  /boot |"

# shellcheck disable=SC2154
if [ -z "$restore" ]; then
# BEGIN ANSIBLE MANAGED BLOCK for firstboot service installation
# copy firstboot service config
cp /mnt/firstboot.service /tmp/2/lib/systemd/system/firstboot.service
ln -s /lib/systemd/system/firstboot.service /tmp/2/etc/systemd/system/multi-user.target.wants/firstboot.service
# copy firstboot setup script
cp /mnt/firstboot.sh /tmp/1/firstboot.sh
chmod 0755 /tmp/1/firstboot.sh
# copy factory_reset script
cp /mnt/factory_reset.sh /tmp/2/sbin/factory_reset.sh
chmod 0755 /tmp/2/sbin/factory_reset.sh
# END ANSIBLE MANAGED BLOCK for firstboot service installation
  if [ -f /mnt/ssh ]; then
    cp /mnt/ssh /tmp/1/
  fi

  if [ -f /mnt/ssh.txt ]; then
    cp /mnt/ssh.txt /tmp/1/
  fi

  if [ -f /settings/wpa_supplicant.conf ]; then
    cp /settings/wpa_supplicant.conf /tmp/1/
  fi

  if ! grep -q resize /proc/cmdline; then
    if ! grep -q splash /tmp/1/cmdline.txt; then
      sed -i "s| quiet||g" /tmp/1/cmdline.txt
    fi
    sed -i 's| init=/usr/lib/raspi-config/init_resize.sh||' /tmp/1/cmdline.txt
  else
    sed -i '1 s|.*|& sdhci.debug_quirks2=4|' /tmp/1/cmdline.txt
  fi
fi

umount /tmp/1
umount /tmp/2
