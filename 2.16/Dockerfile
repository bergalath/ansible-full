FROM alpine:3.20

ARG ANSIBLE_VERS=9.7.0

RUN adduser -D -u 1000 ansible && \
    apk --update --no-cache add ca-certificates openssh-client rsync python3 py3-cryptography py3-pip && \
    apk --update --no-cache add --virtual .build-deps git && \
    rm -rf /usr/lib/python*/EXTERNALLY-MANAGED && \
    python -m pip install --no-cache-dir --upgrade mitogen ansible==${ANSIBLE_VERS} ansible-core ansible-lint \
        git+https://github.com/dirks/ansible-cmdb.git@replace-imp && \
    sed -i -e 's/re.match("/re.match(r"/g' /usr/lib/python3.12/site-packages/ansiblecmdb/parser.py && \
    sed -i -e 's/\\.desc/.desc/g' /usr/lib/python3.12/site-packages/jsonxs/jsonxs.py && \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf && \
    apk del .build-deps && rm -rf /var/cache/apk/* /tmp

WORKDIR /playbook

CMD [ "ansible-playbook", "--version" ]
