#!/usr/bin/env bash

tdnf --assumeyes install python3-pip
pip3 install --upgrade pip
pip install setuptools
pip install ansible
ln -s /usr/bin/python3.7 /usr/bin/python