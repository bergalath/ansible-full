FROM alpine:3.20

ARG ANSIBLE_VERS=10.1.0

RUN adduser -D -u 1000 ansible && \
    apk --update --no-cache add ca-certificates openssh-client rsync python3 py3-cryptography py3-pip patch && \
    apk --update --no-cache add --virtual .build-deps git && \
    rm -rf /usr/lib/python*/EXTERNALLY-MANAGED && \
    python -m pip install --no-cache-dir --upgrade mitogen ansible==${ANSIBLE_VERS} ansible-core ansible-lint \
        git+https://github.com/dirks/ansible-cmdb.git@replace-imp && \
    wget https://patch-diff.githubusercontent.com/raw/mitogen-hq/mitogen/pull/1082.patch -O - | patch -d /usr/lib/python3.12/site-packages/ansible_mitogen && \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf && \
    apk del .build-deps && rm -rf /var/cache/apk/* /tmp

WORKDIR /playbook

CMD [ "ansible-playbook", "--version" ]
