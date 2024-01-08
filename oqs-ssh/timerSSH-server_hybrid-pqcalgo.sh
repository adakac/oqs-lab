#!/bin/bash

/root/oqs-ssh/openssh/sshd -D -f /root/oqs-ssh/openssh/regress/sshd_config -o KexAlgorithms=curve25519-sha256@libssh.org -o HostKeyAlgorithms=ssh-ecdsa-nistp384-dilithium3 -o PubkeyAcceptedKeyTypes=ssh-ecdsa-nistp384-dilithium3 -h /root/oqs-ssh/openssh/regress/host.ssh-ecdsa-nistp384-dilithium3
