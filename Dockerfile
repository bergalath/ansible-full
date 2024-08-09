FROM alpine:3.20

ARG ANSIBLE_VERS=10.2.0

RUN apk add --update --no-cache ca-certificates openssh-client git rsync python3 py3-cryptography py3-pip patch && \
    rm -rf /usr/lib/python*/EXTERNALLY-MANAGED && \
    python -m pip install --no-cache-dir --upgrade mitogen ansible==${ANSIBLE_VERS} ansible-core ansible-lint \
        git+https://github.com/dirks/ansible-cmdb.git@replace-imp && \
    wget https://patch-diff.githubusercontent.com/raw/mitogen-hq/mitogen/pull/1082.patch -O - | patch -d /usr/lib/python3.12/site-packages/ansible_mitogen && \
    sed -i -e 's/re.match("/re.match(r"/g' /usr/lib/python3.12/site-packages/ansiblecmdb/parser.py && \
    sed -i -e 's/\\.desc/.desc/g' /usr/lib/python3.12/site-packages/jsonxs/jsonxs.py && \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf && \
    rm -rf /var/cache/apk/* /tmp/*

WORKDIR /playbook
ENV SSH_AUTH_SOCK=/run/ssh-agent
ARG USER=ansible
RUN adduser -D -u 1000 $USER
USER $USER
CMD [ "ansible-playbook", "--version" ]
