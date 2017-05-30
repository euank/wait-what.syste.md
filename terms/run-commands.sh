at now + 1 minute

date > /tmp/at

atq


sudo systemd-run --unit write-date --on-active=20 --service-type=oneshot -- sh -c 'date > /tmp/run-at'

SYSTEMD_PAGER=cat systemctl list-timers

sudo systemd-run --unit date-daily --on-calendar=daily --service-type=oneshot -- sh -c 'date > /tmp/daily'

systemctl list-timers --no-pager
