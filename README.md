# bazel-builds on centos6

This repo is used to build [bazel](https://bazel.build/) on Centos6.

```
# docker build -t submod/bazel-build -f Dockerfile .
```

```
# docker run -it -v $(pwd):/opt/app-root/src -u 0 submod/bazel-build:latest /bin/bash
using user scl_enable script
bash-4.1# ./compile_bazel.sh
```