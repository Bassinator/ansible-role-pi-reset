FROM bassualdo/ubuntu18.04-ansible

COPY . /etc/ansible/roles/bassinator.pi_reset/
CMD ansible-playbook --connection=local -i 172.0.0.1, /etc/ansible/roles/bassinator.pi_reset/playbook.yml

