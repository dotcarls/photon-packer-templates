# VMware Photon 3.0 Packer Templates

<!-- TOC -->

- [VMware Photon 3.0 Packer Templates](#vmware-photon-30-packer-templates)
    - [Description](#description)
    - [Prerequisites](#prerequisites)
    - [Providers](#providers)
    - [Examples](#examples)
    - [Usage](#usage)
        - [Configuration](#configuration)
            - [Vagrant Cloud Publishing](#vagrant-cloud-publishing)
            - [Photon Base ISO](#photon-base-iso)
            - [VirtualBox Guest Additions](#virtualbox-guest-additions)
            - [AWS Builder configuration](#aws-builder-configuration)

<!-- /TOC -->

## Description

This repository can be used to build Vagrant boxes for the VMware's [Photon](https://github.com/vmware/photon) OS using HashiCorp's [Packer](http://packer.io). It is a fork of the 'official' VMware [photon-packer-templates](https://github.com/vmware/photon-packer-templates) repository. The primary difference is that this repository drops Photon 2.x support and instead specifically targets Photon 3.0. 

## Prerequisites

* [Packer](http://packer.io) >= 1.3.5

## Providers

The Packer template has builder definitions for the following providers:

* [VMware (vmware-iso)](https://www.packer.io/docs/builders/vmware-iso.html)
* [Virtualbox (virtualbox-iso)](https://www.packer.io/docs/builders/virtualbox-iso.html)
* [AWS (amazon-ebs)](https://www.packer.io/docs/builders/amazon-ebs.html)

## Examples

These templates are used to build the [dotcarls/photon3](https://app.vagrantup.com/dotcarls/boxes/photon3) Vagrant boxes available on Vagrant Cloud. There are example `Vagrantfile`'s available in the `examples` directory:

```shell
» cd examples/virtualbox
» vagrant up
Bringing machine 'photon3' up with 'virtualbox' provider...
...
```

## Usage

Use the included `Makefile` targets to perform various Packer tasks. There are three top-level targets:

* `validate`
* `build`
* `publish`

These top-level targets will use all builders. There are additional targets for each specific provider. Run `make help` to see all available targets:

```shell
» make help
Targets:
  validate
    validate-vagrant-virtualbox-iso
    validate-vagrant-vmware-iso
    validate-vagrant-aws-ami
   
  build
    build-vagrant-virtualbox-iso
    build-vagrant-vmware-iso
    build-vagrant-aws-ami
   
  publish
    publish-vagrant-virtualbox-iso
    publish-vagrant-vmware-iso
    publish-vagrant-aws-ami
```

### Configuration

The `vars/3.0GA.json` var file contains all user-defined variables for all providers.

#### Vagrant Cloud Publishing

To publish to your own Vagrant Cloud account, call `publish[-*]` targets with the following environment variables set:

```shell
VAGRANT_BOX_TAG="<your account>/<your box>"
VAGRANT_BOX_VERSION="<sets the box version>"
VAGRANT_CLOUD_TOKEN="<your client token>"
```

The `VAGRANT_CLOUD_TOKEN` must be exposed as an environment variable, however the other variables can be specified in `Makefile`.

#### Photon Base ISO

The following variables can be used to define the base ISO used for all builds:

```json
"product_version" : "3.0GA",
"iso_sha1sum" : "1c38dd6d00e11d3cbf7768ce93fc3eb8913a9673",
"iso_file" : "http://dl.bintray.com/vmware/photon/3.0/GA/iso/photon-3.0-26156e2.iso",
```

#### VirtualBox Guest Additions

The following variables can be used to define the version of VirtualBox guest additions to be installed:

```json
"virtualbox_guest_additions_version": "6.0.6",
"virtualbox_guest_additions_sha256": "832152b63630ceb2f89fb460eeb35b74a1218df903758157f785122392d32ceb",
```

#### AWS Builder configuration

The following variables can be used to define the AWS configuration for the `amazon-ebs` builder:

```json
"aws_profile": "default",
"aws_region": "us-west-1",
"aws_source_ami_us_west_1": "ami-0576199ca1b362d73",
"aws_source_ami_us_west_2": "ami-0a94981ba259c30d6",
"aws_ssh_keypair_name": "CHANGEME",
"aws_ssh_private_key_file": "/path/to/keypair"
```
