HOST:=$(shell hostname)

build-vm:
	nixos-rebuild build-vm --flake .#${HOST}
	
clean: 
	rm -rf ./result && rm ${HOST}.qcow2
	
vm: build-vm
	./result/bin/run-*-vm
