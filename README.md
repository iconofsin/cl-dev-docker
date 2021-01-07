# cl-dev-docker
A simple Docker-based SBCL/Emacs/Quicklisp development environment with offline Quicklisp access

NOTE: This initial commit is for SBCL/Quicklisp containers only.  FROM ubuntu:latest, for now.

REQUIREMENTS: Docker.

Running `/bin/bash ./build-all.sh` builds two images:
- `cl-dev:ql-dists` exports a volume with the Quicklisp dists mirror;
- `cl-dev:sbcl-swank` autoruns SBCL with SWANK on the default port (4005).

##### SBCL+SWANK+Quicklisp
You should be able to run `cl-dev:sbcl-swank` solo, like so:
```
docker run -it --rm --expose 4005 cl-dev:sbcl-swank
```
In this case, Quicklisp will download packages over the Internet.

##### SBCL+SWANK+Local Quicklisp
To force Quicklisp into using the local copy of the repository stored in `cl-dev:ql-dists`:
```
docker run --detach --name quicklisp_repo cl-dev:ql-dists
docker run -it --rm --volumes-from quicklisp_repo --expose 4005 cl-dev:sbcl-swank
```

SBCL runs as a non-root user.

##### PACKAGE VERSIONS
- SBCL 2.1.0 (builds from source, with `--with-sb-unicode`, `--with-core-compression`, `--dynamic-space-size=4Gb`, `--with-sb-linkable-runtime`)
- Quicklisp dists v.2020-12-20

Change both by editing variables in `build-all.sh` if required.

##### ISSUES
- A minor SWANK hiccup, to be ironed out.
- `cl-dev:sbcl-swank` needs to be much lighter.
- `cl-dev:ql-dists` comes in at almost 2Gb. This is by design.
- Currently Dockerfiles are based on ubuntu:latest, worst practices in action.
- Does this need a docker-compose.yml?
