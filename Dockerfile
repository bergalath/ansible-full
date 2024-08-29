FROM alpine:3.20

ARG ANSIBLE_VERS=10.3.0

RUN apk add --update --no-cache ca-certificates openssh-client ruby ruby-rdoc \
        python3 py3-cryptography py3-pip && \
    rm -rf /usr/lib/python*/EXTERNALLY-MANAGED && \
    python -m pip install --no-cache-dir --upgrade ansible==${ANSIBLE_VERS} \
        ansible-core ansible-lint mitogen toml \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf && \
    rm -rf /var/cache/apk/* /tmp/*

WORKDIR /playbook
ENV SSH_AUTH_SOCK=/run/ssh-agent
ARG USER=ansible
RUN adduser -D -u 1000 $USER
USER $USER
CMD [ "ansible-playbook", "--version" ]
