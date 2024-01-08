#!/bin/bash

/root/oqs-ssh/openssh/ssh -F /root/oqs-ssh/openssh/regress/ssh_config -o KexAlgorithms=curve25519-sha256@libssh.org -o HostKeyAlgorithms=ssh-ecdsa-nistp384-dilithium3 -o PubkeyAcceptedKeyTypes=ssh-ecdsa-nistp384-dilithium3 -o PasswordAuthentication=no -i regress/ssh-ecdsa-nistp384-dilithium3 -at "127.0.0.1" "ip a"
