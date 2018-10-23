# Local Lab

This project creates VMs and Containers for testing AppOptics agents


## Usage

### Deploying Salt States

You can run salt states by using the following commands:

Saltmaster as container

docker exec saltmaster sudo salt 'lab*' state.apply mystate.sls

Saltmaster as VM

vagrant ssh -c 'sudo salt 'lab*' state.apply mystate.sls'

### List of available states

 * Apache
 * collectd
 * docker
 * mysql
 * k8s
 * mesos
 * hotelapp (sample APM containers)
 * host agent



## Setup

Run setup.py

### Saltmaster

The Salt Master runs on its own VM named Saltmaster. This VM lives in the Hosts directory and has the IP 172.28.128.50 for the Host-Only interface.

### AO_TOKEN

 The same API token is passed to all agents from Salt using a pillar variable.

## Creating VMs

You can create a new VM by running the createvm.py script.

### Vagrant Box hostname

This is the name of the Vagrant Image that the VM will be built on. If no box is entered the VM will be build using Ubuntu 16.04. The short names Windows, Centos, and Ubuntu can be used to build with latest release. For a full list of available images see https://app.vagrantup.com/boxes/search.

### Hostname

This will be the Hostname for the VM. If nothing is entered a name will be created (ex: lab-boxname-123)

### Memory

The amount of memory for the VM. You will need at least 512 to run most Salt states and 2048 to run the sample APM Contianers

### Docker

All hosts get Docker installed via Salt during Setup

### Host agent

The AppOptics Host Agent is installed during setup


## Interacting with VMs

### Accessing VMs via ssh

You can SSH into a VM by running vagrant ssh from the VMs host directory (hosts/hostname/).

### Accessing the VM via virtualbox

Each VM will launch a console which can be used interactively. Root password is set to vagrant by default. The escape char for the mouse is Left CMD

### Network access

Each VM has 2 interfaces: one is Host only for accessing other VMs, the other is bridged which allows for client and internet access.

## Destroying VMs

You can destroy a VM using the destroyvm.py script

### Manually destroying a VM using Vagrant

You can run vagrant destroy from the VMs host directory (hosts/hostname/). You will then need to delete this directory.

### Salt Keys

Keys will automatically be removed if the VM directory is absent
