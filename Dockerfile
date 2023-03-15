FROM ubuntu:22.04

# Setup Github Runner
RUN apt update
RUN apt install -y curl perl aspnetcore-runtime-6.0 jq

RUN mkdir /actions-runner
WORKDIR /actions-runner

RUN curl -o actions-runner-linux-x64-2.302.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.302.1/actions-runner-linux-x64-2.302.1.tar.gz

RUN echo "3d357d4da3449a3b2c644dee1cc245436c09b6e5ece3e26a05bb3025010ea14d  actions-runner-linux-x64-2.302.1.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-x64-2.302.1.tar.gz

ADD start.sh ./start.sh
RUN chmod +x start.sh

RUN adduser github --disabled-password
RUN chown -R github .

# Add docker to run build containers
RUN apt install -y docker.io

USER github
ENTRYPOINT [ "/bin/sh", "-c", "./start.sh" ]