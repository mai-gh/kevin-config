#!/bin/bash

# adapted from the .INSTALL script from the package linux-aarch64-chromebook
# pacman -S vboot-utils uboot-tools


flash_kernel() {
  major=$(mountpoint -d / | cut -f 1 -d ':')
  minor=$(mountpoint -d / | cut -f 2 -d ':')
  device=$(cat /proc/partitions | awk {'if ($1 == "'${major}'" && $2 == "'${minor}'") print $4 '})
  device="/dev/${device/%2/1}"

  echo "A new kernel version needs to be flashed onto ${device}."
  echo "Do you want to do this now? [y|N]"
  read -r shouldwe
  if [[ $shouldwe =~ ^([yY][eE][sS]|[yY])$ ]]; then
    dd if=/boot/pack/vmlinux.kpart of=${device}
    sync
  else
    echo "You can do this later by running:"
    echo "# dd if=/boot/pack/vmlinux.kpart of=${device}"
  fi
}

#cd /boot/pack
#rm -v /boot/pack/vmlinuz
#rm -v /boot/pack/vmlinuz.lz4
#rm -v /boot/pack/kernel.itb
#rm -v /boot/pack/vmlinux.kpart
rm -v vmlinuz
rm -v vmlinuz.lz4
rm -v kernel.itb
rm -v vmlinux.kpart

#cp /boot/Image /boot/pack/vmlinuz
cp /boot/Image vmlinuz
lz4 -k vmlinuz
mkimage -f kernel.its kernel.itb
sh pack_vboot.sh
flash_kernel
