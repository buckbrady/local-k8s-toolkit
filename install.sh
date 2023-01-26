#!/usr/bin/env bash

echo ">>> Checking for required tools"

if ! command -v kubectl &> /dev/null
then
    echo "ERROR> kubectl could not be found! please install kubectl"
    exit
fi

if ! command -v kind &> /dev/null
then
    echo "ERROR> kind could not be found! please install kind"
    exit
fi

if ! command -v helm &> /dev/null
then
    echo "ERROR> helm could not be found! please install helm"
    exit
fi

if ! command -v `helm diff -h` &> /dev/null
then
    echo "ERROR> helm-diff could not be found! please install helm diff plugin for helm"
    exit
fi

if ! command -v helmfile &> /dev/null
then
    echo "ERROR> helmfile could not be found! please install helmfile"
    exit
fi

echo ">>> All required tools found"

echo ">>> Checking for existing kind cluster"
if echo $(kind get clusters) | grep -q kind ; then
    echo "INFO> Kind cluster already exists"
    echo "INFO> Switching kubectl context to 'kind-kind'"
else
    echo "INFO> Kind cluster does not exist"
    echo ">>> Creating kind cluster"
    echo "INFO> Kubectl context will be 'kind-kind'"
    kind create cluster --config ./kind-config.yaml &> /dev/null
    echo "INFO> Switching kubectl context to 'kind-kind'"
fi

echo ">>> Installing base k8s components"
helmfile apply --selector name=ingress &> /dev/null
helmfile apply --selector name=cert-manager &> /dev/null
helmfile apply --selector name=trust-manager &> /dev/null

echo ">>> Installing selfsigned cluster issuer to cluster"
kubectl apply -f ./manifests/certs &> /dev/null

echo ">>> Installing all k8s components"
helmfile apply &> /dev/null

echo ">>> Setup complete!"
echo "Component URL's:"
printf "  Minio Console: https://minio-console.localhost\n"
printf "    Username: development\n"
printf "    Password: development\n"

echo ">>> Additonal resources can be added to 'helmfile.d/*' to install additonal charts"