#!/bin/bash
efibootmgr \
	--disk /dev/sda --part 1 \
	--create --label "Arch Linux" \
	--loader /vmlinuz-linux \
	--unicode 'root=UUID=306401e2-5df3-4735-a439-3f77711599a9 rw initrd=/intel-ucode.img initrd=/initramfs-linux.img' \
	--verbose
