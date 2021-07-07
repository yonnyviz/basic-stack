#!/bin/bash

# Author: Yonny Vizcaya
# Version: 1.0.0
# Description: Wrapper Scripts Automation Tool.

function create() {
    if [[ ! -z ${1} ]]; then
        echo "INFO - Creating Tech Stack"
        docker-compose -f ${1} up -d
    else
        echo "Compose file not found. Please provide yml file."
    fi
}

function destroy() {
    if [[ ! -z ${1} ]]; then
        echo "INFO - Destroying Tech Stack"
        docker-compose -f ${1} down
    else
        echo "Compose file not found. Please provide yml file."
    fi
}

function buildImage() {
    local DOCKERFILE_PATH=${1}

    docker build ${DOCKERFILE_PATH}
}

function pushImage() {
    local IMAGE_NAME=${1}
    local IMAGE_TAG=${2}

    docker push localhost:5000/${IMAGE_NAME}:${IMAGE_TAG}
}

function pullImage() {
    local IMAGE_NAME=${1}

    docker pull ${IMAGE_NAME}
}

function tagImage() {
    local IMAGE_NAME=${1}
    docker tag ${IMAGE_NAME} ${IMAGE_NAME}:$(git rev-parse --short HEAD)
}

if [[ $# -gt 0 ]]; then
    if [[ $1 == "create" ]]; then
        create $2
    fi
    if [[ $1 == "destroy" ]]; then
        destroy $2
    fi
    if [[ $1 == "buildImage" ]]; then
        buildImage $2
    fi
    if [[ $1 == "pushImage" ]]; then
        pushImage $2
    fi
    if [[ $1 == "pullImage" ]]; then
        pullImage $2
    fi
    if [[ $1 == "tagImage" ]]; then
        tagImage $2
    fi
else
    echo "
        stack create [ -f: key-file-path ]
    "
fi