#!/bin/bash

source_image=$1
target_image=$2

docker pull $source_image
docker tag $source_image $target_image
docker push $target_image
