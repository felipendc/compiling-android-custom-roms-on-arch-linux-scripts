#!/bin/bash

# Felipe Ndc "github.com/felipendc" 
# TitaniumOS source code: github.com/TitaniumOS/manifest


###############################################################################################################
################## MAKE SURE TO MAKE THIS FILE EXECUTABLE TO PREVENT ANY PERMISSIONS ERRORS  ##################
###############################################################################################################


export titanium="$HOME/titanium"

function sync () {
    cd $titanium
    
    sudo rm -r device/oneplus/oneplus3*
    git clone https://github.com/felipendc/titanium_device_oneplus_oneplus3 -b lineage-17.1 device/oneplus/oneplus3
    sudo rm -r device/oneplus/oneplus3/.git

    sudo rm -r device/oppo/common*
    git clone https://github.com/felipendc/titanium_device_oppo_common.git -b lineage-17.1 device/oppo/common
    sudo rm -r device/oppo/common/.git

    sudo rm -r vendor/oneplus/oneplus3*
    git clone https://github.com/felipendc/titanium_vendor_xiaomi_oneplus3.git -b lineage-17.1 vendor/oneplus/oneplus3
    sudo rm -r vendor/oneplus/oneplus3/.git

    sudo rm -r packages/apps/GoogleCamera*
    git clone https://github.com/Gaurav241/packages_apps_GoogleCamera_oneplus3.git -b Android-10.0 packages/apps/GoogleCamera
    sudo rm -r packages/apps/GoogleCamera/.git

    sudo rm -r packages/resources/OneplusGestures*
    git clone https://github.com/felipendc/packages_resources_OneplusGestures.git -b pie packages/resources/OneplusGestures
    sudo rm -r packages/resources/OneplusGestures/.git

    sudo rm -r kernel/oneplus/msm8996*
    git clone https://github.com/ajithzres/android_kernel_oneplus_msm8996 -b 10 kernel/oneplus/msm8996
    sudo rm -r kernel/oneplus/msm8996/.git

    repo sync -j$(nproc --all) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune
}

function compile () {
    cd $titanium
    make clobber && make clean && . build/envsetup.sh && lunch titanium_oneplus3-userdebug && make -j$(nproc --all) titanium 2>&1 | tee log.txt
}

sync
compile
