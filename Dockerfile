ARG token

FROM ubuntu


RUN apt update
RUN apt install -y curl perl aspnetcore-runtime-6.0

RUN mkdir /actions-runner
WORKDIR /actions-runner

RUN curl -o actions-runner-linux-x64-2.302.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.302.1/actions-runner-linux-x64-2.302.1.tar.gz

# RUN echo "3d357d4da3449a3b2c644dee1cc245436c09b6e5ece3e26a05bb3025010ea14d  actions-runner-linux-x64-2.302.1.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-x64-2.302.1.tar.gz

RUN adduser github --disabled-password
RUN chown -R github .

USER github
RUN ./config.sh --url https://github.com/evers-homestead --token ABXBRUXBT6W23XSVQXJTV23EB7YGG

ENTRYPOINT [ "/bin/sh", "-c", "./run.sh" ]