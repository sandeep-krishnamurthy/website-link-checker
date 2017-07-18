#!/bin/sh
set -e

sudo apt-get update
sudo apt-get install -y npm
sudo apt-get install -y nodejs-legacy
sudo npm install broken-link-checker -g

# replace this with your site url.
# r -> recursive
# o -> ordered
blc http://mxnet.io -ro
