#!/usr/bin/env bash
#!/usr/bin/env expect
# Description: this is 23R3F's personal linux kits(ubuntu)
# URL: https://

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
PLAIN='\033[0m'
red_echo()
{
    echo -e '\033[0;31m'${1}'\033[0m'
}
green_echo()
{
    echo -e '\033[0;32m'${1}'\033[0m'
}
yellow_echo()
{
    echo -e '\033[0;33m'${1}'\033[0m'
}
blue_echo()
{
    echo -e '\033[0;36m'${1}'\033[0m'
}
next()
{
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}
get_opsy()
{
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}
calc_disk()
{
    local total_size=0
    local array=$@
    for size in ${array[@]}
    do
        [ "${size}" == "0" ] && size_t=0 || size_t=`echo ${size:0:${#size}-1}`
        [ "`echo ${size:(-1)}`" == "K" ] && size=0
        [ "`echo ${size:(-1)}`" == "M" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' / 1024}' )
        [ "`echo ${size:(-1)}`" == "T" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' * 1024}' )
        [ "`echo ${size:(-1)}`" == "G" ] && size=${size_t}
        total_size=$( awk 'BEGIN{printf "%.1f", '$total_size' + '$size'}' )
    done
    echo ${total_size}
}
system_msg()
{
    blue_echo "This Is Your System Message:"
    cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
    freq=$( awk -F'[ :]' '/cpu MHz/ {print $4;exit}' /proc/cpuinfo )
    tram=$( free -m | awk '/Mem/ {print $2}' )
    uram=$( free -m | awk '/Mem/ {print $3}' )
    swap=$( free -m | awk '/Swap/ {print $2}' )
    uswap=$( free -m | awk '/Swap/ {print $3}' )
    up=$( awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60} {printf("%d days, %d hour %d min\n",a,b,c)}' /proc/uptime )
    load=$( w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//' )
    opsy=$( get_opsy )
    arch=$( uname -m )
    lbit=$( getconf LONG_BIT )
    kern=$( uname -r )
    #ipv6=$( wget -qO- -t1 -T2 ipv6.icanhazip.com )
    disk_size1=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem|udev|docker' | awk '{print $2}' ))
    disk_size2=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem|udev|docker' | awk '{print $3}' ))
    disk_total_size=$( calc_disk "${disk_size1[@]}" )
    disk_used_size=$( calc_disk "${disk_size2[@]}" )

    #clear
    next
    echo -e "CPU model            : ${BLUE}${cname}${PLAIN}"
    echo -e "Number of cores      : ${BLUE}$cores${PLAIN}"
    echo -e "CPU frequency        : ${BLUE}$freq MHz${PLAIN}"
    echo -e "Total size of Disk   : ${BLUE}$disk_total_size GB ($disk_used_size GB Used)${PLAIN}"
    echo -e "Total amount of Mem  : ${BLUE}$tram MB ($uram MB Used)${PLAIN}"
    echo -e "Total amount of Swap : ${BLUE}$swap MB ($uswap MB Used)${PLAIN}"
    echo -e "System uptime        : ${BLUE}$up${PLAIN}"
    echo -e "Load average         : ${BLUE}$load${PLAIN}"
    echo -e "OS                   : ${BLUE}$opsy${PLAIN}"
    echo -e "Arch                 : ${BLUE}$arch ($lbit Bit)${PLAIN}"
    echo -e "Kernel               : ${BLUE}$kern${PLAIN}"
    next
    echo ""
}

welcome()
{
<<<<<<< HEAD
    # if [ `whoami` != "root" ];then
    #     echo "you should run with 'sudo ./linux_kits.sh'"
    #     exit
    # fi
=======
    if [ `whoami` != "root" ];then
        echo "you should run with 'sudo ./linux_kits.sh'"
        exit
    fi
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
    red_echo "Welcome To Use 23R3F 's Linux Kits\n"
}

add_user()
{
    red_echo "input the username:"
    read username
    if [[ $username ]] && [[ $username =~ ^[a-zA-Z][a-zA-Z0-9_]+{3,16}  ]];
    then
        sudo adduser $username
        sudo usermod -aG sudo $username
        green_echo "has create '$username' user"
        sudo chown $username:$username /home/$username/*
        # ls /home/$1 -al

    else
        red_echo "username invaild!\n"
    fi
    
}

recovery_apt()
{
    if [[ ! -e "/etc/apt/sources.list_backup" ]]; then
        red_echo "/etc/apt/sources.list_backup is not exist!"
        return -1
    fi
    green_echo "do you want to recovery apt source?(y/n) [n]"

    read restr
    if [[ $restr == "y" ]] || [[ $restr == "Y" ]];then
<<<<<<< HEAD
        sudo rm -f /etc/apt/sources.list
        sudo mv /etc/apt/sources.list_backup /etc/apt/sources.list
=======
        rm /etc/apt/sources.list
        mv /etc/apt/sources.list_backup /etc/apt/sources.list
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
        green_echo "has recovery the backup"
    fi
    echo ""

}
change_apt()
{
    blue_echo "using the apt source of tsinghua"
    key="mirrors.tuna.tsinghua.edu.cn"
    filename='/etc/apt/sources.list'
    apt_str="# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
            \ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
            \n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
            \ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
            \n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
            \ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
            \n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
            \ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
            \n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
            \n# 预发布软件源，不建议启用
            \n# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
            \n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse"
    # echo -e $result
    result=`cat '/etc/apt/sources.list' `
    if [[ $result == *$key* ]];
        then
            red_echo "already has tsinghua mirrors source!"
        else
<<<<<<< HEAD
            sudo mv /etc/apt/sources.list /etc/apt/sources.list_backup
            sudo touch /etc/apt/sources.list
            sudo echo  -e ${apt_str} > ${filename}
=======
            mv /etc/apt/sources.list /etc/apt/sources.list_backup
            touch /etc/apt/sources.list
            echo  -e ${apt_str} > ${filename}
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
            apt-get update
            green_echo "has backup and has change apt source"     
    fi
    recovery_apt
}
recovery_pip()
{
    if [[ ! -e "$HOME/.pip/pip.conf" ]]; then
        red_echo "$HOME/.pip/pip.conf is not exist!"
        return -1
    fi
    green_echo "do you want to recovery pip source?(y/n) [n]"
    read restr
    if [[ $restr == "y" ]] || [[ $restr == "Y" ]];then
<<<<<<< HEAD
        sudo rm -rf $HOME/.pip/
=======
        rm -R $HOME/.pip/
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
        pip install update
        green_echo "has recovery the backup"
    fi
    echo ""
}
change_pip()
{
<<<<<<< HEAD

    blue_echo "using the pip source of tsinghua(only change for current user)"
    if [[ -e "$HOME/.pip/pip.conf" ]]; then
        sudo rm -rf $HOME/.pip/
=======
    blue_echo "using the pip source of tsinghua(only change for current user)"
    if [[ -e "$HOME/.pip/pip.conf" ]]; then
        rm -R $HOME/.pip/
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
    fi

    mkdir $HOME/.pip
    touch $HOME/.pip/pip.conf
    filename="$HOME/.pip/pip.conf"
    pip_str="[global]
        \nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple/
        \n[install]
        \ntrusted-host=pypi.tuna.tsinghua.edu.cn"
    echo -e ${pip_str} > ${filename}
    pip install update
    green_echo "has backup and has change pip source"
    recovery_pip
}

restart_net()
{
<<<<<<< HEAD
    sudo service NetworkManager stop
    sudo rm /var/lib/NetworkManager/NetworkManager.state
    sudo service NetworkManager start
    sleep 3
=======
    service NetworkManager stop
    rm /var/lib/NetworkManager/NetworkManager.state
    service NetworkManager start
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
    blue_echo "testing ping www.baidu.com...."
    ping www.baidu.com -c5
    echo ""
}

install_sth()
{
    echo "a"
}
configure_git()
{
    if [[ ! -e "/usr/bin/git" ]];then
        red_echo "you don't install git, begin installing..."
        apt-get install git
    fi
<<<<<<< HEAD

    # if [[ ! -e "/usr/bin/expect" ]];then
    #     red_echo "you don't install expect, begin installing..."
    #     apt-get install expect
    # fi
    blue_echo "this is fast configure git to synchronize local files with github Files"
    red_echo "input your email:"
    read email
    red_echo "input your github username:\n(eg:https://github.com/xxx,just input xxx)"
    read username
=======
    if [[ ! -e "/usr/bin/expect" ]];then
        red_echo "you don't install expect, begin installing..."
        apt-get install expect
    fi
    blue_echo "this is fast configure git to synchronize local files with github Files"
    red_echo "input your email:"
    read email
    # red_echo "input your github username:\n(eg:https://github.com/xxx,just input xxx)"
    # read username
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
    # red_echo "input the dir path you want to synchronize:(absolute path)"
    # read path
    # red_echo "input yout GitHub respository want to synchronize:"
    # read respository
<<<<<<< HEAD
    # if [[ -e "$HOME/.ssh/id_rsa" ]]; then
    #     rm "$HOME/.ssh/id_rsa"
    #     # mkdir "$HOME/.ssh/"
    # fi

    key_path="$HOME/.ssh/id_rsa"
    green_echo "just [enter] to use defate value:"
    ssh-keygen -t rsa -C $email #echo -e "$HOME/.ssh/id_rsa\n\n\n" | 
    # ./configure_pubkey.sh $email $key_path #$username $path $respository $key_path
    red_echo "copy pub-key to your github:"
    next
    cat "$HOME/.ssh/id_rsa.pub"
    next
    red_echo "if your has copy pub-key to your github ,enter to next step:"
    read pause

    ssh-add -D
    ssh-add
    ssh -T git@github.com
    git config --global user.name $username
    git config --global user.email $email
    blue_echo "if your see sth like:'Hi xxxx! You've successfully authenticated',that's successfully!"
    blue_echo "if not...maybe some error occur,you should configure git for yourself...\n"

=======
    if [[ -e "$HOME/.ssh/id_rsa" ]]; then
        rm "$HOME/.ssh/id_rsa"
        # mkdir "$HOME/.ssh/"
    fi

    key_path="$HOME/.ssh/id_rsa"
    
    ./configure_pubkey.sh $email $key_path #$username $path $respository $key_path
    blue_echo "copy pub-key to your github:"
    next
    cat "$HOME/.ssh/id_rsa.pub"
    next
    blue_echo "if your has copy pub-key to your github ,enter to next step:"
    read pause
    result=`ssh -T git@github.com`
    echo -e $result
    read pause
    if [[ $result=="*Permission denied*" ]]; 
        then
            red_echo "error!check your pub-key is copy to GitHub!\n"
            return
        else
            git config --global user.name $username
            git config --global user.email $email
    fi
            # git config --global user.name $username
            # git config --global user.email $email
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf


}

menu()
{
    blue_echo "[*]menu:"
    blue_echo "[1]show system message"
    blue_echo "[2]add a user"
    blue_echo "[3]change apt source"
    blue_echo "[4]change pip source"
    blue_echo "[5]restart network"
    blue_echo "[6]install sth"
    blue_echo "[7]configure for git"
    blue_echo "(input 'exit' to exit)"
}

choice()
{
    while :
    do
        menu
        red_echo "input your num:"
        read num
        case $num in
            1)  system_msg
            ;;
            2)  add_user
            ;;
            3)  change_apt
            ;;
            4)  change_pip
            ;;
            5)  restart_net
            ;;
            6)  install_sth
            ;;
            7)  configure_git
            ;;
            'exit')  
                red_echo "bye bye~"
                exit
            ;;
            *)  red_echo 'error input!'
            ;;
        esac
    done
    

}

welcome
choice

