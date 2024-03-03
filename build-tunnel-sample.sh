#!/bin/bash
. ./shared.sh
set -e
mkdir -p sdk-workspace
cd sdk-workspace
if [ ! -d aws-iot-device-sdk-cpp-v2 ]; then
    git clone --recursive https://github.com/aws/aws-iot-device-sdk-cpp-v2.git
fi
mkdir -p aws-iot-device-sdk-cpp-v2-build
mkdir -p ${iot_sdk_install_path}
cd aws-iot-device-sdk-cpp-v2-build
cmake -DCMAKE_INSTALL_PREFIX=${iot_sdk_install_path} -DCMAKE_BUILD_TYPE="Debug" ../aws-iot-device-sdk-cpp-v2
cmake --build . --target install
cd ../aws-iot-device-sdk-cpp-v2/samples/secure_tunneling/secure_tunnel
# See https://github.com/aws/aws-iot-device-sdk-cpp-v2/tree/f3de50925bbb527ccd5286510536f4878ca7c09f/samples
cmake -B build -DCMAKE_INSTALL_PREFIX=${iot_sdk_install_path} -DCMAKE_BUILD_TYPE="Debug" .
cmake --build build --config "Debug" --target install
cd ../tunnel_notification
cmake -B build -DCMAKE_INSTALL_PREFIX=${iot_sdk_install_path} -DCMAKE_BUILD_TYPE="Debug" .
cmake --build build --config "Debug" --target install
echo "Built secure-tunnel and tunnel-notification applications at ${iot_sdk_install_path}"
