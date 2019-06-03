FROM centos:7

ARG PY_VERSION=3.7.3
ARG PY_USER=jc
ARG PY_UID=1000
ARG PY_GID=1000
ARG PY_ROOT=/opt/python-$PY_VERSION
ARG CENTOS_PACKAGES
ARG PIP_PACKAGES

RUN groupadd -g $PY_GID $PY_USER && \
	useradd -u $PY_UID -g $PY_GID $PY_USER && \
	mkdir -p $PY_ROOT && \
	mkdir -p /opt/py_build/ && cd /opt/py_build && \
	curl -O "https://www.python.org/ftp/python/$PY_VERSION/Python-$PY_VERSION.tgz" && \
	tar -xf Python-$PY_VERSION.tgz && \
	chown -R $PY_USER:$PY_USER $PY_ROOT /opt/py_build && \
	yum group install -y "Development Tools" && \
	yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel \
		readline-devel tk-devel gdbm-devel db4-devel libpcap-devel libffi-devel \
		$CENTOS_PACKAGES

USER $PY_USER
WORKDIR /opt/py_build/Python-$PY_VERSION

RUN ./configure --prefix=$PY_ROOT && \
	make && make install

RUN export PY_MAJOR_VERSION=${PY_VERSION:0:1} && \
	$PY_ROOT/bin/python$PY_MAJOR_VERSION -m ensurepip --upgrade && \
	$PY_ROOT/bin/pip$PY_MAJOR_VERSION install --upgrade pip $PIP_PACKAGES && \
	cd $PY_ROOT/.. && tar -zcf /opt/py_build/Python-Dist.tar.gz $(basename $PY_ROOT)

