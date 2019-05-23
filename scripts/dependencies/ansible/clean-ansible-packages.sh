#!/usr/bin/env bash

pip uninstall --yes setuptools
pip uninstall --yes ansible
tdnf --assumeyes erase python3-pip

rm /usr/bin/python