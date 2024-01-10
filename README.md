# oqs-lab
This repo contains uncut versions of the used scripts and datasets.

## Background
This repository is part of my bachelor thesis work and intends to enable reproducability in regard to the lab setup. 

## Limitations
Statistical duration values in sub-millisecond space are not reliable in this lab setup, as they are measured only with millisecond precision.
Pings are used to estimate the Round Trip Time (RTT). Their statistics are measured in microseconds and therefore have better accuracy than the measured duration of the protocol transaction.
Therefore, an overall inaccuracy of ±1ms is to be expected. The behavior while affected by packet loss is not explored.

## Implementation
Projects of the Open Quantum Safe Project were selected as they provide usable prototypes for realistic PQR and PQC implementation. 
Their effort consists of liboqs, a C library for PQC algorithms and multiple integrations in commonly used protocols and applications. 
Although they conform with NISTs Round 4, which suffices for the intentions of this lab, the Open Quantum Safe Project does not ensure security for its implementations.

### oqs-provider
This implementation provides a solution to integrate in a OpenSSL v3.x version through the integrated provider interface. 
This enables seamless usage after the integration into OpenSSL and enables the lab to send and receive Kyber encrypted data between the Cloudflare development server and itself.
The lab setup for the OQS-Provider is split into an independent User-Mode version that runs its own OpenSSL version outside the one used by the operating system and a more integrated Global-Mode version which embeds the OQS-Provider into the OpenSSL version used by the operating system. This may provide additional insights into the performance differences between both implementations.

### oqs-ssh
OQS-SSH delivers a usable SSH implementation that was recompiled to integrate liboqs’s algorithms and therefore PQR as well as PQC solutions for authentication and KAP. The used version is based on OpenSSH
8.9 portable 1. The setup for this lab is split into four certificate/KAP combinations per procedure. These four represent a fully PQC integration, a fully "conventional" one and two hybrid concepts that either use a PQC KAP or certification/digital signature method. These four combinations are tested under SSH connections that run ip a on the remote host. 
