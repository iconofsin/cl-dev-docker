(load "~/quicklisp/setup.lisp")

(in-package :ql-dist-user)

(map nil 'ensure-installed (provided-releases (dist "quicklisp")))
