#!/bin/bash

rm -rf ./dapr
git clone --depth=1 --branch=master git@github.com:dapr/dapr.git
rm -rf ./dapr/.git

version="v1.15.0-edge"

helm package ./dapr/charts/dapr --version "${version}" --app-version "${version}" -d .
helm repo index . --url https://filintod.github.io/dapr-charts/

git add index.yaml dapr-${version}.tgz
git commit -m "new verion ${version}"
git push origin gh-pages

rm -rf ./dapr
