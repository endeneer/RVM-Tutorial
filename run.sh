#!/bin/bash

ARCH=x86_64

BIOS_IMG=rvm-bios.bin
GUEST_IMG=nimbos.bin
target_elf=rvm-hypervisor

qemu-system-$ARCH \
	-nographic -m 128M \
	-cpu host,+x2apic,+vmx -accel kvm \
	-device loader,addr=0x4000000,file=$BIOS_IMG,force-raw=on \
	-device loader,addr=0x4001000,file=$GUEST_IMG,force-raw=on \
	-machine q35 \
	-serial mon:stdio \
	-kernel $target_elf

