.PHONY: all remove install build clean update test

all: remove install build

remove:
	rm -rf .gitmodules && rm -rf .git/modules && rm -rf lib && touch .gitmodules 

install:
	forge install foundry-rs/forge-std --no-commit && forge install openzeppelin/openzeppelin-contracts --no-commit

build:
	forge build

clean:
	forge clean

update:
	forge update

test:
	forge test

audit:
	aderyn && slither .

create:
	@if [ -z "$(name)" ]; then \
		echo "Usage: make create name=<filename>"; \
		exit 1; \
	fi
	@./create.sh "$(name)"