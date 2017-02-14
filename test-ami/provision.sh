#!/bin/bash

# Provision environment

PROVISION_USER=$SUDO_USER

# APT repositories

## Add third party repositories

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list

add-apt-repository -y ppa:nginx/stable

## Update package repositories

apt-get update

## Update packages

apt-get upgrade -y
apt-get dist-upgrade -y


# Install essential dependencies

## Core

apt-get install -y build-essential git-core
apt-get install -y rlwrap libev-dev libev4 libxml2-dev libssl-dev
apt-get install -y libgif-dev libjpeg-dev libcairo2-dev graphicsmagick
apt-get install -y python-pip
apt-get install -y redis-tools

## nginx

apt-get install -y nginx

## mongodb

MONGO_VERSION="3.2.8"
MONGO_FLAVOR="linux-x86_64"
curl -O https://fastdl.mongodb.org/linux/mongodb-$MONGO_FLAVOR-$MONGO_VERSION.tgz
tar -zxvf mongodb-$MONGO_FLAVOR-$MONGO_VERSION.tgz
cp -R ./mongodb-$MONGO_FLAVOR-$MONGO_VERSION/bin/* /usr/bin
rm -rf ./mongodb-$MONGO_FLAVOR-$MONGO_VERSION

## postgresql

apt-get install -y postgresql-client

## supervisor

pip install supervisor

## s3cmd

pip install s3cmd


## firefox

apt-get install -y libgtk-3-0 libasound2

curl --silent https://ftp.mozilla.org/pub/firefox/releases/46.0/linux-x86_64/en-US/firefox-46.0.tar.bz2 |
  tar --extract --bzip2 --directory /opt/

ln --force --symbolic /opt/firefox/firefox /usr/bin/firefox

# Install node.js

NODE_VERSION="v6.9.4"
NODE_NAME="node-$NODE_VERSION-linux-x64"
NODE_URL="https://nodejs.org/dist/$NODE_VERSION/$NODE_NAME.tar.xz"

curl --silent $NODE_URL | \
  tar --extract --xz --strip-components=1 --directory /usr/local \
      $NODE_NAME/{bin,include,lib,share}

## Update npm

npm install --global npm@4.0.5

## Install CoffeeScript modules

npm install --global coffee-script@1.8.0
npm install --global gulp gulp-coffee


# Install golang

wget https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz
tar xfz godeb-amd64.tar.gz
./godeb install 1.7.1


# Install docker-engine

wget -qO- https://get.docker.com/ | sh
usermod -aG docker $PROVISION_USER


# Install test stack essentials

apt-get install -y xvfb xfonts-75dpi xfonts-100dpi xfonts-scalable xfonts-cyrillic
apt-get install -y openjdk-7-jre-headless
apt-get install -y google-chrome-stable

npm install --global nightwatch

## x11vnc

X11VNC_VERSION="x11vnc-0.9.14"
X11VNC_SOURCE_FILE="$X11VNC_VERSION-dev.tar.gz"
X11VNC_SOURCE_URL="http://x11vnc.sourceforge.net/dev/$X11VNC_SOURCE_FILE"

apt-get install -y libxtst-dev

cd /tmp
wget $X11VNC_SOURCE_URL
tar --extract --gzip --file $X11VNC_SOURCE_FILE
cd $X11VNC_VERSION
./configure
make
make install

x11vnc --version


# Configure system environment

## git

## Configure git

git config --global user.email 'sysops@koding.com'
git config --global user.name 'Koding Bot'

cp $HOME/.gitconfig ~root/

## nginx

update-rc.d nginx disable all
service nginx stop


# Initialize working environment

REPOSITORY_PATH=/opt/koding

mkdir $REPOSITORY_PATH
chown $PROVISION_USER:$PROVISION_USER $REPOSITORY_PATH


# Cleanup

rm -rf $HOME/.npm


# File variables

## Local variables:
## eval: (outline-minor-mode)
## outline-regexp: "#+ "
## End:
