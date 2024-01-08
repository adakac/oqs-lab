#!/bin/bash

/root/oqs-ssh/openssh/ssh -F /root/oqs-ssh/openssh/regress/ssh_config -o KexAlgorithms=ecdh-nistp384-kyber-768r3-sha384-d00@openquantumsafe.org -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa -o PasswordAuthentication=no -i regress/ssh-rsa -t "127.0.0.1" "ip a"
