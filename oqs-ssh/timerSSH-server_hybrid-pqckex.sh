#!/bin/bash

/root/oqs-ssh/openssh/sshd -D -f /root/oqs-ssh/openssh/regress/sshd_config -o KexAlgorithms=ecdh-nistp384-kyber-768r3-sha384-d00@openquantumsafe.org -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa -h /root/oqs-ssh/openssh/regress/host.ssh-rsa
