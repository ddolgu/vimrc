# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export L4T_INSTALL_PATH=~/Jetson-Linux-36.3
export CROSS_COMPILE=$L4T_INSTALL_PATH/aarch64--glibc--stable-2022.08-1/bin/aarch64-buildroot-linux-gnu-
export INSTALL_MOD_PATH=$L4T_INSTALL_PATH/Linux_for_Tegra/rootfs
export KERNEL_HEADERS=$L4T_INSTALL_PATH/Linux_for_Tegra/source/kernel/kernel-jammy-src

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[03;32m\]\u@\h\[\033[01;34m\]:\w\[\033[02;33m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '
source /opt/ros/humble/setup.bash
source /home/asds/ros_ws/install/local_setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
#export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_PACKAGE_PATH=/opt/ros/humble/share
#export ROS_LOCALHOST_ONLY=1
export ROS_DOMAIN_ID=0
#export ROS_DOMAIN_ID=39
export ASDS_DRONE_ID=4
ccbd_pkg() { cd ~/ros_ws && colcon build --cmake-args "-DCMAKE_BUILD_TYPE=Release" --packages-select $1 --allow-overriding $1  && cd - > /dev/null; }
ccbd() { cd ~/ros_ws && colcon build --cmake-args "-DCMAKE_BUILD_TYPE=Release" --packages-select asds_sensor_fusion --allow-overriding asds_sensor_fusion && cd - > /dev/null; }
cbd() { cd ~/ros_ws && colcon build --cmake-args "-DCMAKE_BUILD_TYPE=Release"; }
export SIM_ENV_GZ_MODELS=~/ros_ws/src/simulation_environment/sim/models
export GZ_SIM_RESOURCE_PATH=$GZ_SIM_RESOURCE_PATH:$SIM_ENV_GZ_MODELS
export PX4_AUTOPILOT_PATH=~/Documents/px4/px4_1_14/PX4-Autopilot
px4dds(){ MicroXRCEAgent serial --dev /dev/ttyUSB0 -b 3000000;}
usbltc(){ source ~/Scripts/set_usb_serial_latency.sh;}
cdpx4(){ cd ~/Documents/px4/px4_1_14/PX4-Autopilot ;}
rviz(){ rviz2 -d ~/.rviz2/pose_plot.rviz;}
tm(){ source ~/Scripts/asds_sensor_fusion.sh;}
tmd(){ source ~/Scripts/asds_drone.sh;}
qgc(){ ~/Downloads/QGroundControl.AppImage;}
roscd(){ cd /opt/ros/humble/share;}
ccd(){ cd ~/ros_ws/src/asds_sensor_fusion;}
matlab(){ /usr/local/MATLAB/R2024a/bin/matlab;}

