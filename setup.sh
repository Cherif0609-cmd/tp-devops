#!/bin/bash
mkdir -p ~/.ssh
cp /mnt/c/tp-devops/vagrant/.vagrant/machines/default/virtualbox/private_key ~/.ssh/k3s_key
sed -i 's/\r//' ~/.ssh/k3s_key
chmod 600 ~/.ssh/k3s_key
echo "Cle SSH copiee !"
ansible -i /mnt/c/tp-devops/vagrant/ansible/inventory.yml all -m ping