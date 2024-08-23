FROM ghcr.io/digipres/toolbox:v1.2.0

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

# Do some funky stuff so sudo works so apt-get can work:
# https://askubuntu.com/questions/452860/usr-bin-sudo-must-be-owned-by-uid-0-and-have-the-setuid-bit-set
# https://askubuntu.com/questions/147241/execute-sudo-without-password
RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo && \
    echo "$NB_USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$NB_USER

# Add some handy stuff:
RUN pip install --no-cache-dir pandas altair requests

# Switch off announcements pop-up:
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Set the working directory:
WORKDIR ${HOME}

# Make sure the contents of our repo are in ${HOME}:
COPY welcome.ipynb README.md ./
ADD notebooks notebooks
ADD test-files test-files
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Set up the workspace so the startup looks consistent:
COPY default.jupyterlab-workspace workspace.json
RUN jupyter lab workspaces import workspace.json && rm workspace.json
