#!/bin/bash

# Pre-setup
mkdir -p /home/ubuntu/.ssh/
touch /home/ubuntu/.ssh/authorized_keys
chown ubuntu:ubuntu -R /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 644 /home/ubuntu/.ssh/authorized_keys

# Add your SSH pub-keys keys here for instance access
echo '<pubkey_here>' >> /home/ubuntu/.ssh/authorized_keys