# kluctl

A container for deploying Kubernetes resources via kluctl in Drone CI pipelines.

## Usage

I include this in pipelines, an example is below:

```
---
kind: pipeline
name: build
type: docker

steps:
- name: submodules
  image: alpine/git
  commands:
  - git submodule init
  - git submodule update --recursive

- name: hugo
  image: akester/kluctl
  commands:
  - kluctl diff -t

...
```

## Building

This container is built using Packer and has a makefile, run `make` to start a
build.


## Mirror

If you're looking at this repo at https://github.com/akester/kluctl/, know
that it's a mirror of my local code repository.  This repo is monitored though,
so any pull requests or issues will be seen.
