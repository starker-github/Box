#!/bin/bash
export EDITOR=vim

if [ -n "$WINDOWID" ]; then
    TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 92 / 100)))
    xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
fi

# some more ls aliases
alias e='emacs&'
alias i='cd /mnt/tao/Documents/Z_Workspace/Ingenic'
alias a='cd /mnt/tao/Documents/Z_Workspace/Ingenic/codes/android'
alias a41='cd /mnt/tao/Documents/Z_Workspace/Ingenic/codes/android/android-4.1'
alias l='cd /mnt/tao/Documents/Z_Workspace/Ingenic/codes/linux'

alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" > ~/.emacs.d/eshell/alias

# CCache
#export USE_CCACHE=1
#export CCACHE_DIR=/home/tao/.ccache

# untils
export PATH=/mnt/tao/Box/utils/bin:$PATH
export PATH=/mnt/tao/Box/utils/script:$PATH
export PATH=/mnt/tao/Box/utils/tips:$PATH
export PATH=/mnt/tao/Box/utils/python:$PATH

# compiler
export PATH=$PATH:/mnt/tao/Utils/compiler/android-ndk-r8b
export PATH=$PATH:/mnt/tao/Utils/compiler/mipsel-linux-android-4.7/bin
#export PATH=$PATH:/mnt/tao/Utils/compiler/mips-4.3/bin
export PATH=$PATH:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin
export PATH=$PATH:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin

# jdk
JAVA_HOME=/mnt/tao/Utils/jdk1.6.0_45
JRE_HOME=${JAVA_HOME}/jre
export ANDROID_JAVA_HOME=$JAVA_HOME
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
export PATH=$JAVA_PATH:$PATH

# a colored prompt
PS1='\[\e[32;1m\][${debian_chroot:+($debian_chroot)}\u(local)]\[\e[0m\]\[\e[33;1m\]\w\[\e[31;1m\]\n\$ \[\e[0m\]'

# 4.1.2 compiler path
function 412gcc() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips-uclibc-toolchains/bin:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:'`
}

# 4.7.2 compiler path
function 472gcc() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:/mnt/tao/Utils/compiler/mips-uclibc-toolchains/bin:'`
}

# grep
function cgrep() {
	find -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.h' \) -print0 | xargs -0 grep --color -n "$@"
}
function kgrep() {
	find -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.h' -o -name 'Kconfig' -o -name 'Makefile' \) -print0 | xargs -0 grep --color -n "$@"
}

# source (git clone https://github.com/rupa/z.git)
source /mnt/tao/Utils/z.git/z.sh
