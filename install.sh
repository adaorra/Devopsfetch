
#!/bin/bash

# Installation script for devopsfetch

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies if they don't exist
for pkg in jq nginx docker.io; do
    if ! command_exists $pkg; then
        echo "Installing $pkg..."
        apt-get install -y $pkg
    else
        echo "$pkg is already installed."
    fi
done

cp devopsfetch /usr/local/bin/

# Make the script executable
chmod +x /usr/local/bin/devopsfetch

# Create systemd service file
cat << EOF > /etc/systemd/system/devopsfetch.service
[Unit]
Description=DevOpsFetch Monitoring Service
After=network.target

[Service]
ExecStart=/bin/bash -c 'while true; do /usr/local/bin/devopsfetch -t "$(date -d "1 minute ago" "+\%Y-\%m-\%d \%H:\%M:\%S")" "$(date "+\%Y-\%m-\%d \%H:\%M:\%S")" >> /var/log/devopsfetch/devopsfetch.log; sleep 60; done'
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Create log directory
mkdir -p /var/log/devopsfetch

# Create log rotation configuration
cat << EOF > /etc/logrotate.d/devopsfetch
/var/log/devopsfetch/devopsfetch.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 644 root root
}
EOF

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable devopsfetch.service
systemctl start devopsfetch.service

echo "DevOpsFetch has been installed and the monitoring service has been started."
echo "You can now use 'devopsfetch' command to retrieve system information."
echo "Logs are stored in /var/log/devopsfetch/devopsfetch.log"
