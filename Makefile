PROJ_NAME=httpserver

################################################################################
#                   SETUP TOOLS                                                #
################################################################################

#UPDATE this if you do not have the arm toolchain in your path
#https://launchpad.net/gcc-arm-embedded  is currently the recommended 
#toolchain for getting up to date tools it is recommended by the older
#summon arm toolchain which would not compile for me on ubuntu 13.10
TOOLS_DIR = 

#If necessary change this to reflect where you have unzipped the 
#	STM32F4DISCOVERY board firmware package http://www.st.com/web/en/catalog/tools/PF257904
STM_ROOT	=ST/STM32F4xx_Ethernet_Example
PROJECT		=$(STM_ROOT)/Project/FreeRTOS/httpserver_socket

CC      = $(TOOLS_DIR)arm-none-eabi-gcc
OBJCOPY = $(TOOLS_DIR)arm-none-eabi-objcopy
OBJDUMP = $(TOOLS_DIR)arm-none-eabi-objdump
GDB     = $(TOOLS_DIR)arm-none-eabi-gdb
AS      = $(TOOLS_DIR)arm-none-eabi-as

##### Preprocessor options

# directories to be searched for header files
INCLUDE = $(addprefix -I,$(INC_DIRS))

# defines needed when working with the STM peripherals library
DEFS    = -DUSE_STDPERIPH_DRIVER

#DEFS   += -DUSE_DHCP
#DEFS	+= -DMAC_ADDR0=0x00
#DEFS	+= -DMAC_ADDR1=0x1f
#DEFS	+= -DMAC_ADDR2=0xd0
#DEFS	+= -DMAC_ADDR3=0x3e
#DEFS	+= -DMAC_ADDR4=0xaa
#DEFS	+= -DMAC_ADDR5=0x96

# DEFS   += -DUSE_FULL_ASSERT

##### Assembler options

AFLAGS  = -mcpu=cortex-m4 
AFLAGS += -mthumb
#AFLAGS += -mthumb-interwork
AFLAGS += -mlittle-endian
AFLAGS += -mfloat-abi=hard
AFLAGS += -mfpu=fpv4-sp-d16

##### Compiler options

CFLAGS  = -g
CFLAGS  = -ggdb
CFLAGS += -O0
#CFLAGS += -Os
#CFLAGS += -Wall -Wextra -Warray-bounds
CFLAGS += -Wall
CFLAGS += -Wno-format
CFLAGS += $(AFLAGS)

##### Linker options

# tell ld which linker file to use
# (this file is in the current directory)
LFLAGS  = -Tstm32_flash.ld -Wl,-Map=$(PROJ_NAME).map,--cref


################################################################################
#                   SOURCE FILES DIRECTORIES                                   #
################################################################################

#STM_SRC_DIR     += $(STM_ROOT)/Libraries/STM32_USB_Device_Library/Core/src
#STM_SRC_DIR     += $(STM_ROOT)/Libraries/STM32_USB_OTG_Driver/src
STM_SRC_DIR     += $(STM_ROOT)/Libraries/STM32F4xx_StdPeriph_Driver/src
STM_SRC_DIR     += $(STM_ROOT)/Utilities/STM32F4-Discovery
STM_SRC_DIR     += $(STM_ROOT)/Utilities/lwip_v1.3.2/port/STM32F4x7/FreeRTOS
STM_SRC_DIR     += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/api
STM_SRC_DIR     += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/core
STM_SRC_DIR     += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/core/ipv4
STM_SRC_DIR     += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/netif
STM_SRC_DIR     += $(STM_ROOT)/Libraries/STM32F4x7_ETH_Driver/src

STM_SRC_DIR	+= $(STM_ROOT)/Utilities/FreeRTOS_v6.1.0/portable/MemMang
STM_SRC_DIR	+= $(STM_ROOT)/Utilities/FreeRTOS_v6.1.0
STM_SRC_DIR	+= $(STM_ROOT)/Utilities/FreeRTOS_v6.1.0/portable/GCC/ARM_CM3
STM_SRC_DIR	+= 
STM_SRC_DIR     += $(PROJECT)/src
STM_SRC_DIR     += .

#STM_STARTUP_DIR += $(STM_ROOT)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO
STM_STARTUP_DIR += .

vpath %.c $(STM_SRC_DIR)
vpath %.s $(STM_STARTUP_DIR)


################################################################################
#                   HEADER FILES DIRECTORIES                                   #
################################################################################

# The header files we use are located here

