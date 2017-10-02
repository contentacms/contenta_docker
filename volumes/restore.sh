#!/bin/bash

set -e

docker run --rm \
  --volume contentadocker_data:/destination \
  --volume $(pwd):/source \
  amazeeio/centos:7 \
  tar xvf /source/data.tgz -C /destination --strip 1

docker run --rm \
  --volume contentadocker_www:/destination \
  --volume $(pwd):/source \
  amazeeio/centos:7 \
  tar xvf /source/www.tgz -C /destination --strip 1
