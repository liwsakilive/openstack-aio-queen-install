#!/usr/bin/env bash

set -e -x -u

apt-get update -y
apt-get dist-upgrade -y
apt-get install -y git vim python unzip iotop htop iftop

git clone -b 18.0.0 https://github.com/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible/

scripts/bootstrap-ansible.sh

scripts/bootstrap-aio.sh


cd /opt/openstack-ansible/

cp etc/openstack_deploy/conf.d/{aodh,designate,ceph,octavia,haproxy,magnum,barbican,gnocchi,ceilometer}.yml.aio /etc/openstack_deploy/conf.d/
for f in $(ls -1 /etc/openstack_deploy/conf.d/*.aio); do mv -v ${f} ${f%.*}; done



cd /opt/openstack-ansible/playbooks

openstack-ansible setup-everything.yml
