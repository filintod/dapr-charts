#!/bin/bash

rm -rf ./dapr
git clone --depth=1 --branch=master git@github.com:dapr/dapr.git
rm -rf ./dapr/.git

version="${IMAGE_TAG:-1.15-master-4-linux-arm64}"

image_registry="${REGISTRY:-ghcr.io/filintod}"
image_tag="${version}"

echo "Image Registry: ${image_registry}"
echo "Image Tag: ${image_tag}"

echo "Change Registry (global.registry) to ${image_registry} in ./dapr/charts/dapr/values.yaml"
echo "Change Image Tag (image.tag) to ${image_tag} in ./dapr/charts/dapr/values.yaml"
# if on macos
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's|registry:.*|registry: '"${image_registry}"'|' ./dapr/charts/dapr/values.yaml
    sed -i '' 's|tag:.*|tag: '"${image_tag}"'|' ./dapr/charts/dapr/values.yaml
else
    sed -i 's|registry:.*|registry: '"${image_registry}"'|' ./dapr/charts/dapr/values.yaml
    sed -i 's|tag:.*|tag: '"${image_tag}"'|' ./dapr/charts/dapr/values.yaml
fi

helm package ./dapr/charts/dapr --version "${version}" --app-version "${version}" -d .
helm repo index . --url https://filintod.github.io/dapr-charts/

git add index.yaml dapr-${version}.tgz
git commit -m "new verion ${version}"
git push origin gh-pages

rm -rf ./dapr
