# Start with a custom image with pre-installed tools:
FROM ghcr.io/digipres/toolbox:v1.4.1

# Add the Jupyter things we need
RUN pip install --no-cache-dir jupyterlab notebook pandas altair requests bash_kernel && python -m bash_kernel.install

# Switch off announcements pop-up
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Do required setup for running on Binder...
# https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
ENV SHELL /bin/bash

# Create user with a home directory
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    --shell ${SHELL} \
    ${NB_USER}

# Set the working directory
WORKDIR ${HOME}

# Make sure the contents of our repo are in ${HOME}
COPY welcome.ipynb README.md ./
COPY rclone.conf .config/rclone/rclone.conf
ADD notebooks notebooks
ADD test-files test-files

# Set up the workspace so the startup looks consistent
COPY default.jupyterlab-workspace workspace.json
RUN jupyter lab workspaces import workspace.json && rm workspace.json

# Also install the lc-shell files in case anyone wants them:
RUN curl -O -L https://librarycarpentry.org/lc-shell/data/shell-lesson.zip && \
    unzip shell-lesson.zip -d shell-lesson -x '__MACOSX/*' && \
    rm shell-lesson.zip

# Switch to the run-time user
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
