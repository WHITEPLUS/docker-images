NAME      := deploy
REGISTRY  := whiteplus/$(NAME)
VERSION   := 20170517

.PHONY: build tag push

build:
	cd $(VERSION); docker build -t $(NAME):$(VERSION) .

run:
	docker run -it $(NAME):$(VERSION) bash

tag: build
	docker tag $(NAME):$(VERSION) $(REGISTRY):$(VERSION)

push: tag
	docker push $(REGISTRY):$(VERSION)

