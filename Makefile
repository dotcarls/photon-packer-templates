###################################################################
# Default variables
###################################################################
THIS_FILE               := $(lastword $(MAKEFILE_LIST))

PACKER_VAR_FILE         := vars/3.0GA.json
PACKER_TEMPLATE_FILE    := packer-photon.json
PACKER_ARGS             := -var-file=$(PACKER_VAR_FILE) $(PACKER_TEMPLATE_FILE)
PACKER_BUILDERS         := vagrant-virtualbox-iso vagrant-vmware-iso vagrant-aws-ami

VAGRANT_BOX_TAG         ?= dotcarls/photon3
VAGRANT_BOX_VERSION     ?= 0.0.2
VAGRANT_PUBLISH_ARGS    := -var vagrant_box_tag=$(VAGRANT_BOX_TAG) -var vagrant_box_version=$(VAGRANT_BOX_VERSION)

###################################################################
# Help targets (keep up to date with changes)
###################################################################

.PHONY: help

help:
	@echo "Targets:"
	@echo "  validate"
	@echo "    $(addsuffix \n   , $(addprefix validate-, $(PACKER_BUILDERS)))"
	@echo "  build"
	@echo "    $(addsuffix \n   , $(addprefix build-, $(PACKER_BUILDERS)))"
	@echo "  publish"
	@echo "    $(addsuffix \n   , $(addprefix publish-, $(PACKER_BUILDERS)))"

###################################################################
# Packer targets
###################################################################
.PHONY: validate* build* publish* update*

validate:
	@echo "=> Validating all builders"
	packer validate $(PACKER_ARGS) $(VAGRANT_PUBLISH_ARGS) $(VAGRANT_PUBLISH_ARGS)

validate-%:
	@echo "Validating builder: $(patsubst validate-%,%, $@)"
	packer validate -only=$(patsubst validate-%,%, $@) $(VAGRANT_PUBLISH_ARGS) $(PACKER_ARGS)

build: validate
	@echo "Building with all builders"
	packer build -except=vagrant-cloud $(PACKER_ARGS)

build-%:
	@$(MAKE) -f $(THIS_FILE) validate-$(patsubst build-%,%, $@)
	@echo "Building with builder: $(patsubst build-%,%, $@)"
	packer build -only=$(patsubst build-%,%, $@) -except=vagrant-cloud $(PACKER_ARGS)

publish: validate
	@echo "Publishing artifacts from all builders"
	packer build $(VAGRANT_PUBLISH_ARGS) $(PACKER_ARGS)

publish-%:
	@$(MAKE) -f $(THIS_FILE) validate-$(patsubst publish-%,%, $@)
	@echo "Publishing artifact from builder: $(patsubst publish-%,%, $@)"
	packer build -only=$(patsubst publish-%,%, $@) $(VAGRANT_PUBLISH_ARGS) $(PACKER_ARGS)
