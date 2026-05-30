FROM ghcr.io/armckinney/terraform-azure:2.73.0

# set workspace directory
ARG WORKSPACE=/workspaces/cicd
ENV WORKSPACE=${WORKSPACE}

# avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /tmp/container \
    && cd /tmp/container \
    # supporting installs
    && apt-get update \
    # primary installs
    && curl -sSL https://raw.githubusercontent.com/armckinney/verge/main/install.sh | bash \
    # clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/container

WORKDIR ${WORKSPACE}

# switch back to dialog for any ad-hoc use of apt
ENV DEBIAN_FRONTEND=dialog
