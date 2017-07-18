#!/bin/sh
set -e
apt-get install -y nodejs-legacy
apt-get install -y npm
npm install broken-link-checker -g

# replace this with your site url.
# r -> recursive
# o -> ordered
blc http://mxnet -ro
