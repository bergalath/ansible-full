# FROM alpine:latest AS builder-ansible-cmdb

# ADD https://github.com/dirks/ansible-cmdb/archive/refs/heads/replace-imp.tar.gz /
# RUN tar -vxzf *.tar.gz && ls -la /ansible-cmdb-replace-imp

FROM python:3.12-alpine

ARG ANSIBLE_VERS=9.7.0

ENV SSH_AUTH_SOCK=/run/ssh-agent

RUN adduser -D ansible && \
    apk --no-cache add ca-certificates openssh-client rsync && \
    pip3 install --no-cache-dir --upgrade cryptography mitogen jmespath \
      yamllint ansible-lint ansible==${ANSIBLE_VERS} && \
    rm -rf /var/cache/apk/* /root/.cache/pip

# COPY --from=builder-ansible-cmdb /ansible-cmdb-replace-imp/src /usr/local/lib/ansible-cmdb
# COPY --from=builder-ansible-cmdb /ansible-cmdb-replace-imp/lib /usr/local/lib/ansible-cmdb
# RUN ln -s /usr/local/lib/ansible-cmdb/ansible-cmdb /usr/local/bin/

WORKDIR /playbook
USER ansible

CMD [ "ansible-playbook", "./main.yml", "--check", "--diff" ]
