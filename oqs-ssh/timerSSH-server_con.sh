#!/bin/bash

/root/oqs-ssh/openssh/sshd -D -f /root/oqs-ssh/openssh/regress/sshd_config -o KexAlgorithms=curve25519-sha256@libssh.org -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa -h /root/oqs-ssh/openssh/regress/host.ssh-rsa
