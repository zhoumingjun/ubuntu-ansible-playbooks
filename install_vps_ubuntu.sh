#!/bin/bash

ansible-playbook vps.yml -i hosts -connection local --ask-become-pass --vault-id @vaultid -vv