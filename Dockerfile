FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl jq git sudo docker.io ca-certificates && \
    apt-get clean

# Set runner version
ENV RUNNER_VERSION=2.325.0

# Create user and directories
RUN ugroupmod -g 988 docker && useradd -m runner && mkdir -p /actions-runner && chown runner:runner /actions-runner && usermod -aG docker runner
# RUN mkdir -p /actions-runner 
WORKDIR /actions-runner

# Download official GitHub Actions runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Install dependencies
RUN ./bin/installdependencies.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER runner
ENTRYPOINT ["/entrypoint.sh"]
