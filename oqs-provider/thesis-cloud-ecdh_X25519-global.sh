#!/bin/sh

set -e #instantly quit after error

echo " Cloudflare:"
(echo -e "GET /cdn-cgi/trace HTTP/1.1\nHost: cloudflare.com\n\n"; echo $'\cc') | openssl s_client -connect pq.cloudflareresearch.com:443 -servername cloudflare.com -groups X25519 -ign_eof 2>/dev/null | grep -E "kex=|Post-Handshake|Cipher"
echo "------------------------"
