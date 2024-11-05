#!/bin/bash

# Initialize the ROM manifest for RisingTech on branch 'fifteen' with Git LFS enabled
# repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs
repo init -u https://github.com/RisingOS-staging/android -b fifteen --git-lfs

# Sync the repository with various options for efficient and clean syncing:
# -c: Current branch only
# --no-clone-bundle: Skip clone bundle usage
# --optimized-fetch: Perform optimized fetch for faster syncing
# --prune: Remove obsolete branches
# --force-sync: Ensure a full sync of all repositories
# -j$(nproc --all): Use all available CPU cores
# repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
/opt/crave/resync.sh

# Remove existing directories for a fresh setup (cleans up old device, vendor, and other paths)
rm -rf device/xiaomi/sunny
rm -rf device/qcom/common
rm -rf device/qcom/qssi
rm -rf device/xiaomi/sunny-kernel
rm -rf vendor/xiaomi/sunny
rm -rf vendor/qcom/common
rm -rf vendor/qcom/opensource/core-utils
rm -rf packages/apps/DisplayFeatures
rm -rf packages/apps/KProfiles
rm -rf hardware/xiaomi
rm -rf hardware/qcom-caf/sm8150/media
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-elf
rm -rf prebuilts/gcc/linux-x86/arm/arm-eabi

# Clone the necessary device repositories
git clone https://github.com/sunny-yaap/device_xiaomi_sunny.git --depth 1 -b fifteen device/xiaomi/sunny
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fifteen device/qcom/common
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b vauxite device/qcom/qssi

# Clone kernel repository for the 'sunny' device
git clone https://github.com/yaap/device_xiaomi_sunny-kernel.git --depth 1 -b fifteen device/xiaomi/sunny-kernel

# Clone vendor repositories for Xiaomi and Qualcomm dependencies
git clone https://github.com/yaap/vendor_xiaomi_sunny.git --depth 1 -b fifteen vendor/xiaomi/sunny
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fifteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fifteen vendor/qcom/opensource/core-utils

# Clone package repositories for additional features
git clone https://github.com/yaap/packages_apps_DisplayFeatures.git --depth 1 -b fifteen packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles

# Clone hardware repositories for Xiaomi and Qualcomm's SM8150 platform
git clone https://github.com/yaap/hardware_xiaomi.git --depth 1 -b fifteen hardware/xiaomi
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fifteen hardware/qcom-caf/sm8150/media

# Clone prebuilt GCC toolchains for cross-compiling
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi

# Rising private keys
git clone https://github.com/sunny-keys/lineage-priv-risingos.git --depth 1 -b main vendor/lineage-priv/keys

# Set up the environment for building (loads variables and functions for the build process)
. build/envsetup.sh

# Specify the build target device and user variant
riseup sunny user

# Start the build process
rise b
