#!/bin/sh

. ./shared.sh

if [ ! -d aws-iot-device-sdk-python-v2 ]; then
    git_cmd clone https://github.com/aws/aws-iot-device-sdk-python-v2.git
fi

awsiot_cmd python3 aws-iot-device-sdk-python-v2/samples/pubsub.py \
    --topic test/topic \
    --endpoint ${endpoint} \
    --ca_file ${ca_path}/AmazonRootCA1.pem \
    --cert ${ca_path}/*-certificate.pem.crt \
    --key ${ca_path}/*-private.pem.key
