#!/bin/sh
set -e

sudo apt-get update

# Install npm
sudo apt-get install -y npm

# Install nodejs- v 7.10.1
sudo apt-get install -y curl python-software-properties
curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
sudo apt-get install -y nodejs

# Install broken link checker utility
sudo npm install broken-link-checker -g

# Test broken link and print summary.
python test_broken_links.py
