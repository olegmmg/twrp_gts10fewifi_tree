# TWRP device tree: Samsung Galaxy Tab S10 FE (SM-X520, gts10fewifi, s5e8855)

Prebuilt kernel, dtb and dtbo come from stock firmware X520XXS4AYG5 (Android 15).
Author: olegmmg@4pda/xda. Status: recovery boots, touch works (loaded by a script); system boot with it is untested.

## Build
1. Sync a TWRP minimal manifest: TWRP minimal manifest, Android 14 branch (BUILD_ID AP2A.240905.003).
2. Put this tree at device/samsung/gts10fewifi.
3. Build:

    source build/envsetup.sh
    lunch twrp_gts10fewifi-ap2a-eng
    mka vendorbootimage

## Do NOT flash the built vendor_boot.img directly
It hangs on the logo. Take your own stock vendor_boot.img and replace only the recovery fragment:
1. unpack the stock image with AOSP unpack_bootimg.py --format=mkbootimg and reuse all its parameters;
2. unpack the built out/target/product/gts10fewifi/vendor_boot.img the same way and take its vendor_ramdisk01 (the "recovery" fragment, type 2);
3. repack with mkbootimg.py: stock fragments unchanged, recovery fragment from the build;
4. result must not exceed 117440512 bytes (vendor_boot partition size);
5. tar -H ustar -c vendor_boot.img > twrp.tar, append the md5 of the tar to it, rename to .tar.md5, flash in Odin (AP slot).
Enter recovery with Vol Up + Power right after flashing.

## Notes
- Touch is started by recovery/root/system/bin/load_touch.sh (init.recovery.s5e8855.rc, service runs as u:r:su:s0), it mounts vendor_dlkm of the active slot and loads the himax module.
- The /usb_otg entry in recovery.fstab is disabled: /dev/block/sda1 on this device is EFS.
