#!/bin/bash
#set -x
# RUN ME with /bin/bash ./build-all.sh

SBCL_VERSION="2.1.0"
SBCL_DYNAMIC_MEMORY="4Gb" # not used rn
QUICKLISP_VERSION="2020-12-20"

build_sbcl_temporary="docker build -t sbcl:temporary --build-arg SBCL_VERSION=${SBCL_VERSION} --build-arg QUICKLISP_VERSION=${QUICKLISP_VERSION} -f ./specs/Dockerfile.sbcl-with-ql-dists ."

build_ql_dists="docker build -t cl-dev:ql-dists -f ./specs/Dockerfile.ql-dists-volume ."

build_sbcl_with_swank="docker build -t cl-dev:sbcl-swank --build-arg SBCL_VERSION=${SBCL_VERSION} --build-arg QUICKLISP_VERSION=${QUICKLISP_VERSION} -f ./specs/Dockerfile.sbcl-with-ql-and-swank ."

cleanup_sbcl_temporary="docker rmi sbcl:temporary"

echo "CL-ENV: building [sbcl:temporary]"

eval "$build_sbcl_temporary"

if [ $? -eq 0 ]
then
    echo "CL-ENV: built [sbcl:temporary], building [cl-dev:ql-dists]"

    eval "$build_ql_dists"

    if [ $? -eq 0 ]
       then
           echo "CL-ENV: built [cl-dev:ql-dists], building [cl-dev:sbcl-swank]"

           eval "$build_sbcl_with_swank"

           if [ $? -eq 0 ]
              then
                  echo "CL-ENV: built [cl-dev:sbcl-swank]"

                  echo "CL-ENV: cleaning up [sbcl:temporary]"

                  eval "$cleanup_sbcl_temporary"

                  exit 0
           else
               echo "CL-ENV: failed to build [cl-dev:sbcl-swank]" >&2

               exit 1
           fi
    else
        echo "CL-ENV: failed to build [cl-dev:sbcl-swank]" >&2
        
        exit 1
    fi
else
  echo "CL-ENV: failed to build [sbcl:temporary]" >&2

  exit 1
fi
