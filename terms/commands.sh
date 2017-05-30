ip addr show eth0

my_ip=10.0.2.15

echo hello world > /var/www/hw.txt

docker run --name nginx \
-d \
-p 80:80 -v /var/www:/usr/share/nginx/html \
nginx

curl -s $my_ip/hw.txt

docker rm -f nginx


-----

my_ip=10.0.2.15

sudo machinectl --verify=checksum pull-tar https://d.euank.com/nspawn-imgs/fedora-nginx.tar.gz

sudo machinectl show-image fedora-nginx

curl -s https://d.euank.com/nspawn-imgs/fedora-nginx.nspawn | sudo tee /etc/systemd/nspawn/fedora-nginx.nspawn

sudo systemd-run --unit=nginx-container \
systemd-nspawn --machine=fedora-nginx


sudo journalctl --lines=20 -u nginx-container

curl -s $my_ip/hw.txt

sudo machinectl list

sudo machinectl shell fedora-nginx

sudo machinectl terminate fedora-nginx


-----

sudo systemd-run --unit nginx-rkt-container rkt run --uuid-file-save=/tmp/nginx.uuid \
	--volume www,kind=host,source=/var/www --mount volume=www,target=/usr/share/nginx/html \
	--port 80-tcp:80 docker://nginx

curl -s $my_ip/hw.txt

sudo rkt stop --uuid-file=/tmp/nginx.uuid


------


cat > /etc/systemd/system/nginx-unit.service <<EOF
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

systemctl start nginx-unit

systemctl status nginx-unit
