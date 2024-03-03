#!/bin/sh

endpoint_id=demoiotthing
region=us-west-1
endpoint=a8dwijw281nbs-ats.iot.us-west-1.amazonaws.com
ca_path=$(realpath certs)
iot_sdk_install_path=$(realpath sdk-workspace/install/iotsdk)
iot_sdk_bin_path=${iot_sdk_install_path}/bin
thing_name=demoiotthing

# Run git using only docker if git cmd isn't available
# See https://github.com/alpine-docker/git?tab=readme-ov-file#optional-usage-1
git_cmd ()
{
    (docker run \
        -it --rm \
        -u$(id -u):$(id -g) \
        -e HOME=$HOME \
        -v ${HOME}:${HOME} \
        -v $(pwd):$(pwd) \
        -v $(pwd):/git \
        -v /etc/passwd:/etc/passwd -v /etc/group:/etc/group \
        alpine/git "$@" )
}

awsiot_cmd ()
{
    (docker run \
        -it --rm \
        -u$(id -u):$(id -g) \
        -v $(pwd):$(pwd) \
        --workdir $(pwd) \
        --hostname aws-iot-sdk-python \
        aws-iot-sdk-python "$@")
}

tunnel_notification_cmd()
{
    if which tunnel-notification; then
        tunnel-notification $@
    else
        if [ ! -e ${iot_sdk_bin_path}/tunnel-notification ]; then
            echo "Missing tunnel-notification exe at ${iot_sdk_bin_path}, please build using build-tunnel-sample.sh"
            exit 1
        else
            ${iot_sdk_bin_path}/tunnel-notification $@
        fi
    fi
}
