NAME      := deploy
REGISTRY  := whiteplus/$(NAME)
VERSION   := 20170303

.PHONY: build tag push

build:
	docker build -t $(NAME):$(VERSION) ./$(VERSION)

tag: build
	docker tag $(NAME):$(VERSION) $(REGISTRY):$(VERSION)

push: tag
	docker push $(REGISTRY):$(VERSION)

