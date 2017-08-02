# rundeck-vagrant

## Rundeck and Vagrant.

### About

A vagrant environment that sets up two servers. A Rundeck server and a web server. The idea being that you can run Rundeck jobs on the web server.

### Set up instructions

* `vagrant up`
* Add the following to your local `/etc/hosts` file: `192.168.35.46 dev.rundeck.loc`.
* Log into Rundeck at `dev.rundeck.loc` using `admin:admin` or `user:user`.
* SSH into the Rundeck server with: `vagrant ssh rundeck`.
* SSH into the web server with: `vagrant ssh web`.

### A quick note on SSH Keys

This repo contains private RSA keys used to SSH between servers. This is just an example. Never store private RSA keys in a git repo like this.

