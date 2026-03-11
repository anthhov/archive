IMAGE_NAMETAG := $(IMAGE_NAME):$(IMAGE_TAG)

all:
	docker build --tag $(IMAGE_NAMETAG) --file $(DOCKERFILE) .

clean:
	docker rmi -f $(IMAGE_NAMETAG)
