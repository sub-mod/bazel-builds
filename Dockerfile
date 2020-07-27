#FROM quay.io/aicoe/manylinux2010_x86_64
#sub_mod/manylinux2010-s2i Dockerfile here https://github.com/sub-mod/manylinux-images/tree/master/centos-s2i
FROM quay.io/sub_mod/manylinux2010-s2i
LABEL Author "Subin Modeel <smodeel@redhat.com>"

USER root

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0*" \
    PLATFORM="el6" 


RUN yum install -y centos-release-scl unzip tree mlocate vim wget ccache sudo \
    && yum install -y devtoolset-7 rh-python36 \
    && yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel 


RUN source scl_source enable devtoolset-7 rh-python36 \
    && gcc --version \
    && python -V \
    && pip install --upgrade pip 

# start the container with gcc-7 and py3.6
RUN echo "echo 'using user scl_enable script'" >> ${APP_ROOT}/etc/scl_enable \
    && echo "source scl_source enable rh-python36 devtoolset-7" >> ${APP_ROOT}/etc/scl_enable \
    && echo "JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0*'" >> ${APP_ROOT}/etc/scl_enable \
    && echo "FULL_JAVA_HOME=$(readlink -f $JAVA_HOME)" >> ${APP_ROOT}/etc/scl_enable \
    && echo "export JAVA_HOME=\$FULL_JAVA_HOME" >> ${APP_ROOT}/etc/scl_enable \
    && echo "export CC=/opt/rh/devtoolset-7/root/usr/bin/gcc" >> ${APP_ROOT}/etc/scl_enable \
    && echo "export CXX=/opt/rh/devtoolset-7/root/usr/bin/g++" >> ${APP_ROOT}/etc/scl_enable \
    && echo "export EXTRA_BAZEL_ARGS='--verbose_failures'" >> ${APP_ROOT}/etc/scl_enable \
    && echo "export BAZEL_LINKLIBS='-l%:libstdc++.a'" >> ${APP_ROOT}/etc/scl_enable

 
WORKDIR ${HOME}

ENTRYPOINT ["container-entrypoint"]
CMD ["base-usage"]

# Switch to the user 
USER 1001
