# Makefile

.SILENT:

cmp_cmd := docker compose run -it --rm chef

help:
	sed -nr 's/^(\w+):$$/\1/p' $(MAKEFILE_LIST)

ping:
	$(cmp_cmd) ansible all -m ansible.builtin.ping -o

lint:
	$(cmp_cmd) ansible-lint --offline -p /playbook /playbook/roles

test:
	$(cmp_cmd) ansible-playbook ./main.yml --check --diff

launch:
	$(cmp_cmd) sh

run:
	$(cmp_cmd) ansible-playbook ./main.yml

facts: # Probably not working as is
	$(cmp_cmd) ansible-cmdb -f /facts [-t /facts/markdown.tpl] > /facts/overview.md

release: IMAGE_NAME := bergalath/ansible-full:2.17-5
release:
	docker login
	docker build -t $(IMAGE_NAME) .
	docker push $(IMAGE_NAME)
