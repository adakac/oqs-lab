#!/bin/sh

set -e #instantly quit after error

echo " Cloudflare:"
(echo -e "GET /cdn-cgi/trace HTTP/1.1\nHost: cloudflare.com\n\n";  echo $'\cc') | openssl s_client -connect pq.cloudflareresearch.com:443 -groups x25519_kyber768 -servername cloudflare.com -ign_eof 2>/dev/null | grep -E "kex=X25519Kyber768Draft00|Post-Handshake|Cipher"
echo "------------------------"
