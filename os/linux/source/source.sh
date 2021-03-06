#!/bin/bash
export EDITOR=vim
export LANG=zh_CN.UTF-8

if [ -n "$WINDOWID" ]; then
    TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 95 / 100)))
    xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
fi

# some more ls aliases
alias t='tmux'
alias e='XMODIFIERS="@im=fcitx" QT_IM_MODULE="fcitx" emacs -mm &'
alias doc='cd /mnt/tao/Documents/'
alias soc='cd /mnt/tao/Documents/E_SOC'
alias cus='cd /mnt/tao/Documents/Y_customers'
alias ingenic='cd /mnt/tao/Documents/Y_customers/A_Ingenic'
alias avs='cd /mnt/tao/Documents/A_AVS'
alias cgrep='find . -name .repo -prune -o -name .git -prune -o -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.cc" -o -name "Kconfig" -o -name "Makefile" \) -print0 | xargs -0 grep --color -n'
alias myclip='xclip -sel clip'
alias matlab2018a='/usr/local/matlab/matlab2018a/bin/matlab -desktop &'
alias format-google='clang-format -style="{BasedOnStyle: Google, ColumnLimit: 120, AllowShortFunctionsOnASingleLine: Empty, AllowShortIfStatementsOnASingleLine: false, AllowShortIfStatementsOnASingleLine: false, AllowShortLoopsOnASingleLine: false, DerivePointerAlignment: false, PointerAlignment: Right}" -i'

alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" > ~/.emacs.d/eshell/alias

# CCache
#export USE_CCACHE=1
#export CCACHE_DIR=/home/tao/.ccache

# untils
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/bin/cmd_markdown_linux64:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/bin:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/script:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/tips:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Box/utils/python:$PATH

# compiler
[[ -z $TMUX ]] && export PATH=/mnt/tao/Utils/compiler/mips-gcc520-glibc222/bin:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Documents/C_Linux_App/codes/out/gdb-8.0/bin:$PATH
[[ -z $TMUX ]] && export PATH=/mnt/tao/Utils/compiler/mipsel-linux-android-4.7/bin:$PATH
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/android-ndk-r8b
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipsel-linux-android-4.7/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mips-4.3/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipsel-gcc472-glibc216-mips32/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin
#[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Utils/compiler/mipseltools-gcc412-glibc261/bin

# jdk
#JAVA_HOME=/mnt/tao/Utils/jdk1.6.0_45
#JRE_HOME=${JAVA_HOME}/jre
#[[ -z $TMUX ]] && export ANDROID_JAVA_HOME=$JAVA_HOME
#[[ -z $TMUX ]] && export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
#[[ -z $TMUX ]] && export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
#[[ -z $TMUX ]] && export PATH=$JAVA_PATH:$PATH

# a colored prompt
PS1='\[\e[32;1m\][${debian_chroot:+($debian_chroot)}\u(local)]\[\e[0m\]\[\e[33;1m\]\w\[\e[31;1m\]\n\$ \[\e[0m\]'

# 4.7.2 mips32 compiler path
function gcc-472() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips\w*-gcc[^:]*/bin:/mnt/tao/Utils/compiler/mips-gcc472-glibc216/bin:'`
}

# 5.2.0 mips32 compiler path
function gcc-520() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips\w*-gcc[^:]*/bin:/mnt/tao/Utils/compiler/mips-gcc520-glibc222/bin:'`
}

function gcc-520-ln() {
        export PATH=`echo $PATH | sed -e 's:/mnt/tao/Utils/compiler/mips\w*-gcc[^:]*/bin:/mnt/tao/Utils/compiler/mips-gcc520-glibc222-ln/bin:'`
}

# source (git clone https://github.com/rupa/z.git)
source /mnt/tao/Utils/z.git/z.sh

# add retmux
[[ -z $TMUX ]] && export PATH=$PATH:/mnt/tao/Documents/C_Linux_App/codes/utils/retmux

[[ -z $TMUX ]] && PATH=$PATH:/mnt/tao/Downloads/os/linux/packages/apache-maven-3.3.9/bin/

# https://wiki.archlinux.de/title/GNOME#Tipps_und_Tricks
export NO_AT_BRIDGE=1

export TERM=xterm-256color

complete -W "enx00e04c6aae18 wlo1" wifigateway.sh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

function 50_net
{
	mkdir -p ~/smb/50_public
	mkdir -p ~/smb/50_tech
	sudo mount.cifs //192.168.1.50/public ~/smb/50_public -o password="",uid=1000,gid=100,iocharset=utf8,vers=1.0
	sudo mount.cifs //192.168.1.50/tech ~/smb/50_tech -o password="",uid=1000,gid=100,iocharset=utf8,vers=1.0
}

function recover_dns
{
	sudo rm /etc/resolv.conf
	sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
}
