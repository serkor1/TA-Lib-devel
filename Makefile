## settings
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -euo pipefail -c

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
	-i src/*.c src/*.h
	@rm -rf ./.clang-format

run:
	gcc -std=c2x -O3 -march=native -Wall -Wextra \
		-I./lib/include/ta-lib \
		src/main.c \
		./lib/lib/libta-lib.a \
		-lm \
		-o bin/main

	bin/main
