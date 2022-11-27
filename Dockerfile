FROM alpine:latest
# Based on: https://github.com/drillan/docker-alpine-jupyterlab
RUN apk update \
&& apk add \
    ca-certificates \
    libstdc++ \
    python3 \
    py3-pip \
    py3-numpy py3-scipy py3-matplotlib py3-pandas py3-tqdm py3-psutil \
    proj-util geos git \
&& apk add --virtual=build_dependencies \
    cmake \
    gcc \
    g++ \
    make \
    musl-dev \
    linux-headers \
    python3-dev \
    cython \
    geos-dev \
    proj-dev \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& python3 -m pip --no-cache-dir install \
    obspy \
    cartopy \
    jupyter \
    jupyterlab \
&& jupyter serverextension enable --py jupyterlab --sys-prefix \
&& apk del --purge -r build_dependencies \
&& rm -rf /var/cache/apk/* \
&& mkdir /notebooks

ADD Welcome.ipynb /Welcome.ipynb
ENTRYPOINT cp /Welcome.ipynb /notebooks && /usr/bin/jupyter lab --allow-root --no-browser --ip=0.0.0.0 --notebook-dir=/notebooks
EXPOSE 8888
