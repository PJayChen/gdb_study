CROSS_COMPILE ?= arm-none-eabi-
CC := $(CROSS_COMPILE)gcc
QEMU_STM32 ?= ../qemu_stm32/arm-softmmu/qemu-system-arm

ARCH = CM3
VENDOR = ST
PLAT = STM32F10x

LIBDIR = .
CMSIS_LIB=$(LIBDIR)/libraries/CMSIS/$(ARCH)
STM32_LIB=$(LIBDIR)/libraries/STM32F10x_StdPeriph_Driver

CMSIS_PLAT_SRC = $(CMSIS_LIB)/DeviceSupport/$(VENDOR)/$(PLAT)

all: example_1.bin

example_1.bin: example_1.s
	$(CROSS_COMPILE)as \
		-mcpu=cortex-m3 -mthumb \
		-g \
		-o example_1.o \
		example_1.s

	$(CROSS_COMPILE)ld \
		-Ttext 0x0 -o example_1.out \
		example_1.o

	$(CROSS_COMPILE)objcopy \
		-Obinary example_1.out example_1.bin

	$(CROSS_COMPILE)objdump \
		-S example_1.out > example_1.list
	
qemu: example_1.bin $(QEMU_STM32)
	$(QEMU_STM32) -M stm32-p103 -kernel example_1.bin

qemudbg: example_1.bin $(QEMU_STM32)
	$(QEMU_STM32) -M stm32-p103 \
		-gdb tcp::3333 -S \
		-kernel example_1.bin
clean:
	rm -f *.bin *.list *.o *.out
