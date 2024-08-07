CROSS_COMPILE	?=
ARCH		?= x86
KERNEL_DIR	?= /usr/src/linux

CC		:= $(CROSS_COMPILE)g++
KERNEL_INCLUDE	:= -I$(KERNEL_DIR)/include -I$(KERNEL_DIR)/arch/$(ARCH)/include -I/usr/include/opencv4 -I/usr/include/
CFLAGS		:= -W -Wall -g $(KERNEL_INCLUDE)
LDFLAGS		:= -g -L/usr/lib/x86_64-linux-gnu/ -lopencv_core -lopencv_highgui -lopencv_videoio -lopencv_imgproc -lopencv_objdetect -lopencv_imgcodecs -ljpeg

all: uvc-gadget

uvc-gadget: uvc-gadget.o
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	rm -f *.o
	rm -f uvc-gadget
