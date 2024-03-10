IMAGE_NAME=choisunguk/python_simple_http_server

create-builder:
	docker buildx create --name mybuilder --use

build-push:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):ipv4 -f ipv4.Dockerfile --push .
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):ipv6 -f ipv6.Dockerfile --push .

.PHONY: create-builder build-push
