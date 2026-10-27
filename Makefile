MODULE := github.com/atbuy/plank
BIN ?= bin/plank

GO ?= go
GOFUMPT ?= gofumpt
GOIMPORTS_REVISER ?= goimports-reviser
GOLANGCI_LINT ?= golangci-lint
ZENSICAL ?= zensical
ARGS ?= --help

.PHONY: help fmt lint test build install run clean

help:
	@printf '%s\n' \
		'Targets:' \
		'  make fmt          Format Go files with gofumpt and goimports-reviser' \
		'  make lint         Run golangci-lint' \
		'  make test         Run Go tests' \
		'  make build        Build bin/carrier' \
		'  make install      Install plank with go install' \
		'  make clean        Remove build files' \
		'  make run ARGS=... Run plank locally' \

fmt:
	$(GOFUMPT) -w .
	$(GOIMPORTS_REVISER) -recursive -rm-unused -format -project-name $(MODULE) ./...

lint:
	$(GOLANGCI_LINT) run ./...

test:
	$(GO) test -cover ./...

build:
	$(GO) build -o $(BIN) ./cmd/plank

install:
	$(GO) install ./cmd/plank

run:
	$(GO) run ./cmd/plank $(ARGS)

clean:
	$(GO) clean
