#!/bin/bash

[ "$DEBUG" ] && set -xe

## Look for docker secrets in default documented location.
docker_secrets_env() {
    local ACCESS_KEY_FILE="/run/secrets/$MINIO_ACCESS_KEY_FILE"
    local SECRET_KEY_FILE="/run/secrets/$MINIO_SECRET_KEY_FILE"

    if [ -f $ACCESS_KEY_FILE -a -f $SECRET_KEY_FILE ]; then
        if [ -f $ACCESS_KEY_FILE ]; then
            export MINIO_ACCESS_KEY="$(cat "$ACCESS_KEY_FILE")"
        fi
        if [ -f $SECRET_KEY_FILE ]; then
            export MINIO_SECRET_KEY="$(cat "$SECRET_KEY_FILE")"
        fi
    fi
}

## Set access env from secrets if necessary.
if [ -z $MINIO_ACCESS_KEY -o -z $MINIO_SECRET_KEY ]; then
    docker_secrets_env
fi

if [ "${1}" == "bash" ];then
    exec /bin/bash
elif [ "${1}" != "minio" ]; then
    if [ -n "${1}" ]; then
        exec minio "$@"
    fi
else
    exec $@
fi