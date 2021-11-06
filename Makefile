# Shell options
RM	?= rm
FIND	?= find
MKDIR	?= mkdir

# Git options
GIT	?= git

# Protocol Buffers options
PROTOC	?= protoc

# Path variables
SRC_DIR	  := $(CURDIR)/src

.DEFAULT_GOAL := build

.PHONY: clean
clean:
	$(RM) -rf $(CURDIR)/proto
	
.PHONY: build
build: clean
	$(PROTOC) --proto_path=myblog-proto \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		proto/auth/service.proto \
		proto/auth/user.proto
	$(PROTOC) --proto_path=myblog-proto \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		proto/blog/service.proto \
		proto/blog/engagement.proto \
		proto/blog/post.proto \
		proto/blog/taxonomy.proto
	$(PROTOC) --proto_path=myblog-proto \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		proto/discussion/service.proto \
		proto/discussion/comment.proto
	$(PROTOC) --proto_path=myblog-proto \
		--go_out=. --go_opt=paths=source_relative \
		proto/storage/file.proto

	
.PHONY: update
update:
	$(GIT) submodule foreach git pull