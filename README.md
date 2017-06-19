# Packer Templates [![CircleCI](https://circleci.com/gh/koding/packer/tree/master.svg?style=svg&circle-token=5fa18600f785fef8ce7d256689812d002cd30273)](https://circleci.com/gh/koding/packer/tree/master)

Packer templates have the source code for our images that we use on koding's infrastructure.
Our main goal is to have a clear understanding of how & what we are running in our servers.
We dont do incremential updates with other tools like ansible chef etc.
Everything is written with bash scripts. Every other tool is unnecessary complexity.
All bash scripts are checked against formatting.
After each merge to master, development environments are automatically updated.


## Folder structure

*base* is the main image that is used across various instances
*ci* contains the scripts for the CI/CD of this repo
*countly* contains the [Countly Server](https://github.com/Countly/countly-server)
*druid* is the analytics server
*kafka* contains the image builder for a kafka cluster
*zookeeper* contains the image builder for a zookeeper cluster (utilizes exhibitor)
*scripts* contains the base installers and their respective data/configs



## Contributing

* Open an issue for a discussion for new features before directly sending a PR
* Use [shfmt](https://github.com/mvdan/sh)
* Pin your deps to a specific version
