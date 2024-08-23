FROM ghcr.io/anjackson/format-id-toolbox:master

### create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}

RUN pip install appmode && \
    jupyter nbextension     enable --py --sys-prefix appmode && \
    jupyter serverextension enable --py --sys-prefix appmode

RUN pip install fileupload && \
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter nbextension install --user --py fileupload && \
    jupyter nbextension enable  --user --py fileupload

RUN pip install pandas altair requests

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN jupyter trust 01-Ident-O-Matic.ipynb

# TEMP
