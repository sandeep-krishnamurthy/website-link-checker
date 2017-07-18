#!/bin/sh
set -e
sudo apt-get install -y nodejs-legacy
sudo apt-get install -y npm
npm install broken-link-checker

# replace this with your site url.
# r -> recursive
# o -> ordered
blc http://mxnet -ro
