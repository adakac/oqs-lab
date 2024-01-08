#!/bin/bash

/root/oqs-ssh/openssh/sshd -D -f /root/oqs-ssh/openssh/regress/sshd_config -o KexAlgorithms=kyber-768-sha384 -o HostKeyAlgorithms=ssh-ecdsa-nistp384-dilithium3 -o PubkeyAcceptedKeyTypes=ssh-ecdsa-nistp384-dilithium3 -h /root/oqs-ssh/openssh/regress/host.ssh-ecdsa-nistp384-dilithium3
