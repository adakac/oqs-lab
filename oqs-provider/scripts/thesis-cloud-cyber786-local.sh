#!/bin/sh

set -e #instantly quit after error

# setup openssl variables
# -z = length is Zero
# -n = is Not empty string
# -d = Directory exists
# -f = File exists
if [ -z "${OQS_PROVIDER_TESTSCRIPTS}" ]; then
        export OQS_PROVIDER_TESTSCRIPTS="$(pwd)/scripts"
fi

if [ -n "${OPENSSL_INSTALL}" ]; then
        # trying to set config variables suitably for pre-existing OpenSSL installation
        if [ -f "${OPENSSL_INSTALL}/bin/openssl" ]; then
                export OPENSSL_APP="${OPENSSL_INSTALL}/bin/openssl"
        fi
        if [ -z "${LD_LIBRARY_PATH}" ]; then
                if [ -d "${OPENSSL_INSTALL}/lib64" ]; then
                        export LD_LIBRARY_PATH="${OPENSSL_INSTALL}/lib64"
                elif [ -d "${OPENSSL_INSTALL}/lib" ]; then
                        export LD_LIBRARY_PATH="${OPENSSL_INSTALL}/lib"
                fi
        fi
        if [ -f "${OPENSSL_INSTALL}/ssl/openssl.cnf" ]; then
                export OPENSSL_CONF="${OPENSSL_INSTALL}/ssl/openssl.cnf"
        fi
fi

if [ -z "${OPENSSL_CONF}" ]; then
        export OPENSSL_CONF="$(pwd)/scripts/openssl-ca.cnf"
fi

if [ -z "${OPENSSL_APP}" ]; then
        if [ -f "$(pwd)/openssl/apps/openssl" ]; then
                export OPENSSL_APP="$(pwd)/openssl/apps/openssl"
        else # if no local openssl src directory is found, rely on PATH...
                export OPENSSL_APP=openssl
        fi
fi

if [ -z "${OPENSSL_MODULES}" ]; then
        export OPENSSL_MODULES="$(pwd)/_build/lib"
fi

if [ -z "${LD_LIBRARY_PATH}" ]; then
        if [ -d "$(pwd)/.local/lib64" ]; then
                export LD_LIBRARY_PATH="$(pwd)/.local/lib64"
        else
                if [ -d "$(pwd)/.local/lib" ]; then
                        export LD_LIBRARY_PATH="$(pwd)/.local/lib"
                fi
        fi
fi

# Set OSX DYLD_LIBRARY_PATH if not already externally set
if [ -z "${DYLD_LIBRARY_PATH}" ]; then
        export DYLD_LIBRARY_PATH="${LD_LIBRARY_PATH}"
fi

# Use newly built oqsprovider to test interop with external sites

if [ -z "$OPENSSL_APP" ]; then
    echo "OPENSSL_APP env var not set. Exiting."
    exit 1
fi

if [ -z "$OPENSSL_MODULES" ]; then
    echo "Warning: OPENSSL_MODULES env var not set."
fi

# Set OSX DYLD_LIBRARY_PATH if not already externally set
if [ -z "$DYLD_LIBRARY_PATH" ]; then
    export DYLD_LIBRARY_PATH=$LD_LIBRARY_PATH
fi

# We assume the value of env var HTTP_PROXY is "http://host.domain:port_num"
if [ ! -z "${HTTP_PROXY}" ]; then
    echo "Using Web proxy \"${HTTP_PROXY}\""
    export USE_PROXY="-proxy ${HTTP_PROXY#http://} -allow_proxy_certs"
else
    export USE_PROXY=""
fi

echo " Cloudflare:"
(echo -e "GET /cdn-cgi/trace HTTP/1.1\nHost: cloudflare.com\n\n"; echo $'\cc') | "${OPENSSL_APP}" s_client ${USE_PROXY} -connect pq.cloudflareresearch.com:443 -groups x25519_kyber768 -servername cloudflare.com -ign_eof 2>/dev/null | grep -E "kex=X25519Kyber768Draft00|Post-Handshake|Cipher"
echo "------------------------"
