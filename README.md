## [ansible-full](https://hub.docker.com/r/bergalath/ansible-full)

Minimal Docker image with [ansible](https://docs.ansible.com/ansible/latest/), [ansible-lint](https://ansible.readthedocs.io/projects/lint/), [mitogen](https://mitogen.networkgenomics.com/ansible_detailed.html) and [more to come ?](https://github.com/fboender/ansible-cmdb)

## Usage

Considering the [`example`](example) folder

```
project
  ├── Makefile
  ├── facts
  │   ├── logs
  │   │   ├── log_files
  │   │   └── …
  │   ├── host_facts
  │   └── …
  ├── playbook
  ┊   ├── roles
      │   ├── role_1
      │   ├── role_2
      │   └── …
      ├── .gitignore
      ├── ansible.cfg
      ├── hosts.ini
      └── main.yml
```

Then this command will run your Playbook, in **check mode** by default, in a new container

```bash
docker run -it --rm -v ./playbook:/playbook -v ./facts:/facts \
  -v $SSH_AUTH_SOCK:/run/ssh-agent bergalath/ansible-full:2
```

Yeah, it’s a bit tedious, so take a look at this minimal [Makefile](example/Makefile)

Happy Ansiblin’ with mitogen speed !
