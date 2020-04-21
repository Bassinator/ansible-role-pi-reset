#!/bin/bash

molecule test --destroy never
rm -rf noobs
docker cp centos7:/downloads/noobs noobs
molecule destroy
