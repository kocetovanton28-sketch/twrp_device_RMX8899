LOCAL_PATH := $(call my-dir)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Crypto stack blobs taken from the phone (vendor/odm), placed into the recovery ramdisk.
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor,$(TARGET_COPY_OUT_RECOVERY)/root/vendor) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/odm,$(TARGET_COPY_OUT_RECOVERY)/root/odm)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/twrp.flags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/twrp.flags
