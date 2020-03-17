 # Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=mybinary
BINARY_UNIX=$(BINARY_NAME)_unix
BINARYEN=binaryen

all: test build
build: 
	cd $(BINARYEN); cmake . && make; cd ..
	$(GOBUILD) -o $(BINARY_NAME) -v
test: 
	$(GOTEST) -v ./...
clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_UNIX)
run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)

generate-bindings:
	c-for-go -out ../ binaryen.yml

clean-bindings: 
	rm -f doc.go
	rm -f binaryengo.go
	rm -f cgo_helpers.h