## settings
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -euo pipefail -c

## default target
.PHONY: help
help:
	@grep -h -E '^[[:space:]]*[A-Za-z0-9_.-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sed -E 's/^[[:space:]]*//' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;34m%-15s\033[m \xE2\x80\x94 %s\n", $$1, $$2}'

.PHONY: build-lib
build-lib: clean
	./tools/build.sh

clean:
	@rm -rf build

purge: 
	@rm -rf build lib

fmt: ## Format code
	@clang-format \
	-style='{
		BasedOnStyle: LLVM,
		BinPackArguments: false,
		BinPackParameters: false,
		AlignAfterOpenBracket: AlwaysBreak,
		AllowAllArgumentsOnNextLine: false,
		ContinuationIndentWidth: 2
		}' \
	-i src/*.c
	@rm -rf ./.clang-format

run:
	@gcc -std=c2x -O3 -march=native -Wall -Wextra \
		-I./lib/include/ta-lib \
		src/main.c \
		./lib/lib/libta-lib.a \
		-lm \
		-o bin/main

	@bin/main
