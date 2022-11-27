# Installing archlinux-arm on Samsung Chromebook Plus v1 aka kevin aka gru-kevin aka xe513c24

## What you will need
- this laptop :P
- micro sd card at least 2GB, 8+GB reccomended
- another computer that has a linux environment so we can download / extract / pack the kernel and install rootfs


## Build A Bootable USB / MicroSD

you will need:
 - A Samsung Chromebook Plus v1
 - A micro sd card at least 2GB
 - Another computer

```
gpg --recv-keys 68B3537F39A313B3E574D06777193F152BDBE6A6 # https://archlinuxarm.org/about/downloads
wget http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-chromebook-latest.tar.gz.sig
wget http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-chromebook-latest.tar.gz
gpg --verify ArchLinuxARM-aarch64-chromebook-latest.tar.gz.sig
wget https://raw.githubusercontent.com/mai-gh/kevin-config/master/partition_vboot.sh


# pacman -S gptfdisk
# sh partition_vboot.sh /dev/mmcblk0
# mkdir /mnt/tmp
# mount /dev/mmcblk0p2 /mnt/tmp
# bsdtar -xf ArchLinuxARM-aarch64-chromebook-latest.tar.gz -C /mnt/tmp
# dd if=/mnt/tmp/boot/vmlinux.kpart of=/dev/mmcblk0p1
# cp partition_vboot.sh /mnt/tmp/root/
# wget "$(curl -s https://archlinuxarm.org/packages/any/linux-firmware-marvell | grep 'http://mirror.archlinuxarm.org' | awk -F'"' '{print $2}')" -P /mnt/tmp/root/
# umount /mnt/tmp

```

## Unlock external booting

### Switch to developer mode
- Turn off the laptop.
- To invoke Recovery mode, you hold down the ESC and Refresh keys and poke the Power button.
- At the Recovery screen press Ctrl-D (there’s no prompt - you have to know to do it).
- Confirm switching to developer mode by pressing enter, and the laptop will reboot and reset the system. This takes about 10-15 minutes.

Note: After enabling developer mode, you will need to press Ctrl-D each time you boot, or wait 30 seconds to continue booting.

### Enable booting from external storage
- After booting into developer mode, hold Ctrl and Alt and poke the F2 key. This will open up the developer console.
- Type root to the login screen.
- Then type this to enable USB booting: 

```
$ crossystem dev_boot_usb=1
$ crossystem dev_default_boot=usb
```

## booting archlinuxarm & installing to emmc
<pre>
- insert the microsd into the chromebook while it is turned off.
- power on
- at bios white warning screen press `ctrl` + `u`
- wait ~30 seconds for it to boot, login as root
- # pacman -U linux-firmware-marvell-*
- Reboot the system, login as root
- # wifi-menu
- change `SigLevel = Required DatabaseOptional` to `SigLevel = Never` in `/etc/pacman.conf`
- # pacman -Sy archlinux-keyring archlinuxarm-keyring
- change `SigLevel = Never` back to `SigLevel = Required DatabaseOptional` in `/etc/pacman.conf`
- # pacman -Sy archlinux-keyring archlinuxarm-keyring
- # pacman -S gptfdisk btrfs-progs arch-install-scripts
- # swapon /dev/mmcblk1p3
- # mount /dev/mmcblk1p2 /mnt
- # pacstrap /mnt base base-devel linux-aarch64-chromebook linux-firmware-marvell vim sway networkmanager git foot polkit bemenu-wayland terminus-font vboot-utils mc unarchiver acpi openssl-1.1
- # dd if=/mnt/boot/vmlinux.kpart of=/dev/mmcblk1p1
- # genfstab -U /mnt >> /mnt/etc/fstab
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
arch-chroot /mnt
ln -sv /usr/share/zoneinfo/America/New_York /etc/localtime
echo "YOURHOSTNAME" > /etc/hostname
locale-gen
useradd -m -g users -s /bin/bash USERNAME
passwd USERNAME
passwd
exit
umount /mnt
poweroff

take out sdcard
press ctrl + d at bios screen to bott from internal emmc

mkdir work
cd work
git clone https://github.com/mai-gh/kevin-config
$ mkdir -p ~/.config/sway
cp kevin-config/dot_files/.config/sway/config ~/.config/sway/
</pre>


## Changing BIOS timeout to 2 seconds

### Remove the BIOS Write Protection Screw

<ul style="list-style-type: none">
  <li><a href=jpg/aa.jpg><img src=jpg/aa.jpg width=400 /></a></li>
  <li><a href=jpg/bb.jpg><img src=jpg/bb.jpg width=400 /></a></li>
  <li><a href=jpg/cc.jpg><img src=jpg/cc.jpg width=400 /></a></li>
  <li><a href=jpg/dd.jpg><img src=jpg/dd.jpg width=400 /></a></li>
  <li><a href=jpg/ee.jpg><img src=jpg/ee.jpg width=400 /></a></li>
</ul>

```
$ cd work
$ mkdir aur
$ cd aur
$ git clone https://aur.archlinux.org/flashrom-chromeos.git && cvd 
$ cd flashrom-chromeos
$ makepkg -sAi
$ su -l

# flashrom-chromeos --programmer internal --wp-disable
# flashrom-chromeos --programmer internal -r bios.bin
# gbb_utility --set --flags=0x01 bios.bin bios.new
# flashrom-chromeos --programmer internal -w bios.new
# flashrom-chromeos --programmer internal --wp-enable --wp-range=0x00000000,0x08000000
# flashrom-chromeos --programmer internal --wp-status
```


https://archlinux.org/packages/community/x86_64/0ad/download/
http://mirror.archlinuxarm.org/armv7h/core/linux-firmware-marvell-20221109.60310c2-1-any.pkg.tar.xz

https://archlinuxarm.org/packages/core/armv7h/linux-firmware-marvell/download/
