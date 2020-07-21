#!/bin/sh

CHARTS_REPO="https://charts.aerokube.com/"

output_dir=${1:-"/tmp"}
version=${2:-"latest"}
mkdir -p ${output_dir}
tar c -vz -C chart ${output_dir}/moon-${version}.tgz moon
pushd ${output_dir}
wget ${CHARTS_REPO}/index.yaml
helm repo index --url ${CHARTS_REPO} --merge index.yaml
popd
