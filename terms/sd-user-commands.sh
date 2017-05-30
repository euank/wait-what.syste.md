mkdir -p git/my-repo
git init --bare git/my-repo

mkdir -p .config/systemd/user

cat > .config/systemd/user/git-daemon.service <<EOF
[Service]
ExecStart=/usr/libexec/git-core/git-daemon --base-path=/home/core/git --verbose

[Install]
WantedBy=default.target
EOF

systemctl --user enable --now git-daemon

loginctl enable-linger
