#!/bin/bash
source /etc/profile

sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y ppa:ethereum/ethereum-qt

### update
sudo apt-get update

## install essentials
sudo apt-get install -y build-essential
sudo apt-get install -y less patch tar unzip telnet curl wget git jq htop dstat sysstat

### get ethereum related stuff
sudo apt-get install -y ethereum=1.6.5+build9900+xenial
sudo apt-get install -y cpp-ethereum=1.2.9-SNAPSHOT--20160629-6a05dd7~xenial-0ubuntu2

# The Solidity Contract-Oriented Programming Language
sudo apt-get install -y solc=1:0.4.11-0ubuntu1~xenial

### install Go
export GO_VERSION="1.8.1"
export GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz"
export GO_SRC_URL="https://storage.googleapis.com/golang/$GO_TARBALL"
curl --silent $GO_SRC_URL | sudo tar --extract --gzip --directory=/usr/local

sudo ln --symbolic --force /usr/local/go/bin/* /usr/local/bin/

### install NodeJS
# ps: 8 is problematic, use version 7
sudo apt-get install -y python-software-properties

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs=7.10.0-1nodesource1~xenial1

### install helpers

# dapp ethereum solidity EVM
sudo npm install -g --unsafe-perm dapple@0.8.48
# complete ethereum blockchain in memory that run on the development machine
sudo npm install -g --unsafe-perm ethereumjs-testrpc@3.0.5
# Solidity compiler
sudo npm install -g --unsafe-perm solc@0.4.11
# ethereum javascript API
sudo npm install -g --unsafe-perm web3@0.19.0
# Install truffle, manage development environment, tests and assets for Ethereum
sudo npm install -g --unsafe-perm truffle@3.2.5
# various others
sudo npm install -g --unsafe-perm mocha@3.4.2
sudo npm install -g --unsafe-perm node-inspector@1.1.1

# install latest version of geth
# Official Go implementation of the Ethereum protocol https://geth.ethereum.org
git clone https://github.com/ethereum/go-ethereum.git
cd go-ethereum
make all
sudo cp -R ./build/bin/* /usr/local/bin/

# install solidity
# git clone --recursive https://github.com/ethereum/solidity.git
# cd solidity
# git submodule update --init --recursive
# ./scripts/install_deps.sh
# ./scripts/build.sh
