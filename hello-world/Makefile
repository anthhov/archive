REPO_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUILD_PATH ?= $(REPO_PATH)/out

all: src/hello.c
	mkdir $(BUILD_PATH)
	$(CC) -o $(BUILD_PATH)/hello src/hello.c

clean:
	rm -rf $(BUILD_PATH)
