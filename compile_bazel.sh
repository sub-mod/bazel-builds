
# docker run -it -v $(pwd):/opt/app-root/src -u 0 submod/bazel-build:latest /bin/bash
BAZEL_VERSION=3.4.1

gcc -v
python -V
echo $JAVA_HOME
echo $BAZEL_VERSION
wget https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-dist.zip
unzip bazel-$BAZEL_VERSION-dist.zip -d bazel-$BAZEL_VERSION
cd bazel-$BAZEL_VERSION
export BAZEL_LINKLIBS="-l%:libstdc++.a"
./compile.sh