# docker build --no-cache --progress=plain -f .gitpod.Dockerfile .
FROM gitpod/workspace-full

# System
RUN bash -c "sudo install-packages gettext postgresql-client"
RUN bash -c "sudo apt-get update"
RUN bash -c "sudo pip install --upgrade pip"


#python
RUN pyenv install 3.11 \
    && pyenv global 3.11


# AWS CLIs
RUN bash -c "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip' && unzip awscliv2.zip \
    && sudo ./aws/install \
    && aws --version \
    "

RUN bash -c "npm install -g aws-cdk"

ARG SAM_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
RUN bash -c "curl -Ls '${SAM_URL}' -o '/tmp/aws-sam-cli-linux-x86_64.zip' \
    && unzip '/tmp/aws-sam-cli-linux-x86_64.zip' -d '/tmp/sam-installation' \
    && sudo '/tmp/sam-installation/install' \
    && sam --version"

#terraform
RUN bash -c "brew install terraform kubectl eksctl opentofu"