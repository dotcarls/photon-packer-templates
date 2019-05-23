#!/usr/bin/env bash

sed -i '/linux/ s/$/ net.ifnames=0/' /boot/grub2/grub.cfg
echo 'GRUB_CMDLINE_LINUX=\"net.ifnames=0\"' >> /etc/default/grub
sed -i 's/OS/Linux/' /etc/photon-release
