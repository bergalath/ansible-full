## [ansible-full](https://hub.docker.com/r/bergalath/ansible-full)

Minimal Docker image with

- python 3.1x
- [ansible 2.17 (10.x)](https://docs.ansible.com/ansible/latest/)
- [ansible-lint](https://ansible.readthedocs.io/projects/lint/)
- [mitogen](https://mitogen.networkgenomics.com/ansible_detailed.html)
- [ansible-cmdb](https://github.com/fboender/ansible-cmdb) (shamelessly using [@dirks](https://github.com/dirks)’s [fork with python 3.12+ support](https://github.com/dirks/ansible-cmdb/tree/replace-imp))

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
docker run -it --rm -v ./playbook:/playbook -v ./facts:/facts -v $SSH_AUTH_SOCK:/run/ssh-agent \
  bergalath/ansible-full:2.17-4 ansible-playbook ./main.yml --check --diff
```

Yeah, it’s a bit tedious, so take a look at this minimal [Makefile](example/Makefile)

Happy Ansiblin’ with mitogen speed !

## Ansible 2.16 (9.7.0) image

> [!WARNING]
> [ansible 2.17 dropped support for python < 3 on managed nodes](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix)

Another image, bergalath/ansible-full:2.16, is availabe with

- python 3.12
- ansible 2.16 (9.7.0)
- [ansible-lint](https://ansible.readthedocs.io/projects/lint/)
- [mitogen](https://mitogen.networkgenomics.com/ansible_detailed.html)
- [ansible-cmdb](https://github.com/fboender/ansible-cmdb) (shamelessly using [@dirks](https://github.com/dirks)’s [fork with python 3.12 support](https://github.com/dirks/ansible-cmdb/tree/replace-imp))
