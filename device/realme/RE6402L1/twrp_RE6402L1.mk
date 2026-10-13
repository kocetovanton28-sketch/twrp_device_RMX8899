$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/realme/RE6402L1/device.mk)

PRODUCT_DEVICE := RE6402L1
PRODUCT_NAME := twrp_RE6402L1
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX8899
PRODUCT_MANUFACTURER := realme
