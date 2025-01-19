PROTO_SRC_DIR := proto
GEN_GO_DIR := gen/go
PROTO_FILES := $(shell find $(PROTO_SRC_DIR) -name "*.proto")

generate:
	@echo "Generating Go code from .proto files..."
	@protoc -I $(PROTO_SRC_DIR) \
		$(PROTO_FILES) \
		--go_out=$(GEN_GO_DIR) --go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_GO_DIR) --go-grpc_opt=paths=source_relative
	@echo "Generation completed."

install-tools:
	@echo "Installing protoc-gen-go and protoc-gen-go-grpc..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@echo "Tools installed successfully."

clean:
	@echo "Cleaning generated files..."
	@rm -rf $(GEN_GO_DIR)
	@echo "Clean completed."

help:
	@echo "Available commands:"
	@echo "  make generate      - Generate Go code from .proto files"
	@echo "  make install-tools - Install protoc-gen-go and protoc-gen-go-grpc plugins"
	@echo "  make clean         - Remove generated files"
