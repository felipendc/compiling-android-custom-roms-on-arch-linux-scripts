export ZSH="/home/mamutal91/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git archlinux extract web-search)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

export KBUILD_BUILD_USER=mamutal91
export KBUILD_BUILD_HOST=MamutBox
export SELINUX_IGNORE_NEVERALLOWS=true
export CUSTOM_BUILD_TYPE=OFFICIAL

function site () {
  pwd=$(pwd)
  cd /var/www/krakenproject.club
  sudo rm -rf css js favicon.ico index.html
  git clone https://github.com/andersonmendess/kraken -b prod
  cd kraken
  mv * .. && cd ..
  rm -rf kraken
  cd $pwd
}

function up () {
  cp -rf ${1} /var/www/krakenproject.club/building
}

function fetch () {
  echo "lineage-17.1"
  git fetch https://github.com/LineageOS/android_${1} lineage-17.1
}

function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/ten --force
  git push ssh://git@github.com/aosp-forking/${1} HEAD:refs/heads/ten --force
}

function p () {
  git cherry-pick ${1}
}

function scripts () {
  scripts=$(pwd)
  rm -rf $HOME/.zshrc
  rm -rf $HOME/.apt.sh
  cd $HOME && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.zshrc
  cd $HOME && rm -rf .apt.sh && wget https://raw.githubusercontent.com/mamutal91/scripts/master/.apt.sh && chmod +x .apt.sh
  cd $scripts
  source $HOME/.zshrc
  clear
}
