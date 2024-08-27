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
RUN chown -R ${NB_UID} ${HOME}

# Set the working directory
WORKDIR ${HOME}

# Switch to the run-time user
USER ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY welcome.ipynb README.md ./
ADD notebooks notebooks
ADD test-files test-files

# Set up the workspace so the startup looks consistent
COPY default.jupyterlab-workspace workspace.json
RUN jupyter lab workspaces import workspace.json && rm workspace.json
