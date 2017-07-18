#!/bin/sh
set -e

sudo apt-get update

# Install nodejs- v 7.10.1
sudo apt-get install -y curl python-software-properties
curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
sudo apt-get install -y nodejs

# Install npm
sudo apt-get install -y npm

# Install broken link checker utility
sudo npm install broken-link-checker -g

# replace this with your site url.
# r -> recursive
# o -> ordered
blc http://mxnet.io -ro
