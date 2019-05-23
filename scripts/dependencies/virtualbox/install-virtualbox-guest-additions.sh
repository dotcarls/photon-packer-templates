 #!/bin/sh

# Faking a sysV-based system
if [ ! -d /etc/init.d ]; then mkdir /etc/init.d; fi

mkdir /tmp/virtualbox
mount -o loop /root/VBoxGuestAdditions_6.0.6.iso /tmp/virtualbox

sh /tmp/virtualbox/VBoxLinuxAdditions.run
umount /tmp/virtualbox
rmdir /tmp/virtualbox
rm /root/VBoxGuestAdditions_6.0.6.iso

# Removing VBox startup files and removing init.d entirely if empty
find /etc/init.d -type f -name "vbox*" -exec rm {} \;
if [ ! "$(ls -A /etc/init.d)" ]; then rmdir /etc/init.d; fi

# Prevent vmhgfs module from loading on virtualbox platforms
if [ -f /etc/modules-load.d/vmhgfs.conf ]; then rm -f /etc/modules-load.d/vmhgfs.conf; fi
