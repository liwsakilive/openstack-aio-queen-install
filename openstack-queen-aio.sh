#!/usr/bin/env bash

set -e -x -u

apt update
apt -y dist-upgrade
apt install -y git vim python unzip iotop htop iftop

git clone https://git.openstack.org/openstack/openstack-ansible \
    /opt/openstack-ansible

git clone -b 17.1.3 https://github.com/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible/

scripts/bootstrap-ansible.sh
scripts/bootstrap-aio.sh


cd /opt/openstack-ansible/
cp etc/openstack_deploy/conf.d/{aodh,gnocchi,ceilometer}.yml.aio /etc/openstack_deploy/conf.d/
for f in $(ls -1 /etc/openstack_deploy/conf.d/*.aio); do mv -v ${f} ${f%.*}; done

cd /opt/openstack-ansible/playbooks

openstack-ansible setup-hosts.yml
openstack-ansible setup-infrastructure.yml
openstack-ansible setup-openstack.yml
