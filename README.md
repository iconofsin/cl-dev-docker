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
docker run -it --rm --expose 4005:4005 cl-dev:sbcl-swank
```
In this case, Quicklisp will download packages over the Internet.

##### SBCL+SWANK+Local Quicklisp
To force Quicklisp into using the local copy of the repository stored in `cl-dev:ql-dists`:
```
docker run cl-dev:ql-dists
docker run -it --rm --volumes-from [festive_chatterjee] --expose 4005:4005 cl-dev:sbcl-swank
```
where `[festive_chatterjee]` is the ID of the container running `cl-dev:ql-dists`.

SBCL runs as a non-root user.

##### PACKAGE VERSIONS
- SBCL 2.1.0 (builds from source, with `--with-sb-unicode`, `--with-core-compression`, `--dynamic-space-size=4Gb`)
- Quicklisp dists v.2020-12-20

##### ISSUES
- A minor SWANK hiccup, to be ironed out.
- `cl-dev:sbcl-swank` needs to be much lighter.
- `cl-dev:ql-dists` comes in at 2Gb.  Will change base to Alpine to shave some 70mb.
- Does this need a docker-compose.yml?