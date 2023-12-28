#!/bin/bash
/root/oqs-ssh/openssh/ssh -F /root/oqs-ssh/openssh/regress/ssh_config -o KexAlgorithms=kyber-768-sha384 -o HostKeyAlgorithms=ssh-ecdsa-nistp384-dilithium3 -o PubkeyAcceptedKeyTypes=ssh-ecdsa-nistp384-dilithium3 -o PasswordAuthentication=no -i regress/ssh-ecdsa-nistp384-dilithium3 -t "127.0.0.1" "ip a" 
#somehost true
