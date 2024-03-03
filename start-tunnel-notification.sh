#!/bin/sh

. ./shared.sh

tunnel_notification_cmd \
    --endpoint ${endpoint}  \
    --cert ${ca_path}/*-certificate.pem.crt \
    --key ${ca_path}/*-private.pem.key \
    --thing_name ${thing_name} \
    --verbosity Trace
