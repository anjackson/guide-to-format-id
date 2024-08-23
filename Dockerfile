FROM ghcr.io/anjackson/format-id-toolbox:master

RUN python3 -m pip install --no-cache-dir notebook jupyterlab

### create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

RUN pip install --no-cache-dir pandas altair requests


# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
RUN chsh -s /bin/bash ${NB_USER}
USER ${NB_USER}

WORKDIR ${HOME}
RUN jupyter trust 01-Ident-O-Matic.ipynb

