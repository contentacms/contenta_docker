#!/bin/bash

set -e

docker run --rm \
  --volume contentadocker_data:/source \
  --volume $(pwd):/destination \
  amazeeio/centos:7 \
  tar cvf /destination/data.tgz /source

docker run --rm \
  --volume contentadocker_www:/source \
  --volume $(pwd):/destination \
  amazeeio/centos:7 \
  tar cvf /destination/www.tgz /source
