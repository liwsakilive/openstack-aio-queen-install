#!/usr/bin/env bash

set -e -x -u

apt update
apt -y dist-upgrade
apt install -y git vim python unzip iotop htop iftop

git clone https://git.openstack.org/openstack/openstack-ansible \
    /opt/openstack-ansible

# # List all existing tags.
git tag -l /opt/openstack-ansible

git checkout stable/queens /opt/openstack-ansible
git describe --abbrev=0 --tags /opt/openstack-ansible
git checkout 17.1.3 /opt/openstack-ansible
