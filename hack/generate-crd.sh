#!/usr/bin/bash

source .bingo/variables.env

set -euo pipefail

MANIFESTS_DIR=${1:-"manifests/${OCP_VERSION}"}

echo "--------------------------------------------------------------"
echo "Generate k8s golang code"
echo "--------------------------------------------------------------"
$OPERATOR_SDK generate k8s

echo "--------------------------------------------------------------"
echo "Generate CRDs for apiVersion v1"
echo "--------------------------------------------------------------"
$OPERATOR_SDK generate crds --crd-version v1
mv deploy/crds/*.yaml "${MANIFESTS_DIR}"

echo "---------------------------------------------------------------"
echo "Cleanup operator-sdk generation folder"
echo "---------------------------------------------------------------"
rm -rf deploy
