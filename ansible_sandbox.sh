#!/bin/bash

echo "Installing EPEL repository...."; yum install -y epel-release &> /dev/null
echo "Installing Updates...."; yum update –y &> /dev/null
echo "Installing Ansible...."; yum install -y ansible &> /dev/null

echo "Adding sandbox hosts to Ansible...."; cat <<EOT >> /etc/ansible/hosts
[test_group]
blastoise ansible_ssh_host=192.168.1.117
charizard ansible_ssh_host=192.168.1.125
venusaur ansible_ssh_host=192.168.1.148
EOT

echo "Disable fingerprints ssh checking...."; sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg &> /dev/null
echo "Test Anisble sandbox...."; ansible -m ping all --ask-pass
