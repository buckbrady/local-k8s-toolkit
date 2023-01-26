# local-k8s-toolbox
Collection of helm charts and manifests to setup a local k8s cluster to mimic a production style environment

## Setup

Install [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

Install [helmfile](https://helmfile.readthedocs.io/en/latest/#installation)

install helm-diff with `helm plugin install https://github.com/databus23/helm-diff`

run `bash ./install.sh`

## Ingress

Ingress with Cert Manager are setup so that you can have https over any `*.localhost` domain i.e. `https://test.localhost`

## Cert Manager

## Operators

This toolkit installs the following operators

### Crunchydata Postgres

### MongoDB Operator

### Redis Operator