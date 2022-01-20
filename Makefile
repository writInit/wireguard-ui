-include env_make

WGUI_VER ?= 0.3.5

TAG ?= $(WGUI_VER)

REPO = wr4itatusa/wgui
NAME = wgui-$(WGUI_VER)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif


.PHONY: build  test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) ./

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

clean:
	-docker rm -f $(NAME)

release: build push

