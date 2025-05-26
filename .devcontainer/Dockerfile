FROM armck/terraform:1.10.5

# set workspace directory
ARG WORKSPACE=/workspaces/cicd
ENV WORKSPACE=${WORKSPACE}

# avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /tmp/container \
    && cd /tmp/container \
    # signing key locations
    && mkdir -p /etc/apt/keyrings \
    && apt update \
    # clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/container

WORKDIR ${WORKSPACE}

# switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
