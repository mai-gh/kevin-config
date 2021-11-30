tweaking for the samsung chromebook plus v1 aka gru-kevein to run archlinux / parabola gnu/linux-libre

this computer is usable and good, but is pretty rough around the edges at the beginning. 

the archlinuxarm image for this device doesnt boot... and parabola doesnt even officially support it

deeper instruction on setup can be found on my parabola wiki page
https://wiki.parabola.nu/User:Mai


in this setup it is assumed you are using sway as you window manager. 

contents:

* partition_vboot.sh:
  - run as root like:  # partition_vboot.sh /dev/sdX
  - this will automatically partition an entire block device to be used for this chromebook
* boot/pack/chromebook-install.sh
  - since arch and parabola do not work out of the box, this is how you fix the kernel so it boots
  - just install kernel like normal, then run # sh chromebook-install.sh
  - you need to have vboot-tuils uboot-tools and dtc packages installed
  - this will automatically detect and flash the kernel partition (based on current root partition)
  - you can edit the kernel parameters inside of the cmdline file
* etc/systemd/system/setkeycodes.service
  - remap that pesky lock key to delete
  - enable with # systemctl enable setkeycodes then reboot
* etc/systemd/logind.conf
  - disable power button, lid switch (accidents happen ;P)
* dot_files/.config/sway/config
  - buttons remapped to be more like spectrwm
  - power button now mapped to manual rotation / tablet modes
* dot_files/.bashrc
  - MOZ_ENABLE_WAYLAND=1 is necessary to make any firefox derivative actually usable
* scripts/sway-rotate-button.sh
  - used to rotate screen, triggered by a button press define in sway config



todo:

* include alacritty patch
* pulseaudio vs alsa, both have problems, but you can switch between...
