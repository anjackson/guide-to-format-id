FROM python:3.7-stretch

RUN pip install --no-cache notebook bash_kernel
RUN python -m bash_kernel.install

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

RUN wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | apt-key add -  && \
    echo "deb http://dl.bintray.com/siegfried/debian wheezy main" | tee -a /etc/apt/sources.list  && \
    apt-get update && apt-get install -y siegfried && apt-get install -y default-jre

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# TEMP
