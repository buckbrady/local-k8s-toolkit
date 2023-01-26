# local-k8s-toolbox
Collection of helm charts and manifests to setup a local k8s cluster to mimic a production style environment

## Setup

Install [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

Install [helmfile](https://helmfile.readthedocs.io/en/latest/#installation)

install helm-diff with `helm plugin install https://github.com/databus23/helm-diff`

run `bash ./install.sh`

## Included Tools

- Ingress Nginx
- CertManager
- CertManager Trust Manager
- Crunchydata Postgres Operator
- Opstree Container Kit Redis Operator
- Opstree Container Kit MongoDB Operator
- Minio Standalone w/ Console
- Selfsigned CA Cluster Issuer

## Operator Resources

Examples of deploying resources via the included operators are located in the `examples` directory

## Notes

- Using the `*.localhost` allows you to use domains with ingress without needing to configure any DNS

- All subdomains of `.localhost` will automaticlly resolved to `127.0.0.1` for IPv4 and `::1` for IPv6

- You can add additonal manifests to the `manifests/` directory as the entire directory except `manifests/certs` has been added to gitignore

- You can add additonal helmfiles to the `helmfile.d/` directory as the entire directory except `helmfile.d/00-base-helmfile.yaml` has been added to gitignore