HOST:=$(shell hostname)

build-vm:
	nixos-rebuild build-vm --flake .#${HOST}
	
vm: build-vm
	./result/bin/run-*-vm
