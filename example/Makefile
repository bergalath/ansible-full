# Makefile

.SILENT:

full_docker_cmd := docker run -it --rm -v ./playbook:/playbook -v ./facts:/facts \
	-v $$SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent \
	bergalath/ansible-full:2.17-1

ping:
	$(full_docker_cmd) ansible all -m ansible.builtin.ping -o

lint:
	$(full_docker_cmd) ansible-lint --offline -p /playbook /playbook/roles

test:
	$(full_docker_cmd) ansible-playbook ./main.yml --check --diff

shell:
	$(full_docker_cmd) sh

run:
	$(full_docker_cmd) ansible-playbook ./main.yml

facts: # Probably not working as is
	$(full_docker_cmd) ansible-cmdb -f /facts [-t /facts/markdown.tpl] > /facts/overview.md
