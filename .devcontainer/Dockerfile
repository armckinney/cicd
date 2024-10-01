FROM armck/ubuntu:20.04

LABEL   deployable="false" \
        decription="This is the development image for the terraform-workflows project."

# ----- Environment Setup -----

# Set Workspace directory
ARG WORKSPACE=/workspaces/terraform-workflows
ENV WORKSPACE=${WORKSPACE}

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# ----- Primary Installs -----
# uses tmp install directory to keep from caching install downloads

RUN mkdir /tmp/dockerinstall && cd /tmp/dockerinstall \
    # Installs
    # Supporting Packages
    && apt-get update && apt-get -y install  \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common \
        wget \
    # Terraform Keys & Registry
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    # Primary Installs
    && apt-get update && apt-get -y install \
        terraform \
    && az extension add --name containerapp --upgrade \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/dockerinstall

# ----- Workspace Prep -----
WORKDIR ${WORKSPACE}

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
