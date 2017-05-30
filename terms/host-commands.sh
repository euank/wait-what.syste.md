ssh demo
sudo systemctl cat usr-bin.mount
^D
systemctl --host root@demo start usr-bin.mount
ssh demo
systemctl status usr-bin.mount
sudo rm -f /usr/bin/systemctl && hash -r
systemctl status usr-bin.mount
^D
systemctl --host root@demo status usr-bin.mount
systemd-run --host=root@demo --unit=umount-usr-bin.service -- /bin/sh -c 'umount -l /usr/bin'
