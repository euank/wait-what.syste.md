echo hello world > /var/www/hw.txt

docker run --name nginx \
-d \
-p 80:80 -v /var/www:/usr/share/nginx/html \
nginx

curl -s http://pres-1353-7/hw.txt

docker rm -f nginx


-----

sudo machinectl --verify=checksum pull-tar https://d.euank.com/nspawn-imgs/fedora-nginx.tar.gz

sudo machinectl show-image fedora-nginx

curl -s https://d.euank.com/nspawn-imgs/fedora-nginx.nspawn | sudo tee /etc/systemd/nspawn/fedora-nginx.nspawn

sudo systemd-run --unit=nginx-container \
systemd-nspawn --machine=fedora-nginx

journalctl --lines=10 -u nginx-container --no-pager

curl -s http://pres-1353-7/hw.txt

sudo machinectl list

sudo machinectl shell fedora-nginx

sudo machinectl terminate fedora-nginx

-----

sudo systemd-run --unit nginx-rkt-container rkt run --debug --uuid-file-save=/tmp/nginx.uuid \
--volume www,kind=host,source=/var/www --mount volume=www,target=/usr/share/nginx/html \
--port 80-tcp:80 docker://nginx

SYSTEMD_PAGER= journalctl -u nginx-rkt-container

curl -s http://pres-1353-7/hw.txt

sudo rkt stop --uuid-file=/tmp/nginx.uuid


------


sudo SYSTEMD_EDITOR=tee systemctl edit --full --force nginx-unit <<EOF
[Service]
ExecStart=/usr/sbin/nginx -g 'daemon off;'
# Mount namespace
RootDirectory=/var/lib/machines/fedora-nginx
# Mount /proc, /dev, and so on
MountAPIVFS=true
# Network namespace
PrivateNetwork=true
# Volume
BindPaths=/var/www:/usr/share/nginx/html
EOF

sudo systemctl start nginx-unit

systemctl status nginx-unit
