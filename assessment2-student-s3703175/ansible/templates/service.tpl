[Unit]
Description=service.

[Service]
WorkingDirectory=/home/ec2-user/dist
Type=simple
ExecStart=/home/ec2-user/dist/TechTestApp serve &

[Install]
WantedBy=multi-user.target