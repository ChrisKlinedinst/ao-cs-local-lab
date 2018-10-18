# Local Lab

This project creates VMs and Containers for testing AppOptics agents

## Supported Platforms

* RHEL 6 / CentOS 6
* RHEL 7 / CentOS 7
* Ubuntu 14.04 (no docker salt support)
* Ubuntu 15.04
* Ubuntu 15.10
* Ubuntu 16.04
* Ubuntu 18.04
* Debian 7
* Debian 8

##Usage

###Deploying Salt States

You can run salt states by using the following commands:

Saltmaster as container

Saltmaster as VM


## Setup

Run setup.py

###Saltmaster

The Salt Master host can be configured as a Container using a local Docker instance or as its own VM on Ubuntu 14.04.

### AO_TOKEN

 The same API token is passed to all agents from Salt

### Github keys

Github keys are stored encrypted in Salt states and passed to hosts for using Git SSH client. This is not required and can be skipped.

##Creating VMs

You can create a new VM by running the createvm.py script.

###Vagrant Box hostname

This is the name of the Vagrant Image that the VM will be built on. If no box is entered the VM will be build using Ubuntu 16.04. The short names Centos and Ubuntu can be used to build with latest release. For a full list of available images see https://app.vagrantup.com/boxes/search.

###Hostname

This will be the Hostname for the VM. If nothing is entered a name will be created (ex: lab-boaxname-123)

###Memory

The amount of memory for the VM. You will need at least 512 to run most Salt states and 2048 to run Contianers

###Docker

All hosts get Docker installed via Salt during Setup

###Host agent

The AppOptics Host Agent is installed during setup


##Interacting with VMs

###Accessing VMs via ssh

You can SSH into a VM by running vagrant ssh from the VMs host directory (hosts/hostname/).

###Accessing the VM via virtualbox

Each VM will launch a console which can be used interactively. Root password is set to vagrant by default. The escape char for the mouse is Left CMD

###Network access

Each VM has 2 interfaces: one is Host only for accessing other VMs, the other is bridged which allows for client and internet access.

##Destroying VMs

You can destroy a VM using the destroyvm.py script

###Manually destroying a VM using Vagrant

You can run vagrant destroy from the VMs host directory (hosts/hostname/). You will then need to delete this directory.

###Salt Keys

Keys will automatically be removed if the VM directory is absent
