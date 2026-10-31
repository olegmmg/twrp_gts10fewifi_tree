DEVICE_PATH := device/samsung/gts10fewifi

# Архитектура (Exynos 1580: Cortex-A720/A520, 64-bit only)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_BOARD_PLATFORM := erd8855
TARGET_BOOTLOADER_BOARD_NAME := s5e8855
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Идентификация устройства, проверка при установке zip
TARGET_OTA_ASSERT_DEVICE := gts10fewifi,gts10fewifixx,SM-X520

# A/B, динамические разделы
AB_OTA_UPDATER := true
BOARD_USES_RECOVERY_AS_BOOT := false

# Ядро: стоковое (GKI 6.6.50, 4k-страницы), без пересборки.
# Положи stock kernel из boot_out/kernel в prebuilt/kernel
TARGET_NO_KERNEL := false
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# boot: header v4; vendor_boot: header v4, page size 0x800
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x00000000
BOARD_TAGS_OFFSET := 0x00000000
BOARD_DTB_OFFSET := 0x01f00000
BOARD_VENDOR_BASE := 0x10000000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board SRPXK12C004
BOARD_RAMDISK_USE_LZ4 := true

# Рекавери лежит в vendor_boot (рамдиск-фрагмент 00), отдельного recovery.img нет
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := false
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x4000000
# TODO: подставить реальный размер vendor_boot
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x7000000

# Динамические разделы
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product system_ext odm vendor_dlkm system_dlkm
# TODO: размеры взять из lpdump super.raw (super_size и group maximum_size)
BOARD_SUPER_PARTITION_SIZE := 18874368000
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 18870173696

# Файловые системы
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor

# Модули из vendor_boot (ramdisk01) и два драйвера тача из vendor_dlkm
TW_LOAD_VENDOR_BOOT_MODULES := true
# TODO: проверить, что эта опция есть в твоей ветке TWRP, иначе грузить через insmod в init.recovery.samsung.rc

# AVB: вмешательство в vbmeta делаем прошивкой, не сборкой
BOARD_AVB_ENABLE := false

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USES_MKE2FS := true
BOARD_HAS_NO_SELECT_BUTTON := true

# Экран: плотность и разрешение уточнить после первой загрузки
TARGET_SCREEN_DENSITY := 280
TW_THEME := landscape_hdpi
TW_BRIGHTNESS_PATH := "/sys/devices/platform/panel_drv_0/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
# TODO: путь к подсветке проверить по ls /sys/class/backlight на планшете

# TWRP
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_USE_TOOLBOX := true
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
RECOVERY_SDCARD_ON_DATA := true
TW_HAS_DOWNLOAD_MODE := true
#TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_CRYPTO_FBE := true
#TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true
# На первом этапе расшифровку /data можно отключить, чтобы не ловить лишние ошибки сборки

BOARD_KERNEL_CMDLINE := panic_on_warn=0 bootconfig loop.max_part=7
BOARD_BOOTCONFIG := androidboot.serialconsole=0
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
TW_SKIP_ADDITIONAL_FSTAB := true
