#!/bin/bash

dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

systemctl start docker
systemctl enable docker

# Add ec2-user to the docker group to allow running docker commands without sudo
usermod -aG docker ec2-user

# Resize the root and var logical volumes and file systems
growpart /dev/nvme0n1 4
lvextend -L +20G /dev/RootVG/rootVol
lvextend -L +10G /dev/RootVG/varVol

# Resize the file systems
xfs_growfs /
xfs_growfs /var
