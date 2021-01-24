#!/bin/bash
#set -x
# RUN ME with /bin/bash ./alpine-sbcl2011.sh

QUICKLISP_VERSION="2020-12-20"

build_sbcl_with_swank="docker build -t cl-dev:sbcl2011musl --build-arg QUICKLISP_VERSION=${QUICKLISP_VERSION} -f ./specs/Dockerfile.alpine-sbcl2011-ql-swank ."

echo "CL-ENV: building [sbcl:sbcl2011musl]"

eval "$build_sbcl_with_swank"

if [ $? -eq 0 ]
then
    echo "CL-ENV: built [cl-dev:sbcl2011musl]"
else
  echo "CL-ENV: failed to build [cl-dev:sbcl2011musl]" >&2

  exit 1
fi
