#!/bin/sh

CHARTS_REPO="https://charts.aerokube.com/"

output_dir=${1:-"/tmp"}
version=${2:-"latest"}
mkdir -p ${output_dir}
tar cvz -C chart -f ${output_dir}/moon-${version}.tgz moon
cd ${output_dir}
wget ${CHARTS_REPO}/index.yaml || true
helm repo index . --url ${CHARTS_REPO} --merge index.yaml
