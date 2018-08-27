#!/usr/bin/env bash

print_step () {
    echo "******************************"
    echo "Step $1 | $2 "
    echo "******************************"
}

# step 1 
print_step 1 "handle ssh key"

ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

echo "add the ssh key to github:"
cat ~/.ssh/id_rsa.pub
read 

# step 2
print_step 2 "install base packages"

sudo apt-get update
sudo apt-get install -y ansible git curl wget openssh-server

# step 3
print_step 3 "clone git@github.com:zhoumingjun/ansible-playbooks.git"

git clone git@github.com:zhoumingjun/ansible-playbooks.git ~/github.com/zhoumingjun/ansible-playbooks

# step 4
print_step 4 "run playbook"

cd  ~/github.com/zhoumingjun/ansible-playbooks
ansible-playbook dev.yml -i hosts --connection local --ask-become-pass --vault-id @vaultid  -vv
 
# step 5
print_step 5 "sync dotfiles"

bash -c "$(curl -sSL https://raw.githubusercontent.com/zhoumingjun/dotfiles/master/.bin/dotfiles-install.sh)"
