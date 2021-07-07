#!/bin/bash

# Author: Yonny Vizcaya
# Version: 1.0.0
# Description: Wrapper Scripts Automation Tool.

#
# imports
#
#source $(pwd)"/modules/terraform-functions.sh"
#source $(pwd)"/modules/gcp-functions.sh"

#
# Paths definitions
#
TERRAFORM_MODULE_PATH=$(pwd)"/terraform"

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

function createSpecificStack() {
    docker-compose -f "docker-compose.yml" up -d --build db
}

function argParser() {
    shift
    while getopts "f:d:n:" opt; do
        case ${opt} in
        f)
            COMPOSE_FILE=${OPTARG}
            ;;
        d)
            KEY_FILE_PATH=${OPTARG}
            ;;
        n)
            APP_NAME=${OPTARG}
            ;;
        \?)
            echo "Dev help test"
            exit 1
            ;;
        esac
    done
    shift $((OPTIND - 1))
}

argParser $@

if [[ $# -gt 0 ]]; then
    if [[ $1 == "create" ]]; then
        create $2
    fi
    if [[ $1 == "destroy" ]]; then
        destroy $2
    fi
    if [[ $1 == "output" ]]; then
        echo "Not Implemented"
    fi
else
    echo "
        stack create [ -f: key-file-path ]
    "
fi