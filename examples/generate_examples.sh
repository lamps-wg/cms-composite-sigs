#!/bin/bash

set -e

generate() {
    ALG=$1

    if ! openssl list -signature-algorithms | grep $ALG; then
        echo "OpenSSL doesn't support $ALG"
        exit -1
    fi

    echo -n "$ALG signed-data example with signed attributes" > $ALG.txt

    openssl cms \
        -sign -nocerts -nodetach -nosmimecap \
        -in $ALG.txt \
        -inkey in/$ALG.key \
        -signer in/$ALG.crt \
        -out $ALG-signed-attrs.pem -outform PEM \

    openssl cms \
        -verify -verify_retcode \
        -in $ALG-signed-attrs.pem -inform PEM \
        -certfile in/$ALG.crt \
        -CAfile in/$ALG.crt
}

generate id-MLDSA65-ECDSA-P256-SHA512

# Needs der2ascii:
# > sudo apt install golang-go
# > go install github.com/google/der-ascii/cmd/...@latest
./pretty
