# Ansible Role: pi-reset

[![Build Status](https://travis-ci.com/Bassinator/ansible-role-pi-reset.svg?branch=master)](https://travis-ci.com/Bassinator/ansible-role-pi-reset)

A role to create a SD card with operating system and factory reset capability for a raspberry pi


## Requirements

None.

## Role Variables

Available variables are listed below, along with default values:

    download_dir: '/vagrant/downloads'
    os_download_link: 'http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2018-04-19/2018-04-18-raspbian-stretch-lite.zip'



## Dependencies

None.


## Example Playbook


    - hosts: localhost
      roles:
         - { role: bassinator.pi-reset }

## License

GNU GPLv3

## Author Information
This role was created in 2018 by [Bastian Bukatz](https://bassinator.github.io).
