#!/bin/bash
mkdir /sys/kernel/config/usb_gadget/pi5

echo 0x1d6b > /sys/kernel/config/usb_gadget/pi5/idVendor
echo 0x0104 > /sys/kernel/config/usb_gadget/pi5/idProduct
echo 0x0100 > /sys/kernel/config/usb_gadget/pi5/bcdDevice
echo 0x0200 > /sys/kernel/config/usb_gadget/pi5/bcdUSB

echo 0xEF > /sys/kernel/config/usb_gadget/pi5/bDeviceClass
echo 0x02 > /sys/kernel/config/usb_gadget/pi5/bDeviceSubClass
echo 0x01 > /sys/kernel/config/usb_gadget/pi5/bDeviceProtocol

mkdir /sys/kernel/config/usb_gadget/pi5/strings/0x409
echo 100000000d2386db > /sys/kernel/config/usb_gadget/pi5/strings/0x409/serialnumber
echo "Samsung" > /sys/kernel/config/usb_gadget/pi5/strings/0x409/manufacturer
echo "pi5 USB Device" > /sys/kernel/config/usb_gadget/pi5/strings/0x409/product
mkdir /sys/kernel/config/usb_gadget/pi5/configs/c.1
mkdir /sys/kernel/config/usb_gadget/pi5/configs/c.1/strings/0x409
echo 500 > /sys/kernel/config/usb_gadget/pi5/configs/c.1/MaxPower
echo "UVC" > /sys/kernel/config/usb_gadget/pi5/configs/c.1/strings/0x409/configuration

mkdir /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0
mkdir -p /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/control/header/h
ln -s /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/control/header/h /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/control/class/fs
mkdir -p /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/dwFrameInterval
5000000
EOF
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/wWidth
1280
EOF
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/wHeight
720
EOF
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/dwMinBitRate
29491200
EOF
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/dwMaxBitRate
29491200
EOF
cat <<EOF > /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/mjpeg/m/720p/dwMaxVideoFrameBufferSize
1843200
EOF
mkdir /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/header/h
cd /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0/streaming/header/h
ln -s ../../mjpeg/m
cd ../../class/fs
ln -s ../../header/h
cd ../../class/hs
ln -s ../../header/h
cd ../../../../..

ln -s /sys/kernel/config/usb_gadget/pi5/functions/uvc.usb0 /sys/kernel/config/usb_gadget/pi5/configs/c.1/uvc.usb0
udevadm settle -t 5 || :
ls /sys/class/udc > /sys/kernel/config/usb_gadget/pi5/UDC