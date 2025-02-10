The Dockerfile in this folder defines an environment with R, git, vim,
pandoc, and latex via TinyTex.  It will clone the enclosing package
default branch, use BiocManager::install with dependencies=TRUE on the
source to get all dependencies resolved, and then use rcmdcheck::rcmdcheck.

The associated container was registered at dockerhub vjcitn/isochk:0.0.4
