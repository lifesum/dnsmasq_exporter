GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)

default: build

build: fmt
	go build -ldflags="-s -w" -o bin/dnsmasq_exporter

fmt:
	gofmt -w $(GOFMT_FILES)

linux:
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/dnsmasq_exporter

release: linux
	@aws s3 cp bin/dnsmasq_exporter s3://$$BUCKET/releases/archive/dnsmasq_exporter/latest
