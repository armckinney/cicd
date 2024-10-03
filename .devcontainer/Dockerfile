FROM armck/ubuntu:20.04 

ARG TERRAFORM_VERSION=1.9.5-1
ARG TERRAFORM_DOCS_VERSION=0.18.0
ARG TFLINT_VERSION=0.53.0
ARG TRIVY_VERSION=0.55.2

# Set Workspace directory
ARG WORKSPACE=/workspaces/data-eng-workspace
ENV WORKSPACE=${WORKSPACE}

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /tmp/dockerinstall && cd /tmp/dockerinstall \
    # install supporting utils
    && apt update && apt install -y \
        curl \
        gnupg \
        software-properties-common \
        unzip \
        wget \
    # trivy gpg key and source
    && wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | tee -a /etc/apt/sources.list.d/trivy.list \
    # install terraform-docs
    && curl -Lo terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-$(uname)-$(dpkg --print-architecture).tar.gz" \
    && tar -xzf terraform-docs.tar.gz \
    && chmod +x terraform-docs \
    && mv terraform-docs /usr/local/bin/terraform-docs \
    # install tflint
    && curl --fail -sS -L -o tflint.zip  "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_$(uname)_$(dpkg --print-architecture).zip" \ 
    && unzip -o tflint.zip \
    && mv tflint /usr/local/bin/tflint \
    # terraform gpg key & source
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list \    
    # # primary installs
    && apt update && apt install -y \
        terraform=${TERRAFORM_VERSION} \
        trivy=${TRIVY_VERSION} \
    #  Clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/dockerinstall

WORKDIR ${WORKSPACE}
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog