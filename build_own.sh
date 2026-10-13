#!/usr/bin/env bash
# Builds TWRP for RE6402L1 from the OWN device tree in this folder.
# Set USE_COMMUNITY_PATCHES=1 to also apply the TWRP source patches (no device tree) from MissMyTime/twrp_device_sm8850.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
WORKDIR="${WORKDIR:-$HOME/android/twrp}"
mkdir -p "$WORKDIR"; cd "$WORKDIR"
[ -d .repo ] || repo init --depth=1 -u https://github.com/TWRP-Test/platform_manifest_twrp_aosp.git -b twrp-16.0
repo sync -c --no-tags --no-clone-bundle --optimized-fetch -j"$(nproc)"

mkdir -p device/realme/RE6402L1
rsync -a "$HERE/device/realme/RE6402L1/" device/realme/RE6402L1/
# blobs lost exec bits on the way through /sdcard
find device/realme/RE6402L1/proprietary -path '*/bin/*' -type f -exec chmod 755 {} +

if [ "${USE_COMMUNITY_PATCHES:-0}" = "1" ]; then
  [ -d twrp_device_sm8850 ] || git clone https://github.com/MissMyTime/twrp_device_sm8850.git
  twrp_device_sm8850/scripts/apply-patches.sh . neo8
fi

export ALLOW_MISSING_DEPENDENCIES=true
set +u
source build/envsetup.sh
lunch twrp_RE6402L1-bp2a-eng
m -j"$(nproc)" recoveryimage
ls -l out/target/product/RE6402L1/recovery.img
