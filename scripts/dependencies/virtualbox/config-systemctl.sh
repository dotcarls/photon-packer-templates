#!/usr/bin/env bash

# Vagrant private network will lead to long startup time without this
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service