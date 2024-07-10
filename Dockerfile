# FROM alpine:latest AS builder-ansible-cmdb

# ADD https://github.com/dirks/ansible-cmdb/archive/refs/heads/replace-imp.tar.gz /
# RUN tar -vxzf *.tar.gz && ls -la /ansible-cmdb-replace-imp

FROM alpine:3.20

RUN apk --update --no-cache add ca-certificates openssh-client rsync sshpass \
      python3 py3-cryptography py3-pip py3-yaml && \
    rm -rf /usr/lib/python*/EXTERNALLY-MANAGED

ARG ANSIBLE_VERS=9.7.0

RUN apk --update --no-cache add --virtual .build-deps build-base libffi-dev python3-dev && \
    pip install --no-cache-dir --upgrade --no-binary cffi ansible==${ANSIBLE_VERS} ansible-lint mitogen && \
    apk del .build-deps && rm -rf /var/cache/apk/* && \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

# COPY --from=builder-ansible-cmdb /ansible-cmdb-replace-imp/src /usr/local/lib/ansible-cmdb
# COPY --from=builder-ansible-cmdb /ansible-cmdb-replace-imp/lib /usr/local/lib/ansible-cmdb
# RUN ln -s /usr/local/lib/ansible-cmdb/ansible-cmdb /usr/local/bin/

WORKDIR /playbook

CMD [ "ansible-playbook", "--version" ]
