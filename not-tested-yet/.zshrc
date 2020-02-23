export ZSH="/home/mamutal91/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git archlinux extract web-search)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export branch="ten"
export los="lineage-17.1"

export TERM="xterm-256color"
export EDITOR="nano"
export LANG="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"
export LANGUAGE="pt_BR.UTF-8"
export LC_CTYPE="pt_BR.UTF-8"

export PATH=~/.bin:$PATH
export PATH=$PATH:~/.android-sdk/tools/
export PATH=$PATH:~/.android-sdk/platform-tools/
export JAVA_HOME=/usr/lib/jvm/java

export USE_CCACHE=1
export CCACHE_DIR="${HOME}/.ccache"
export CCACHE_EXEC="$(which ccache)"
# ccache -M 100G

export KBUILD_BUILD_USER=MaMuT
export KBUILD_BUILD_HOST=MaMuT
export SELINUX_IGNORE_NEVERALLOWS=true
export CUSTOM_BUILD_TYPE=OFFICIAL
export VIPER_BUILD_TYPE=OFFICIAL

# Exports for PE
export TARGET_GAPPS_ARCH=arm64
export TARGET_BOOT_ANIMATION_RES=1080

function site () {
  cd /var/www/krakenproject.club/building
}

function tree () {
  rm -rf device/xiaomi/beryllium
  rm -rf device/xiaomi/sdm845-common
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b $branch device/xiaomi/beryllium
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b $branch device/xiaomi/sdm845-common
}

function tree_pull () {
  pull=$(pwd)
  cd $HOME
  rm -rf device_xiaomi_beryllium device_xiaomi_sdm845-common
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b $branch
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b $branch
  cd device_xiaomi_beryllium
  git pull --rebase https://github.com/AOSiP-Devices/device_xiaomi_beryllium -t ten && git rebase && git push
  cd device_xiaomi_sdm845-common
  git pull --rebase https://github.com/AOSiP-Devices/device_xiaomi_sdm845-common -t ten && git rebase && git push
  cd $pull
}

function tree_kernel () {
  rm -rf kernel/xiaomi
  git clone https://github.com/AOSiP-Devices/kernel_xiaomi_sdm845 -b ten kernel/xiaomi/sdm845
}

function tree_vendor () {
  rm -rf vendor/xiaomi
  git clone https://github.com/AOSiP-Devices/proprietary_vendor_xiaomi -b ten vendor/xiaomi
  tree=$(pwd)
  cd vendor/xiaomi
  rm -rf dipper jasmine_sprout mido msm8953-common platina raphael sdm660-common wayne wayne-common whyred
  cd $tree
}

function up () {
  cp -rf ${1} /var/www/krakenproject.club/building
}

function upsf () {
  scp ${1} mamutal91@frs.sourceforge.net:/home/frs/project/aosp-forking/beryllium
}

function fetch () {
  echo "$los"
  git fetch https://github.com/LineageOS/android_${1} $los
}

function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/${2} --force
  git push ssh://git@github.com/aosp-forking/${1} HEAD:refs/heads/${2} --force
}

function pushv () {
  git push ssh://git@github.com/ViperOS-WIP/android_${1} HEAD:refs/heads/${2} --force
}

function aosp () {
  cd $HOME/aosp
}

function c () {
  git clone ssh://git@github.com/ViperOS-WIP/android_${1} -b $branch
}

function p () {
  git cherry-pick ${1}
}

function scripts () {
  scripts=$(pwd)
  rm -rf $HOME/.zshrc
  rm -rf $HOME/.apt.sh
  cd $HOME
  wget https://raw.githubusercontent.com/mamutal91/scripts/master/.zshrc
  wget https://raw.githubusercontent.com/mamutal91/scripts/master/.apt.sh && chmod +x .apt.sh
  cd $scripts
  source $HOME/.zshrc
  clear
}