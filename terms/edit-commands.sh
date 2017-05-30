systemctl cat etcd-member.service | head -n 20

sudo systemctl edit etcd-member.service

[Service]
CPUShares=2048
Environment="ETCD_NAME=seldon"

sudo systemctl daemon-reload

systemctl cat etcd-member.service --no-pager

sudo systemctl enable --now etcd-member

systemctl status etcd-member

etcdctl member list

sudo systemctl edit --full --runtime --force example.service

[Service]
Type=simple
ExecStart=/bin/sh -c "while true; do date >> /tmp/date; sleep 1; done"

sudo systemctl start example

systemctl cat example

tail /tmp/date