INC_DIRS += .
INC_DIRS += $(PROJECT)
INC_DIRS += $(PROJECT)/inc
INC_DIRS += $(STM_ROOT)/Libraries/CMSIS/Include
INC_DIRS += $(STM_ROOT)/Utilities/STM32F4-Discovery
INC_DIRS += $(STM_ROOT)/Libraries/CMSIS/Device/ST/STM32F4xx/Include
INC_DIRS += $(STM_ROOT)/Libraries/STM32F4x7_ETH_Driver/inc
INC_DIRS += $(STM_ROOT)/Libraries/STM32F4xx_StdPeriph_Driver/inc
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/port/STM32F4x7
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/port/STM32F4x7/FreeRTOS 
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/include
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/include/ipv4
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/include/lwip
INC_DIRS += $(STM_ROOT)/Utilities/lwip_v1.3.2/src/include/netif
INC_DIRS += $(STM_ROOT)/Utilities/FreeRTOS_v6.1.0/include
INC_DIRS += $(STM_ROOT)/Utilities/FreeRTOS_v6.1.0/portable/GCC/ARM_CM3


################################################################################
#                   SOURCE FILES TO COMPILE                                    #
################################################################################

#FreeRTOS portable
SRCS += heap_2.c
SRCS += port.c
SRCS += croutine.c
SRCS += list.c
SRCS += queue.c
SRCS += tasks.c

#LWIP
SRCS += api_lib.c
SRCS += api_msg.c
SRCS += autoip.c
SRCS += dhcp.c
SRCS += dns.c
SRCS += err.c
SRCS += etharp.c
SRCS += ethernetif.c
SRCS += icmp.c
SRCS += igmp.c
SRCS += inet.c
SRCS += inet_chksum.c
SRCS += init.c
SRCS += ip.c
SRCS += ip_addr.c
SRCS += ip_frag.c
SRCS += loopif.c
SRCS += mem.c
SRCS += memp.c
SRCS += netbuf.c
SRCS += netdb.c
SRCS += netif.c
SRCS += netifapi.c
SRCS += pbuf.c
SRCS += raw.c
SRCS += slipif.c
SRCS += sockets.c
SRCS += stats.c
SRCS += sys.c
SRCS += sys_arch.c
SRCS += tcp.c
SRCS += tcp_in.c
SRCS += tcp_out.c
SRCS += tcpip.c
SRCS += udp.c

# STM32F4-Discovery
SRCS += stm32f4_discovery.c
SRCS += stm32f4_discovery_lcd.c

# STM32F4x7_ETH_Driver
SRCS += stm32f4x7_eth.c

# STM32F4xx_StdPeriph_Driver
SRCS += misc.c
SRCS += stm32f4xx_adc.c
SRCS += stm32f4xx_dma.c
SRCS += stm32f4xx_exti.c
SRCS += stm32f4xx_fsmc.c
SRCS += stm32f4xx_gpio.c
SRCS += stm32f4xx_rcc.c
SRCS += stm32f4xx_sdio.c
SRCS += stm32f4xx_syscfg.c
SRCS += stm32f4xx_usart.c

# User
SRCS += fs.c
SRCS += httpserver-socket.c
SRCS += main.c
SRCS += netconf.c
SRCS += stm32f4x7_eth_bsp.c
SRCS += stm32f4xx_it.c
SRCS += system_stm32f4xx.c
SRCS += syscalls.c

ASRC += startup_stm32f4xx.s

OBJS  = $(SRCS:.c=.o)
OBJS += $(ASRC:.s=.o)

######################################################################
#                         SETUP TARGETS                              #
######################################################################

.PHONY: all

all: $(PROJ_NAME).elf


%.o : %.c
	@echo "[Compiling  ]  $^"
	@$(CC) -c -o $@ $(INCLUDE) $(DEFS) $(CFLAGS) $^

%.o : %.s
	@echo "[Assembling ]" $^
	@$(AS) $(AFLAGS) $< -o $@


$(PROJ_NAME).elf: $(OBJS)
	@echo "[Linking    ]  $@"
	@$(CC) $(CFLAGS) $(LFLAGS) $^ -o $@ 
	@$(OBJCOPY) -O ihex $(PROJ_NAME).elf   $(PROJ_NAME).hex
	@$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin
	@$(OBJDUMP) -h -S -C $(PROJ_NAME).elf > $(PROJ_NAME).lss

clean:
	rm -f *.o $(PROJ_NAME).elf $(PROJ_NAME).hex $(PROJ_NAME).bin $(PROJ_NAME).lss $(PROJ_NAME).map

flash: all
	openocd -f board/stm32f4discovery.cfg -c "init" -c "reset halt" -c "flash write_image erase $(PROJ_NAME).bin 0x08000000 bin" -c "reset run" -c "exit"
	#st-flash write $(PROJ_NAME).bin 0x8000000

ocd:
	openocd -f board/stm32f4discovery.cfg -c "init"

debug:
	# before you start gdb, you must start st-util
	$(GDB) -tui $(PROJ_NAME).elf -ex 'target remote localhost:3333' -ex 'monitor reset halt' -ex 'load'  -ex 'continue'
	#$(GDB) -tui $(PROJ_NAME).elf -ex 'target remote | openocd -f board/stm32f4discovery.cfg -c "init" -c "gdb_port pipe; log_output openocd.log"' -ex 'monitor reset halt' -ex 'load'  -ex 'continue'

