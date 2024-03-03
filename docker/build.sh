#!/bin/sh

cd $(dirname $0)
docker build . -t aws-iot-sdk-python
