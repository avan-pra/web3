UNAME_S := $(shell uname -s)
build: 
	go build ./cmd/web3

install: build
	mkdir -p ${HOME}/.local/bin
	cp web3 ${HOME}/.local/bin
	@echo "web3 was install to ${HOME}/.local/bin don't forget to add it to your PATH"

builder:
	docker build -t gochain/builder:latest -f Dockerfile.build .

# We need to run this every so often when we want to update the go version used for the alpine release (only the alpine release uses this)
push-builder: builder
	docker push gochain/builder:latest

docker: 
	docker build -t gochain/web3:latest .

push: docker
	# todo: version these, or auto push this using CI
	docker push gochain/web3:latest

test:
	go test ./...

.PHONY: install test build docker release
