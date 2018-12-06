#!/bin/sh

cp -r /home/david942j/hitcon-training-2018-winter/footbook /home/footbook/
chown -R root:footbook /home/footbook/
chmod -R o-rwx /home/footbook
chmod 0664 /home/footbook/footbook/log/development.log
rm -fr /home/footbook/footbook/tmp/*
chmod g+w /home/footbook/footbook/tmp
chmod g+w /home/footbook/footbook/app/assets/images/footbook.ico
chmod 1733 /tmp /var/tmp /dev/shm
mount -o remount,hidepid=2 /proc
sysctl -w kernel.dmesg_restrict=1
