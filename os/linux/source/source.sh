#!/bin/bash
export EDITOR=vim

if [ -n "$WINDOWID" ]; then
    TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 92 / 100)))
    xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
fi

# some more ls aliases
alias t='tmux'
alias e='emacs -mm &'
alias doc='cd /mnt/tao/Documents/'
alias soc='cd /mnt/tao/Documents/C_SOC'
alias cus='cd /mnt/tao/Documents/Y_customers'
alias ingenic='cd /mnt/tao/Documents/Y_customers/A_Ingenic'
alias os='cd /mnt/tao/Documents/Y_customers/A_Ingenic/codes/os'
alias l='cd /mnt/tao/Documents/Y_customers/A_Ingenic/codes/os/linux'
alias a='cd /mnt/tao/Documents/Y_customers/A_Ingenic/codes/os/android'
alias a41='cd /mnt/tao/Documents/Y_customers/A_Ingenic/codes/os/android/android-4.1'

alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" > ~/.emacs.d/eshell/alias

# CCache
#export USE_CCACHE=1
#export CCACHE_DIR=/home/tao/.ccache

# untils
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/bin:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/script:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/tips:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/python:$PATH

# compiler
[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/android-ndk-r8b
[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipsel-linux-android-4.7/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mips-4.3/bin
[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin

# jdk
JAVA_HOME=/mnt/tao/Utils/jdk1.6.0_45
JRE_HOME=${JAVA_HOME}/jre
[[ -z $TMUX ]] && export ANDROID_JAVA_HOME=$JAVA_HOME
[[ -z $TMUX ]] && export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
[[ -z $TMUX ]] && export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
[[ -z $TMUX ]] && export PATH=$JAVA_PATH:$PATH

# a colored prompt
PS1='\[\e[32;1m\][${debian_chroot:+($debian_chroot)}\u(local)]\[\e[0m\]\[\e[33;1m\]\w\[\e[31;1m\]\n\$ \[\e[0m\]'

# 4.1.2 compiler path
function gcc-mips-412() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:'`
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:'`
}

# 4.7.2 mips32 compiler path
function gcc-mips32-472() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin:'`
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin:'`
}

# 4.7.2 mip32r2 compiler path
function gcc-mips32r2-472() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin:'`
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin:'`
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

# add retmux
[[ -z $TMUX ]] && export PATH=$PATH:/home/tao/Documents/B_Linux_App/codes/utils/retmux
