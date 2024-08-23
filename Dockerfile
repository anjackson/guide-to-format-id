FROM ghcr.io/anjackson/format-id-toolbox:master

# Make sure the libraries we need are there:
RUN python3 -m pip install --no-cache-dir notebook jupyterlab

### Create user with a home directory:
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
ENV SHELL /bin/bash

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    --shell ${SHELL} \
    ${NB_USER}

# Add some handy stuff:
RUN pip install --no-cache-dir pandas altair requests

# Switch off announcements pop-up:
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Make sure the contents of our repo are in ${HOME}:
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Set the working directory etc.:
WORKDIR ${HOME}
RUN jupyter trust 01-Ident-O-Matic.ipynb

