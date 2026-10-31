#
# Samsung Galaxy Tab S10 FE (SM-X520, gts10fewifi), Exynos 1580 (s5e8855)
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE       := gts10fewifi
PRODUCT_NAME         := twrp_gts10fewifi
PRODUCT_BRAND        := samsung
PRODUCT_MODEL        := SM-X520
PRODUCT_MANUFACTURER := samsung

PRODUCT_PLATFORM := erd8855

# Динамические разделы, A/B
PRODUCT_USE_DYNAMIC_PARTITIONS := true
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-recovery \
    android.hardware.fastboot@1.1-impl-mock

PRODUCT_SHIPPING_API_LEVEL := 34

# нужен twrp_ramdisk независимо от крипто
PRODUCT_PACKAGES += task_profiles.json
