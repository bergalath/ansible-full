# Makefile

.SILENT:

full_docker_cmd := docker run -it --rm -v ./playbook:/playbook -v ./facts:/facts \
	-v $$SSH_AUTH_SOCK:/run/ssh-agent bergalath/ansible-full:2

ping:
	$(full_docker_cmd) ansible all -m ansible.builtin.ping -o

lint:
	$(full_docker_cmd) ansible-lint .

test:
	$(full_docker_cmd)

shell:
	$(full_docker_cmd) sh

run:
	$(full_docker_cmd) ansible-playbook ./main.yml
