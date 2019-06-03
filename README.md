# Python-Dist-Builder

Dockerfile to build python distributions. Works for Python 2.7.9+ and 3.4+

### Usage

This needs a docker instance and network connectivity. Uses the old fashioned builder pattern.

To generate a distribution with Python 3.7.3 ..

```sh
$ docker build -t temp_py_build ./ ; docker create --name temp_py_build temp_py_build ; docker cp temp_py_build:/opt/py_build/Python-Dist.tar.gz ./ ; docker rm -f temp_py_build ; docker rmi -f temp_py_build:latest
```

Change the Python Version or Packages to be installed by passing build args in the docker build step ..

```sh
$ docker build -t temp_py_build --build-args PY_VERSION="<Required_Python_Version>" ./
```

### Build Args

The following build args are accepted.

| Arg | Default Value |
| ------ | ------ |
| PY_VERSION | 3.7.3 |
| PY_USER | jc |
| PY_UID | 1000 |
| PY_GID | 1000 |
| PY_ROOT | /opt/python-$PY_VERSION |
| CENTOS_PACKAGES |  |
| PIP_PACKAGES |  |

CENTOS_PACKAGES accepts a space delimited string. Can be provided if the packages to be installed need CentOS *-devel packages.

PIP_PACKAGES accepts a space delimited string. Place the packages you need installed via pip here.

