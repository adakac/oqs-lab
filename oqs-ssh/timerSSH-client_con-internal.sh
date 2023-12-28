#!/bin/bash

/root/oqs-ssh/openssh/ssh -F /root/oqs-ssh/openssh/regress/ssh_config -o KexAlgorithms=curve25519-sha256@libssh.org -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa -o PasswordAuthentication=no -i regress/ssh-rsa -t "127.0.0.1" "ip a" 
#somehost true
