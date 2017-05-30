SYSTEMD_PAGER="" systemctl cat systemd-journal-remote

# [Service]
# ExecStart=
# ExecStart=/usr/lib/systemd/systemd-journal-remote --listen-http=-3 --output=/var/log/journal/remote/

sudo systemctl enable --now systemd-journal-remote.socket

sudo journalctl --merge --follow --output short-unix


:join-pane -hs pres:2.0

echo 'URL=http://pres-1' | sudo tee -a /etc/systemd/journal-upload.conf

sudo systemctl enable --now systemd-journal-upload


echo "hello from pres-2" | systemd-cat -t pres-2-greeter
