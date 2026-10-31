#!/system/bin/sh
setenforce 0
S=$(getprop ro.boot.slot_suffix)
[ -z "$S" ] && S=_a
i=0
while [ ! -e /dev/block/mapper/vendor_dlkm$S ] && [ $i -lt 30 ]; do
  sleep 1
  i=$((i+1))
done
mkdir -p /mnt/vd
mount -t erofs -o ro /dev/block/mapper/vendor_dlkm$S /mnt/vd
M=$(find /mnt/vd -name himax_ts_83xxx_spi.ko 2>/dev/null | head -n 1)
[ -z "$M" ] && M=/mnt/vd/lib/modules/himax_ts_83xxx_spi.ko
insmod "$M"
sleep 1
setprop sys.usb.config none
sleep 1
setprop sys.usb.config adb
