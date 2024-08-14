RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
PURPLE=$(printf '\033[35m')
CYAN=$(printf '\033[36m')
RESET=$(printf '\033[m')
BOLD=$(printf '\033[1m')
TMOE_TMP_DIR=/usr/local/etc/tmoe-linux/tmp
if [ -s /usr/local/etc/tmoe-linux/container.txt ]; then
    #.dockerenv
    export WEEKLY_BUILD_CONTAINER=true
fi
TMOE_LOCALE_FILE=/usr/local/etc/tmoe-linux/locale.txt
if [[ ! $(command -v pkg) ]]; then
    for i in apt dnf zypper; do
        if [[ $(command -v ${i}) ]]; then
            ln -s $(command -v ${i}) /usr/bin/pkg
            break
        fi
    done
fi
if [ -s /tmp/getprop ]; then
    chmod -v a+rx /tmp/getprop
    mkdir -pv /usr/local/bin
    mv -fv /tmp/getprop /usr/local/bin
fi
if [ $(command -v chpasswd) ]; then
    printf "%s\n" "root:root" | chpasswd
fi
cd ${HOME}
NEOFETCH_BIN_FILE="/usr/local/bin/neofetch"
if [ -x /usr/bin/neofetch ]; then
    rm -f ${NEOFETCH_BIN_FILE}
    if [[ $(command -v lolcat) ]]; then
        printf "%s\n" "${GREEN}neofetch | lolcat${RESET}"
        /usr/bin/neofetch | lolcat
    else
        printf "%s\n" "${GREEN}neofetch${RESET}"
        /usr/bin/neofetch
    fi
fi
if [[ -e ${NEOFETCH_BIN_FILE} ]]; then
    chmod a+rx ${NEOFETCH_BIN_FILE}
    if [[ -e /usr/bin/bash || -e /bin/bash ]]; then
        printf "%s\n" "${GREEN}neofetch${RESET}"
        ${NEOFETCH_BIN_FILE}
    fi
fi
###############
unset TMOE_GITHUB
###tmoe-github TMOE_GITHUB=true
if ! grep -q "localhost" /etc/hosts 2>/dev/null; then
    cat >>/etc/hosts <<-EOF
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
fi
if [[ -s "/tmp/hostname" ]]; then
    NEW_HOST_NAME=$(head -n 1 /tmp/hostname)
    cp -f /tmp/hostname /etc
    #[[ ! $(command -v hostname) ]] || hostname ${NEW_HOST_NAME} 2>/dev/null
    #sed -i "1s@LXC_NAME@${NEW_HOST_NAME}@" /etc/hosts 2>/dev/null
    if ! grep -q "${NEW_HOST_NAME}" /etc/hosts 2>/dev/null; then
        printf "%s\n" \
"127.0.0.1 ${NEW_HOST_NAME}" \
"::1 ${NEW_HOST_NAME}" \
>>/etc/hosts
    fi
fi
if [[ $(command -v hostname) ]]; then
    if ! grep -q "$(hostname)" /etc/hosts 2>/dev/null; then
        printf "%s\n" \
"127.0.0.1 $(hostname) $(hostname -f)" \
"::1 $(hostname) $(hostname -f)" \
>>/etc/hosts
    fi
fi
[[ ! -e /etc/hostname ]] || cat /etc/hostname
[[ ! -e /etc/hosts ]] || cat /etc/hosts
if [[ "${TMOE_CHROOT}" = 'true' && $(command -v groupadd) && -e /tmp/.ANDROID_VERSION.txt ]]; then
    printf "%s\n" "Adding groups ..."
    printf "%s\n" "This might take a while."
    groupadd aid_system -g 1000 || groupadd aid_system -g 1074
    groupadd aid_radio -g 1001
    groupadd aid_bluetooth -g 1002
    groupadd aid_graphics -g 1003
    groupadd aid_input -g 1004
    groupadd aid_audio -g 1005
    groupadd aid_camera -g 1006
    groupadd aid_log -g 1007
    groupadd aid_compass -g 1008
    groupadd aid_mount -g 1009
    groupadd aid_wifi -g 1010
    groupadd aid_adb -g 1011
    groupadd aid_install -g 1012
    groupadd aid_media -g 1013
    groupadd aid_dhcp -g 1014
    groupadd aid_sdcard_rw -g 1015
    groupadd aid_vpn -g 1016
    groupadd aid_keystore -g 1017
    groupadd aid_usb -g 1018
    groupadd aid_drm -g 1019
    groupadd aid_mdnsr -g 1020
    groupadd aid_gps -g 1021
    groupadd aid_media_rw -g 1023
    groupadd aid_mtp -g 1024
    groupadd aid_drmrpc -g 1026
    groupadd aid_nfc -g 1027
    groupadd aid_sdcard_r -g 1028
    groupadd aid_clat -g 1029
    groupadd aid_loop_radio -g 1030
    groupadd aid_media_drm -g 1031
    groupadd aid_package_info -g 1032
    groupadd aid_sdcard_pics -g 1033
    groupadd aid_sdcard_av -g 1034
    groupadd aid_sdcard_all -g 1035
    groupadd aid_logd -g 1036
    groupadd aid_shared_relro -g 1037
    groupadd aid_dbus -g 1038
    groupadd aid_tlsdate -g 1039
    groupadd aid_media_ex -g 1040
    groupadd aid_audioserver -g 1041
    groupadd aid_metrics_coll -g 1042
    groupadd aid_metricsd -g 1043
    groupadd aid_webserv -g 1044
    groupadd aid_debuggerd -g 1045
    groupadd aid_media_codec -g 1046
    groupadd aid_cameraserver -g 1047
    groupadd aid_firewall -g 1048
    groupadd aid_trunks -g 1049
    groupadd aid_nvram -g 1050
    groupadd aid_dns -g 1051
    groupadd aid_dns_tether -g 1052
    groupadd aid_webview_zygote -g 1053
    groupadd aid_vehicle_network -g 1054
    groupadd aid_media_audio -g 1055
    groupadd aid_media_video -g 1056
    groupadd aid_media_image -g 1057
    groupadd aid_tombstoned -g 1058
    groupadd aid_media_obb -g 1059
    groupadd aid_ese -g 1060
    groupadd aid_ota_update -g 1061
    groupadd aid_automotive_evs -g 1062
    groupadd aid_lowpan -g 1063
    groupadd aid_hsm -g 1064
    groupadd aid_reserved_disk -g 1065
    groupadd aid_statsd -g 1066
    groupadd aid_incidentd -g 1067
    groupadd aid_secure_element -g 1068
    groupadd aid_lmkd -g 1069
    groupadd aid_llkd -g 1070
    groupadd aid_iorapd -g 1071
    groupadd aid_gpu_service -g 1072
    groupadd aid_network_stack -g 1073
    groupadd aid_shell -g 2000
    groupadd aid_cache -g 2001
    groupadd aid_diag -g 2002
    groupadd aid_oem_reserved_start -g 2900
    groupadd aid_oem_reserved_end -g 2999
    groupadd aid_net_bt_admin -g 3001
    groupadd aid_net_bt -g 3002
    groupadd aid_inet -g 3003
    groupadd aid_net_raw -g 3004
    groupadd aid_net_admin -g 3005
    groupadd aid_net_bw_stats -g 3006
    groupadd aid_net_bw_acct -g 3007
    groupadd aid_readproc -g 3009
    groupadd aid_wakelock -g 3010
    groupadd aid_uhid -g 3011
    groupadd aid_everybody -g 9997
    groupadd aid_misc -g 9998
    groupadd aid_nobody -g 9999
    groupadd aid_app_start -g 10000
    groupadd aid_app_end -g 19999
    groupadd aid_cache_gid_start -g 20000
    groupadd aid_cache_gid_end -g 29999
    groupadd aid_ext_gid_start -g 30000
    groupadd aid_ext_gid_end -g 39999
    groupadd aid_ext_cache_gid_start -g 40000
    groupadd aid_ext_cache_gid_end -g 49999
    groupadd aid_shared_gid_start -g 50000
    groupadd aid_shared_gid_end -g 59999
    #groupadd aid_overflowuid -g 65534 2>/dev/null || groupadd aid_overflowuid -g 65535
    #添加65534 group将导致opensuse的system-user-nobody配置失败。
    groupadd aid_isolated_start -g 99000
    groupadd aid_isolated_end -g 99999
    groupadd aid_user_offset -g 100000
    #usermod -a -G aid_bt,aid_bt_net,aid_inet,aid_net_raw,aid_admin root
    usermod -a -G aid_system,aid_radio,aid_bluetooth,aid_graphics,aid_input,aid_audio,aid_camera,aid_log,aid_compass,aid_mount,aid_wifi,aid_adb,aid_install,aid_media,aid_dhcp,aid_sdcard_rw,aid_vpn,aid_keystore,aid_usb,aid_drm,aid_mdnsr,aid_gps,aid_media_rw,aid_mtp,aid_drmrpc,aid_nfc,aid_sdcard_r,aid_clat,aid_loop_radio,aid_media_drm,aid_package_info,aid_sdcard_pics,aid_sdcard_av,aid_sdcard_all,aid_logd,aid_shared_relro,aid_dbus,aid_tlsdate,aid_media_ex,aid_audioserver,aid_metrics_coll,aid_metricsd,aid_webserv,aid_debuggerd,aid_media_codec,aid_cameraserver,aid_firewall,aid_trunks,aid_nvram,aid_dns,aid_dns_tether,aid_webview_zygote,aid_vehicle_network,aid_media_audio,aid_media_video,aid_media_image,aid_tombstoned,aid_media_obb,aid_ese,aid_ota_update,aid_automotive_evs,aid_lowpan,aid_hsm,aid_reserved_disk,aid_statsd,aid_incidentd,aid_secure_element,aid_lmkd,aid_llkd,aid_iorapd,aid_gpu_service,aid_network_stack,aid_shell,aid_cache,aid_diag,aid_oem_reserved_start,aid_oem_reserved_end,aid_net_bt_admin,aid_net_bt,aid_inet,aid_net_raw,aid_net_admin,aid_net_bw_stats,aid_net_bw_acct,aid_readproc,aid_wakelock,aid_uhid,aid_everybody,aid_misc,aid_nobody,aid_app_start,aid_app_end,aid_cache_gid_start,aid_cache_gid_end,aid_ext_gid_start,aid_ext_gid_end,aid_ext_cache_gid_start,aid_ext_cache_gid_end,aid_shared_gid_start,aid_shared_gid_end,aid_isolated_start,aid_isolated_end,aid_user_offset root
    usermod -g aid_inet _apt 2>/dev/null
    usermod -a -G aid_inet,aid_net_raw portage 2>/dev/null
    printf "%s" "" #空行
fi
debian_sources_list() {
    sed -i 's/^deb/##&/g' /etc/apt/sources.list
    #stable-backports会出错，需改为buster-backports
    cat >>/etc/apt/sources.list <<-'EndOfFile'
#deb http://mirrors.bfsu.edu.cn/debian/ stable main contrib non-free
#deb http://mirrors.bfsu.edu.cn/debian/ stable-updates main contrib non-free
#deb http://mirrors.bfsu.edu.cn/debian/ buster-backports main contrib non-free
#deb http://mirrors.bfsu.edu.cn/debian-security/ stable/updates main contrib non-free
deb http://mirrors.bfsu.edu.cn/debian/ sid main contrib non-free
EndOfFile
    #请注意：若服务器添加了debian sid之外的自动构建任务，需要在此处修改软件源。
    if [[ ${WEEKLY_BUILD_CONTAINER} = true ]]; then
        if grep -q 'unstable main' /etc/apt/sources.list; then
            sed -i "s@unstable@sid@g" /etc/apt/sources.list
        elif ! grep -Eq 'sid|Sid' /etc/issue; then
            sed -i "s@unstable@sid@g" /etc/apt/sources.list
            SOURCELISTCODE=$(grep VERSION_CODENAME /etc/os-release | cut -d '=' -f 2 | head -n 1)
            VERSION_ID=$(grep VERSION_ID /etc/os-release | awk -F '=' '{print $2}' | head -n 1 | cut -d '"' -f 2)
            BACKPORTCODE=$(grep PRETTY_NAME /etc/os-release | head -n 1 | cut -d '=' -f 2 | cut -d '"' -f 2 | awk -F ' ' '$0=$NF' | cut -d '/' -f 1 | cut -d '(' -f 2 | cut -d ')' -f 1)
            if ((VERSION_ID >= 11)); then
                sed -i "s@stable/updates@${SOURCELISTCODE}-security@g" /etc/apt/sources.list
            fi
            sed -E -e "s@#(deb.*mirrors.)@\1@g" \
                -e 's@^.*debian/ sid@#&@g' \
                -e "s@buster(-backports)@${BACKPORTCODE}\1@g" \
                -e "s@stable@${SOURCELISTCODE}@g" \
                -i /etc/apt/sources.list
        fi
    fi
}
##############################
kali_sources_list() {
    #printf "%s\n" "检测到您使用的是Kali系统"
    sed -i 's/^deb/##&/g' /etc/apt/sources.list
    cat >>/etc/apt/sources.list <<-"EndOfSourcesList"
#​Kali has various different branches to choose from (please take the time to read which one would be the best option for your setup), and you may be able to switch or include additional repositories.​kali-rolling (Default & frequently updated)​.
#deb http://http.kali.org/kali kali-rolling main non-free contrib
#​kali-last-snapshot (Point release so more “stable” & the “safest”)​
#deb http://http.kali.org/kali kali-last-snapshot main non-free contrib
#deb http://mirrors.huaweicloud.com/kali/ kali-last-snapshot main contrib non-free
#kali-experimental (Packages which are under testing - often used with the rolling repository)​
#deb http://http.kali.org/kali kali-experimental main non-free contrib
deb http://mirrors.ustc.edu.cn/kali/ kali-rolling main non-free contrib
#deb http://mirrors.neusoft.edu.cn/kali/ kali-rolling main non-free contrib
#deb http://mirrors.huaweicloud.com/debian/ stable main contrib non-free
EndOfSourcesList
    #注意：kali-rolling添加debian testing源后，可能会破坏系统依赖关系，可以添加stable源（暂未发现严重影响）
}
######################
ubuntu_sources_list() {
    #默认为ports源，armbian无需使用sed进行替换。
    sed -i 's/^deb/##&/g' /etc/apt/sources.list
    cat >>/etc/apt/sources.list <<-'EndOfFile'
# deb http://mirrors.huaweicloud.com/ubuntu-ports/ focal-proposed main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-updates main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-backports main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse
EndOfFile
    touch ~/.hushlogin
    touch /home/ubuntu/.hushlogin 2>/dev/null
    if grep -q 'Bionic Beaver' "/etc/os-release"; then
        sed -i 's/focal/bionic/g' /etc/apt/sources.list
    fi
    case $(uname -m) in
    i*86 | x86_64 | amd64) sed -i 's@ubuntu-ports/@ubuntu/@g' /etc/apt/sources.list ;;
    esac
VERSION_CODENAME=$(grep 'VERSION_CODENAME' /etc/os-release | awk -F'=' '{print $2}')
        [[ -z ${VERSION_CODENAME} ]] || sed -i "s@focal@${VERSION_CODENAME}@g" /etc/apt/sources.list
    }
#########################
modify_mint_source_list() {
    sed -i 's@^@#&@g' ${SOURCE_LIST}.bak 2>/dev/null
    sed -i "s@packages.linuxmint.com@${CHINA_MIRROR}/linuxmint@g" ${SOURCE_LIST} 2>/dev/null
    sed -i "s@archive.ubuntu.com@${CHINA_MIRROR}@g" ${SOURCE_LIST} 2>/dev/null
    sed -n p ${SOURCE_LIST}.bak >>${SOURCE_LIST} 2>/dev/null
}
mint_sources_list() {
    printf "%s\n" "检测到您使用的是Linux Mint"
    CHINA_MIRROR='mirrors.huaweicloud.com'
    SOURCE_LIST=/etc/apt/sources.list
    SOURCE_LIST_02="${SOURCE_LIST}.d/official-package-repositories.list"
    SOURCE_LIST_03="${SOURCE_LIST}.d/official-source-repositories.list"
    cp -fv ${SOURCE_LIST} ${SOURCE_LIST}.bak 2>/dev/null
    if [[ ${TMOE_GITHUB} != true ]]; then
        modify_mint_source_list
    fi
    cp -fv ${SOURCE_LIST_02} ${SOURCE_LIST_02}.bak
    if [[ ${TMOE_GITHUB} != true ]]; then
        if [[ -e ${SOURCE_LIST_02} ]]; then
            SOURCE_LIST=${SOURCE_LIST_02}
            modify_mint_source_list
        fi
    fi
    if [[ -e ${SOURCE_LIST_03} ]]; then
        mv -vf ${SOURCE_LIST_03} ${SOURCE_LIST_03}.bak
    fi
}
####################
if [[ ! -e /etc/apt/sources.list.d/raspi.list ]]; then
    case $(uname -m) in
    mips* | risc*) ;;
    *)
        if grep -q 'Debian' "/etc/issue"; then
            debian_sources_list
            case $(uname -m) in
            arm* | mips*) sed -i 's@163.com@huaweicloud.com@g' /etc/apt/sources.list ;;
            esac
        fi
        ;;
    esac
fi
###############
case $(uname -m) in
amd64|x86_64) _arch=amd64;;
armv7*|armv8l) _arch=armhf;;
aarch64|arm64|armv9*|armv8*) _arch=arm64;;
pcc64*) _arch=ppc64el;;
mips64*) _arch=mips64el;;
mips*) _arch=mipsel;;
s390*) _arch=s390x;;
esac

fix_whiptail_0_52_21() {
    is_whiptail_0_52_21=$(whiptail --version 2>/dev/null | awk '{b = match($3, /^0\.52\.21$/)} END {print (b)?"true": "false"}' 2>/dev/null)
    _file="/opt/patch/whiptail-wrapper_0.52.21_all.tar.gz"
    $is_whiptail_0_52_21 && [ -s "$_file" ] && {
        tar -zxvf $_file -C /
        unlink "$_file"
        _lib_dir="/usr/local/lib/popt0"
        if ldd --version 2>&1 | grep -q 'musl'; then
            _so_file="${_arch}-musl.so"
        else
            _so_file="${_arch}-gnu.so"
        fi
        ln -svf "$_lib_dir/$_so_file" "$_lib_dir/0.so"
        /usr/local/sbin/whiptail-wrapper --init
    }
}

TUNA_MIRROR_URL='mirrors.bfsu.edu.cn'
if [ -e /etc/apt/sources.list.d/armbian.list ]; then
    case $(uname -m) in
    aarch64) dpkg --remove-architecture armhf ;;
    esac
    cd /etc/apt/sources.list.d
    cp armbian.list armbian.list.bak
    sed -i 's/^/#&/g' armbian.list.bak
    sed -i 's@apt.armbian.com@mirrors.bfsu.edu.cn/armbian@g' armbian.list
    #sed -i '$ a\deb http://mirrors.bfsu.edu.cn/armbian/ bullseye main bullseye-utils bullseye-desktop' /etc/apt/sources.list.d/armbian.list
    cat armbian.list.bak >>armbian.list
    rm -f armbian.list.bak
    cd ~
elif [ -e /etc/apt/sources.list.d/raspi.list ]; then
    cd /etc/apt/sources.list.d
    cp raspi.list raspi.list.bak
    sed -i 's/^/#&/g' raspi.list.bak
    #http://archive.raspberrypi.org/debian/ buster main
    #deb http://mirrors.bfsu.edu.cn/raspbian/raspbian/ buster main non-free contrib rpi
    #mirrors.bfsu.edu.cn/raspberrypi/
    sed -i "s@archive.raspberrypi.org/debian@${TUNA_MIRROR_URL}/raspberrypi@g" raspi.list
    cat raspi.list.bak >>raspi.list
    rm -f raspi.list.bak
    cd ..
    cp sources.list sources.list.bak
    sed -i "s@raspbian.raspberrypi.org/raspbian@${TUNA_MIRROR_URL}/raspbian/raspbian@g" sources.list
    sed -i 's/^/#&/g' sources.list.bak
    cat sources.list.bak >>sources.list
    cd ~
fi
###############
if grep -q 'Kali' "/etc/issue"; then
    kali_sources_list
elif [ "$(cut -c 1-6 /etc/issue)" = "Ubuntu" ]; then
    ubuntu_sources_list
elif grep -q 'Mint' "/etc/issue"; then
    mint_sources_list
elif grep -q 'OpenWrt' "/etc/os-release"; then
    cp /etc/opkg/distfeeds.conf /etc/opkg/distfeeds.conf.bak
    sed -i 's@downloads.openwrt.org@mirrors.bfsu.edu.cn/openwrt@g' /etc/opkg/distfeeds.conf
fi
#################
unset TMOE_GITHUB
###tmoe-github TMOE_GITHUB=true
#勿删上面那条注释
###tmoe-github [[ -e /etc/apt/sources.list ]] && sed -i 's/^deb/# &/g;s/^##deb/deb/g' /etc/apt/sources.list 2>/dev/null
##dns

regen_dns_conf() {
[[ -e /etc/apt/sources.list ]] && apt-get autoremove --purge -y systemd-resolved 2>/dev/null

rm -f /etc/resolv.conf 2>/dev/null
cat >/etc/resolv.conf <<-'EndOfFile'
nameserver 114.114.114.114
nameserver 114.114.115.115
nameserver 240c::6666
nameserver 240c::6644
EndOfFile
if [[ -s /tmp/resolv.conf ]]; then
    cp -f /tmp/resolv.conf /etc
elif [[ -s ${TMOE_TMP_DIR}/resolv.conf ]]; then
    chmod 644 ${TMOE_TMP_DIR}/resolv.conf
    cp -fv ${TMOE_TMP_DIR}/resolv.conf /etc
    cp -f ${TMOE_TMP_DIR}/resolv.conf /tmp
fi
chmod -v 644 /etc/resolv.conf
}

    regen_dns_conf
cat /etc/resolv.conf
printf "%s\n" ""
######################
###################
arch_linux_mirror_list() {
    sed -i 's/^Server/#&/g' /etc/pacman.d/mirrorlist
    case $(uname -m) in
    aarch64 | arm*)
        cat >>/etc/pacman.d/mirrorlist <<-'EndOfArchMirrors'
## Archlinux arm
Server = https://mirrors.ustc.edu.cn/archlinuxarm/$arch/$repo     
Server = https://mirror.archlinuxarm.org/$arch/$repo
Server = https://mirrors.bfsu.edu.cn/archlinuxarm/$arch/$repo
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo
Server = https://mirrors.163.com/archlinuxarm/$arch/$repo
EndOfArchMirrors
        ;;
    *)
        cat >>/etc/pacman.d/mirrorlist <<-'EndOfArchMirrors'
## Archlinux mirror list
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.huaweicloud.com/archlinux/$repo/os/$arch
Server = https://mirrors.163.com/archlinux/$repo/os/$arch
EndOfArchMirrors
        ;;
    esac
}
#############################
manjaro_mirror_list() {
    if [ "$(uname -m)" = "aarch64" ]; then
        [[ ! $(command -v sed) ]] || sed -i 's/^Server/#&/g' /etc/pacman.d/mirrorlist 2>/dev/null
        cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
        cat >/etc/pacman.d/mirrorlist <<-'EndOfArchMirrors'
## Archlinux arm
#Server = https://mirror.archlinuxarm.org/$arch/$repo
#Server = https://mirrors.bfsu.edu.cn/archlinuxarm/$arch/$repo
#Server = https://mirrors.huaweicloud.com/manjaro/arm-stable/$repo/$arch
## Manjaro linux arm
## Country : Netherlands
#Server = https://manjaro.mirrors.lavatech.top/arm-stable/$repo/$arch
## Country : France
#Server = http://kibo.remi.lu/arm-stable/$repo/$arch
## Country : Germany
#Server = https://mirror.alpix.eu/manjaro/arm-stable/$repo/$arch
## Country : Poland
#Server = https://mirror.tuchola-dc.pl/manjaro/arm-stable/$repo/$arch
## Country : New_Zealand
#Server = http://manjaro.mirrors.theom.nz/arm-stable/$repo/$arch
## Country : China
Server = https://mirrors.bfsu.edu.cn/manjaro/arm-stable/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/arm-stable/$repo/$arch
Server = https://mirrors.ustc.edu.cn/manjaro/arm-stable/$repo/$arch
EndOfArchMirrors
    elif [[ "$(uname -m)" = "x86_64" ]]; then
        cat >/etc/pacman.d/mirrorlist <<-'EndOfArchMirrors'
#Server = https://manjaro.mirrors.lavatech.top/stable/$repo/$arch
#Server = https://manjaro.grena.ge/stable/$repo/$arch
#Server = https://mirror.oldsql.cc/manjaro/stable/$repo/$arch
Server = https://mirrors.bfsu.edu.cn/manjaro/stable/$repo/$arch
Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch     
EndOfArchMirrors
    fi
}
#################
install_fakeroot() {
    for i in whiptail whereis diff ip curl; do
        if [ ! $(command -v ${i}) ]; then
            case ${i} in
            whiptail) DEP=libnewt ;;
            whereis) DEP=util-linux ;;
            diff) DEP=diffutils ;;
            ip) DEP=iproute ;;
            *) DEP=${i} ;;
            esac
            printf "%s\n" "${GREEN}pacman ${YELLOW}-S ${PURPLE}--noconfirm ${BLUE}${DEP}${RESET}"
            pacman -S --noconfirm --needed ${DEP}
        fi
    done

    i=fakeroot-tcp
    printf "%s\n" "${GREEN}pacman ${YELLOW}-Sy --noconfirm ${BLUE}${i}${RESET}"
    pacman -Sy --noconfirm ${i}
    cd ${HOME}
}
############
add_arch_for_edu_repo() {
    if ! grep -q 'arch4edu' /etc/pacman.conf; then
        cat >>/etc/pacman.conf <<-'Endofpacman'
[arch4edu]
Server = https://mirrors.bfsu.edu.cn/arch4edu/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
Server = https://mirror.autisten.club/arch4edu/$arch
Server = https://arch4edu.keybase.pub/$arch
Server = https://mirror.lesviallon.fr/arch4edu/$arch
Server = https://mirrors.tencent.com/arch4edu/$arch
SigLevel = Never
Endofpacman
pacman -Sy --noconfirm arch4edu-keyring
    fi
}
add_archlinuxcn_repo() {
    if ! grep -q 'archlinuxcn' /etc/pacman.conf; then
        cat >>/etc/pacman.conf <<-'Endofpacman'
[archlinuxcn]
Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://repo.archlinuxcn.org/$arch
SigLevel = Never
Endofpacman
    fi
    printf "%s\n" "${GREEN}pacman ${YELLOW}-Syyu ${PURPLE}--noconfirm${RESET}"
    pacman -Syyu --noconfirm
}
arch_linux_paru() {
# pacman-key --populate archlinuxcn
# archlinux-keyring archlinuxcn-keyring
    printf "%s\n" "${GREEN}pacman ${YELLOW}-Sy ${PURPLE}--noconfirm --needed ${BLUE}paru${RESET}"
    pacman -Sy --noconfirm --needed paru  
pacman -S --noconfirm --needed openssl-1.1 libnewt 2>/dev/null
fix_whiptail_0_52_21
if [[ ! $(command -v paru) ]]; then
get_arch_paru
fi
}
get_arch_paru() {
declare -A paru
paru[file]="paru.tar.zst"
paru[proxy]="paru-arm64"

case $(uname -m) in
armv7* | armv8l) paru[proxy]="paru-armv7" ;;
aarch64 | armv8* | armv9*) paru[proxy]="paru-arm64" ;;
*) 
cd ~
pacman -Sy --noconfirm --needed paru
return 0
;;
esac
paru[gh]=${paru[proxy]}"-github"
paru[uri]="https://l.tmoe.me/"
cd /tmp || exit   
curl -Lo "${paru[file]}" "${paru[uri]}${paru[gh]}" || curl -Lo "${paru[file]}" "${paru[uri]}${paru[proxy]}"
tar -xvf "${paru[file]}"
install -Dm755 paru /usr/bin

printf "%s\n" \
"You should run ${GREEN}paru -Sy ${BLUE}paru-bin${RESET} to upgrade it."
cd ~
}
#################
#################
if [ "$(cut -c 1-4 /etc/issue)" = "Arch" ]; then
    [[ ${TMOE_GITHUB} = true ]] || arch_linux_mirror_list
    [[ ! -e /etc/pacman.d/mirrorlist ]] || cat /etc/pacman.d/mirrorlist
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        printf "%s\n" "${GREEN}pacman-key ${YELLOW}--init${RESET}"
        printf "%s\n" "${GREEN}pacman-key ${YELLOW}--populate${RESET}"
        pacman-key --init
        pacman-key --populate
        if [ -e "/etc/mkinitcpio.d/linux-armv7.preset" ]; then
            printf "%s\n" "${GREEN}pacman ${PURPLE}-Rsc ${YELLOW}--noconfirm ${BLUE}linux-armv7${RESET}"
            pacman -Rsc --noconfirm linux-armv7
        fi
        printf "%s\n" "${GREEN}pacman ${YELLOW}-Syu --noconfirm --needed ${BLUE}base-devel${RESET}"
        pacman -Syu --noconfirm --needed base-devel
    fi
elif [ "$(cut -c 1-7 /etc/issue)" = "Manjaro" ]; then
    [[ ${TMOE_GITHUB} = true ]] || manjaro_mirror_list
    [[ ! -e /etc/pacman.d/mirrorlist ]] || cat /etc/pacman.d/mirrorlist
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        printf "%s\n" "${GREEN}pacman-key ${YELLOW}--init${RESET}"
        printf "%s\n" "${GREEN}pacman-key ${YELLOW}--populate${RESET}"
        pacman-key --init
        pacman-key --populate
        printf "%s\n" "${GREEN}pacman ${YELLOW}-Syu --noconfirm ${BLUE}base base-devel${RESET}"
        pacman -Syu --noconfirm base base-devel
    fi
fi

if [[ -e "/etc/pacman.conf" && $(command -v grep) ]]; then
sed -i.bak -E "s@^#(Color)@\1@" /etc/pacman.conf
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
            case $(uname -m) in
            armv7*|armv8l) ;;
            *) add_arch_for_edu_repo ;;
            esac
        add_archlinuxcn_repo
        arch_linux_paru
        cat /etc/pacman.conf
    else
        if [[ ! -x /usr/bin/paru && ! -x /opt/bin/paru ]]; then
            get_arch_paru
        fi
        if [[ ${TMOE_CHROOT} = true ]]; then
            i=gawk
            printf "%s\n" "${GREEN}pacman ${YELLOW}-Sy --noconfirm ${BLUE}${i}${RESET}"
            pacman -Sy --noconfirm ${i}
        fi
    fi
fi

#######################
case ${TMOE_PROOT} in
true)
    for i in sd tf; do
        if [[ -e "/media/${i}" && ! -e "/${i}" ]]; then
            ln -sv media/${i} /
        fi
    done
    for i in sd tf termux; do
        if [[ -e "/media/${i}" && ! -e "/root/${i}" ]]; then
            ln -sv ../media/${i} /root/
        fi
    done
    unset i
    ;;
esac
choose_vnc_port_5902_or_5903() {
    if ("${TUI_BIN:-whiptail}" --title "VNC PORT" --yes-button "5902" --no-button "5903" --yesno "請選擇VNC端口✨\nPlease choose a vnc port" 0 50); then
        X11VNC_PORT=5902
        DISPLAY_PORT=2
    else
        X11VNC_PORT=5903
        DISPLAY_PORT=3
    fi
    sed -i -E "s@(DISPLAY)=.*@\1=:${DISPLAY_PORT}@" "$(command -v startvnc)"
}
set_vnc_passwd() {
    TARGET_VNC_PASSWD=$("${TUI_BIN:-whiptail}" --inputbox "請設定6至8位VNC訪問密碼\nPlease type the password, the length is between 6 and 8" 0 50 --title "VNC PASSWORD" 3>&1 1>&2 2>&3)
    if [ "$?" != "0" ]; then
        printf "%s\n" "请重新输入密码"
        printf "%s\n" "Please type the password again."
        printf "%s\n" "Press enter to return."
        read
        set_vnc_passwd
    elif [ -z "${TARGET_VNC_PASSWD}" ]; then
        printf "%s\n" "请输入有效的数值"
        printf "%s\n" "Please type a valid value"
        printf "%s\n" "Press enter to return."
        read
        set_vnc_passwd
    else
        mkdir -pv ${HOME}/.vnc
        cd ${HOME}/.vnc
        printf "%s\n" "${TARGET_VNC_PASSWD}" | vncpasswd -f >passwd
        chmod 600 -v passwd
        [[ ! -e /usr/bin/startvnc ]] || ln -sf /usr/bin/startvnc /usr/local/bin/startvnc
        mkdir -pv /etc/X11/xinit
        [[ -e /etc/X11/xinit/Xsession ]] || cp -vf /root/.vnc/xstartup /etc/X11/xinit/Xsession
        [[ $(command -v startxsd) ]] || printf "%s\n%s\n%s\n" '#!/bin/sh' "export DISPLAY=127.0.0.1:0" "/etc/X11/xinit/Xsession" >/usr/local/bin/startxsdl
        chmod a+rx /usr/local/bin/startxsdl
    fi
}
exit_tmoe_configuration() {
    cd ~
    rm -f ~/.zlogin ~/.profile zsh.sh zsh-i.sh 2>/dev/null
    [[ ! -e ~/.profile.bak ]] || mv -f ~/.profile.bak ~/.profile 2>/dev/null
    for i in zsh bash sh su; do
        if [[ $(command -v ${i}) ]]; then
            exec ${i}
            break
        fi
    done
    exit 0
}
if grep -q 'puppy_linux' /etc/os-release; then
    choose_vnc_port_5902_or_5903
    set_vnc_passwd
    printf "%s\n" "You can type ${GREEN}startvnc${RESET} to start ${BLUE}tightvnc server${RESET},type ${RED}stopvnc${RESET} to stop it."
    printf "%s\n" "当前系统已经了预装窗口管理器和tightvnc服务端,您可以输${GREEN}startvnc${RESET}来启动vnc服务端。"
elif grep -q 'Solus' /etc/os-release; then
    if [[ $(command -v debian-i) ]]; then
        cp $(command -v debian-i) /usr/local/bin/tmoe
    fi
    printf "%s\n" "${GREEN}eopkg ${BLUE}update-repo${RESET}"
    eopkg update-repo
    eopkg help
    exit_tmoe_configuration
fi

    # EulerOS|amazon_linux|Oracle Linux
if grep -Eq 'puppy_linux|clear-linux-os|VMware Photon OS|SteamOS GNU' /etc/os-release 2>/dev/null; then
    exit_tmoe_configuration
fi
##############
if [ -e "${TMOE_LOCALE_FILE}" ]; then
    TMOE_LANG=$(head -n 1 ${TMOE_LOCALE_FILE})
else
    TMOE_LANG="zh_CN.UTF-8"
fi
TMOE_LANG_HALF=$(printf '%s\n' "${TMOE_LANG}" | cut -d '.' -f 1)
TMOE_LANG_QUATER=$(printf '%s\n' "${TMOE_LANG}" | cut -d '.' -f 1 | cut -d '_' -f 1)

case ${TMOE_LANG} in
zh_*UTF-8)
    printf "%s\n" "您已成功安装Container,之后可以输${YELLOW}debian${RESET}来进入kali container."
    printf "%s\n" "Congratulations on your successful installation of GNU/Linux container. After that, you can type debian to enter the container."
    printf '%s\n' '正在执行优化步骤，请勿退出!'
    printf '%s\n' 'Optimization steps are in progress. Do not exit!'
    #配置时区
    printf '%s\n' 'Asia/Shanghai' >/etc/timezone
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    ;;
*)
    printf "%s\n" "Congratulations on your successful installation of GNU/Linux container. After that, you can type debian to enter the container. "
    printf '%s\n' 'Optimization steps are in progress. Do not exit!'
    printf '%s\n' 'UTC' >/etc/timezone
    ln -svf /usr/share/zoneinfo/UTC /etc/localtime
    ;;
esac

for i in /etc/gitstatus/timezone.txt /root/.cache/gitstatus/timezone.txt; do
    if [[ -e ${i} ]]; then
        TIMEZONE=$(head -n 1 ${i})
        ln -svf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
        cp -f ${i} /etc/timezone
        chmod 644 -v /etc/timezone
        break
    fi
done
########################
configure_openwrt() {
    mkdir -pv /var/lock/
    touch /var/lock/opkg.lock
    opkg update
    opkg install libustream-openssl ca-bundle ca-certificates bash dialog whiptail
    printf "%s\n" "export PATH=\${PATH}:/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games" >>~/.zshenv
    rm -f ~/.profile ~/.zlogin 2>/dev/null
    mv -f ~/.profile.bak ~/.profile 2>/dev/null
    exec bash zsh.sh
    exit 0
}
alpine_linux_configure() {
    if [ "$(sed -n 2p /etc/os-release | cut -d '=' -f 2)" = "alpine" ]; then
        [[ ${TMOE_GITHUB} = true ]] || sed -i 's/dl-cdn.alpinelinux.org/mirrors.bfsu.edu.cn/g' /etc/apk/repositories
        cat /etc/apk/repositories
        printf "%s\n" "${GREEN}apk ${YELLOW}add ${BLUE}bash tzdata newt sudo shadow${RESET}"
        printf "%s\n" "${GREEN}apk ${YELLOW}upgrade${RESET}"
        apk update
        apk upgrade
        apk add bash tzdata newt sudo shadow
        # fix_whiptail_0_52_21
    fi
    rm -f ~/.profile ~/.zlogin 2>/dev/null
    mv -f ~/.profile.bak ~/.profile 2>/dev/null
    #printf "%s\n" "您已成功安装Container,之后可以输${YELLOW}debian${RESET}来进入kali container."
    #neofetch
    exec bash zsh.sh
    exit 0
}
############################
opensuse_mirrors() {
    if [ "$(uname -m)" = 'aarch64' ]; then
        zypper mr -da
        zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/ports/aarch64/tumbleweed/repo/oss bfsu-mirror-oss
        zypper --gpg-auto-import-keys refresh
    elif [ "$(uname -m)" != 'armv7l' ]; then
        zypper mr -da
        zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/tumbleweed/repo/oss/ bfsu-mirror-oss
        zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/tumbleweed/repo/non-oss/ bfsu-mirror-non-oss
        zypper addrepo -fcg https://mirrors.bfsu.edu.cn/packman/suse/openSUSE_Tumbleweed/ bfsu-mirror_Tumbleweed
        zypper --gpg-auto-import-keys refresh
        #zypper dup --no-allow-vendor-change -y
    fi
}
opensuse_linux_repo() {
    LINUX_DISTRO='suse'
    [[ ${TMOE_GITHUB} = true ]] || opensuse_mirrors
    zypper in -y wget curl
    sed -i "s@RC_LANG=.*@RC_LANG=${TMOE_LANG}@" /etc/sysconfig/language
    sed -i "s@RC_LC_ALL=.*@RC_LC_ALL=${TMOE_LANG}@" /etc/sysconfig/language
    sed -i "s@INSTALLED_LANGUAGES=@INSTALLED_LANGUAGES=${TMOE_LANG_HALF}@" /etc/sysconfig/language
    zypper in -y glibc-locale glibc-i18ndata
    zypper in -y translation-update-${TMOE_LANG_HALF}
}
################################
if grep -q 'openSUSE' "/etc/os-release"; then
    opensuse_linux_repo
    zypper in -y newt
elif grep -q 'Alpine Linux' "/etc/issue" 2>/dev/null; then
    alpine_linux_configure
elif grep -q 'OpenWrt' "/etc/os-release"; then
    configure_openwrt
fi
##############################
if [[ $(command -v apt) ]]; then
    if [[ ! $(command -v eatmydata) ]]; then
        printf "%s\n" "${GREEN}apt ${YELLOW}install -y ${BLUE}eatmydata${RESET}"
        apt update 2>/dev/null || apt update 2>/dev/null
        apt install -y eatmydata || apt install -y -f eatmydata
    else
        printf "%s\n" "${GREEN}eatmydata apt ${BLUE}update${RESET}"
        eatmydata apt update || apt update
    fi
    if [[ ${TMOE_CHROOT} = true ]]; then
            if [[ -n $(command -v perl) ]]; then
            printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}reinstall -y ${BLUE}perl-base${RESET}"
            eatmydata apt-get install --reinstall -y perl-base 2>/dev/null || apt-get install --reinstall -y perl-base 2>/dev/null
            fi
        fi
    if [ ! $(command -v locale-gen) ]; then
        printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}locales${RESET}"
        eatmydata apt install -y locales 2>/dev/null || apt install -y locales 2>/dev/null
    fi
fi
STARTUP_FILE=/usr/local/etc/tmoe-linux/container/tmoe-linux-container
if [[ -s ${STARTUP_FILE} ]]; then
    if grep -q "^HOST_ARCH" ${STARTUP_FILE}; then
        HOST_ARCH=$(grep "^HOST_ARCH=" ${STARTUP_FILE} | awk -F '=' '{print $2}' | cut -d '"' -f 2)
        CONTAINER_ARCH=$(grep "^CONTAINER_ARCH=" ${STARTUP_FILE} | awk -F '=' '{print $2}' | cut -d '"' -f 2)
        case ${HOST_ARCH} in
        arm64 | armhf)
            if [[ ${CONTAINER_ARCH} = i386 ]]; then
                # sed -E -e "s@^(EXA_ENABLED=).*@\1true@g" -i "${STARTUP_FILE}"
                if [[ $(command -v apt) ]]; then
                    printf "%s\n" "${GREEN}apt ${YELLOW}reinstall -y ${BLUE}perl-base${RESET}"
                    apt-get install --reinstall -y perl-base 2>/dev/null
                    for i in perlbug unzip pigz; do
                        if [[ -L /usr/bin/${i} ]]; then
                            case ${i} in
                            perlbug) DEP="perl" ;;
                            *) DEP=${i} ;;
                            esac
                            printf "%s\n" "${GREEN}apt ${YELLOW}reinstall -y ${BLUE}${DEP}${RESET}"
                            apt-get install --reinstall -y ${DEP} 2>/dev/null
                        fi
                    done
                    for i in 6 7 8 9 10; do
                        if [[ -L "/usr/bin/python3.${i}m" ]]; then
                            printf "%s\n" "${GREEN}apt ${YELLOW}reinstall -y ${BLUE}python3.${i}-minimal${RESET}"
                            apt-get install --reinstall -y python3.${i}-minimal 2>/dev/null
                            dpkg --configure -a
                            break
                        fi
                    done
                fi
            fi
            ;;
        esac
    fi
fi

locale_def_utf8() {
# glibc-common, libc-bin
if [[ -z $(command -v localedef) ]]; then
return 0
fi

local lang=${TMOE_LANG_HALF}

# locale -a
if (! localedef --list-archive | grep -qi "$lang.*utf.*8"); then
printf "%s\n" \
"${GREEN}Generating ${BLUE}locales ${YELLOW}(this might take a while)${PURPLE}..." \
"${BLUE}${lang}.UTF-8${RESET}"

# -c(--force), -v(--verbose), -f(--charmap), -i(--inputfile)
localedef \
-c \
-i "${lang}" \
-f UTF-8 \
"${lang}".UTF-8
fi
}

if grep -q 'ubuntu' /etc/os-release; then
    if [ ! -e /usr/lib/locale/zh_CN ]; then
        printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}locales-all${RESET}"
        eatmydata apt install -y locales-all 2>/dev/null || apt install -y locales-all 2>/dev/null
    fi
    printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}^language-pack-${TMOE_LANG_QUATER}${RESET}"
    eatmydata apt install -y ^language-pack-${TMOE_LANG_QUATER} 2>/dev/null || apt install -y ^language-pack-${TMOE_LANG_QUATER} 2>/dev/null
fi

mkdir -pv /etc/default
printf "%s\n" "Configuring ${TMOE_LANG_HALF} environment..."
cat >/etc/default/locale <<-EOF
LANG=${TMOE_LANG}
LANGUAGE=${TMOE_LANG_HALF}:${TMOE_LANG_QUATER}
LC_ALL=${TMOE_LANG}
EOF

if [[ -n "$(command -v dpkg-query)" ]];then
if (! dpkg-query -s locales-all >/dev/null 2>&1);then
locale_def_utf8 2>/dev/null
fi
else
locale_def_utf8 2>/dev/null
fi
source /etc/default/locale 2>/dev/null
###############
if [[ -e /etc/apt/sources.list.d/system76-ubuntu-pop-focal.list ]]; then
    apt-cache show pop-desktop
    printf "%s\n" "If you are using a systemd-nspawn container, then you can type ${GREEN}apt${RESET} ${YELLOW}install ${BLUE}pop-desktop${RESET} to install Pop\!OS desktop."
    exit_tmoe_configuration
fi
#################
if grep -Eq "Arch|Manjaro" '/etc/os-release' 2>/dev/null || grep -Eq "Arch|Manjaro" '/etc/issue'; then
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        printf "%s\n" "${GREEN}pacman ${PURPLE}-R ${YELLOW}--noconfirm ${BLUE}fakeroot${RESET}"
        pacman -R --noconfirm fakeroot 2>/dev/null
        install_fakeroot
    fi
fi
printf "$YELLOW"
cat <<-'EndOFneko'
                                     
       DL.                           
       QBBBBBKv:rr77ri:.             
       gBBQdY7::::..::i7vv.          
       UBd. . .:.........rBBBQBBBB5  
       Pu  :..r......i:....BBBQBBB:  
       ri.i:.j:...:. i7... uBBZrd:   
 :     7.:7.7U.:..r: Yr:.. iQ1:qU    
.Qi   .7.ii.X7:...L.:qr:...iB7ZQ     
 .27. :r.r:L7i::.7r:vri:...rr  .     
  v   ::.Yrviri:7v7v: ::...i.   i    
      r:ir: r.iiiir..:7r...r   :P.2Y 
      v:vi::.      :  ::. .qI7U1U :1 
Qr    7.7.         :.i::. :Di:. i .v:
v7..  s.r7.   ...   .:7i: rDi...r .. 
 vi: .7.iDBBr  .r   .:.7. rPr:..r    
 i   :virZBgi  :vrYJ1vYY .ruY:..i    
     YrivEv. 7BBRBqj21I7 .77J:.:.PQ  
    .1r:q.   rB52SKrj.:i i5isi.:i :.r
    YvrY7    r.  . ru :: PIrj7.:r..v 
   rSviYI..iuU .:.:i:.7.KPPiSr.:vr   
  .u:Y:JQMSsJUv...   .rDE1P71:.7X7   
  5  Ivr:QJ7JYvi....ir1dq vYv.7L.Y   
  S  7Z  Qvr:.iK55SqS1PX  Xq7u2 :7   
         .            i   7          

EndOFneko
printf "$RESET"
####################
    dpkg_reconfigure_deb_frontend() {
        # debconf-show debconf
        echo "debconf debconf/priority select low" | debconf-set-selections
        echo "debconf debconf/frontend select Dialog" | debconf-set-selections
        DEBIAN_FRONTEND=noninteractive dpkg-reconfigure debconf
    }
if [[ $(command -v apt-get) ]]; then
    if [[ ! $(command -v apt-extracttemplates) ]]; then
        printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}apt-utils${RESET}"
        eatmydata apt install -y apt-utils 2>/dev/null || apt install -y apt-utils 2>/dev/null
    fi

    for i in curl sudo whiptail; do
        if [[ ! $(command -v ${i}) ]]; then
            printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}${i}${RESET}"
            eatmydata apt install -y ${i} || apt install -y ${i}
        fi
    done
        # match_dpkg_ver(pkg: string, ver: regex_str) -> bool
        match_dpkg_ver() {
            LANG=C dpkg-query -W $1 2>/dev/null | awk -v ver=$2 '{ b = match($2, ver)} END{ print (b)?"true":"false"}' 2>/dev/null
        }

        is_libpopt0_1_19=$(match_dpkg_ver libpopt0 '^1\.19[+\-.~]')
        is_libnewt_0_52_21=$(match_dpkg_ver libnewt0.52 '^0\.52\.21[+\-.~]')

        ($is_libnewt_0_52_21 && $is_libpopt0_1_19) && {
            fix_whiptail_0_52_21
        }

        dpkg_reconfigure_deb_frontend
    if [[ ! -e /usr/sbin/update-ca-certificates ]]; then
        printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}ca-certificates${RESET}"
        eatmydata apt install -y ca-certificates 2>/dev/null || apt install -y ca-certificates 2>/dev/null
    fi
    if grep -Eq 'squeeze|wheezy|stretch|jessie|CODENAME=xenial' "/etc/os-release"; then
        eatmydata apt install -y apt-transport-https 2>/dev/null || apt install -y apt-transport-https 2>/dev/null
    fi
fi

if [[ ! -e /etc/apt/sources.list.d/raspi.list && -e /etc/apt/sources.list ]]; then
    case $(uname -m) in
    riscv*) ;;
    *)
        if grep -Eq '^deb.*(huawei|tuna|bfsu|163)' /etc/apt/sources.list; then
            printf "%s\n" "Replacing http software source list with https ..."
            case ${TMOE_LANG} in
            zh_*UTF-8) printf "%s\n" "正在将${PURPLE}http源${RESET}替换为${GREEN}https${RESET} ..." ;;
            esac
            case $(dpkg --print-architecture) in
            armhf)
                case $(uname -m) in
                aarch64 | armv8l) ;;
                *) sed -i 's@http:@https:@g' /etc/apt/sources.list ;;
                esac
                ;;
            *) sed -i 's@http:@https:@g' /etc/apt/sources.list ;;
            esac
        fi
        ;;
    esac
    sed -i 's@https://security@http://security@g' /etc/apt/sources.list
fi
##########################
gentoo_gnu_linux_make_conf() {
    LINUX_DISTRO=gentoo
    #bash /etc/profile
    mkdir -pv '/usr/portage'
    case ${TMOE_LANG} in
    zh_*UTF-8)
        grep -q 'zh_CN' /etc/locale.gen || printf "%s\n" \
"zh_CN.UTF-8 UTF-8" \
"en_US.UTF-8 UTF-8" \
>>/etc/locale.gen
        locale-gen
        GENTOOLOCALE="$(eselect locale list | grep 'zh_CN' | head -n 1 | cut -d '[' -f 2 | cut -d ']' -f 1)"
        eselect locale set "${GENTOOLOCALE}"
        printf '%s\n' \
'ACCEPT_LICENSE="*"' \
'MAKEOPTS="-j8"' \
'L10N="zh-CN en-US"' \
'LINGUAS="zh_CN en_US"' \
'PORTDIR="/usr/portage"' \
'DISTDIR="${PORTDIR}/distfiles"' \
'PKGDIR="${PORTDIR}/packages"' \
'GENTOO_MIRRORS="https://mirrors.bfsu.edu.cn/gentoo"' \
'EMERGE_DEFAULT_OPTS="--ask --verbose=y --keep-going --with-bdeps=y --load-average"' \
'FEATURES="${FEATURES} -userpriv -usersandbox -sandbox"' \
>>/etc/portage/make.conf
        ;;
    *)
        grep -q 'en_US' /etc/locale.gen || printf "%s\n" "en_US.UTF-8 UTF-8" >>/etc/locale.gen
        locale-gen
        printf '%s\n' \
'ACCEPT_LICENSE="*"' \
'MAKEOPTS="-j8"' \
'PORTDIR="/usr/portage"' \
'DISTDIR="${PORTDIR}/distfiles"' \
'PKGDIR="${PORTDIR}/packages"' \
'EMERGE_DEFAULT_OPTS="--ask --verbose=y --keep-going --with-bdeps=y --load-average"' \
'FEATURES="${FEATURES} -userpriv -usersandbox -sandbox"' \
>>/etc/portage/make.conf
        ;;
    esac
    cat /etc/portage/make.conf
    source /etc/portage/make.conf 2>/dev/null
    mkdir -pv /etc/portage/repos.conf/
    cat >/etc/portage/repos.conf/gentoo.conf <<-'EndofgentooConf'
[gentoo]
location = /usr/portage
sync-type = rsync
#sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/
sync-uri = rsync://mirrors.bfsu.edu.cn/gentoo-portage/
auto-sync = yes
EndofgentooConf
    source /etc/portage/repos.conf/gentoo.conf 2>/dev/null
    rm -fv .profile ~/.zlogin
    mv -f .profile.bak .profile 2>/dev/null
    if grep -q 'Funtoo' /etc/os-release; then
        emerge --sync
        emerge emerge-webrsync
    fi
    emerge-webrsync
    emerge --config sys-libs/timezone-data 2>/dev/null
    GENTOO_NON_SYSTEMD_PROFILE="$(eselect profile list | grep -Ev 'desktop|hardened|developer|systemd|selinux|multilib' | grep stable | tail -n 1 | cut -d '[' -f 2 | cut -d ']' -f 1)"
    [[ -n ${GENTOO_NON_SYSTEMD_PROFILE} ]] || GENTOO_NON_SYSTEMD_PROFILE=1
    eselect profile set "${GENTOO_NON_SYSTEMD_PROFILE}"
    eselect profile list
    etc-update --automode -3
    etc-update
    #dispatch-conf
    emerge -uvDN --with-bdeps=y @world
    if [[ ! $(command -v ar) ]]; then
        emerge -avk sys-devel/binutils
    fi
    emerge eix 2>/dev/null
    eix-update
    [[ $(command -v whiptail) ]] || emerge -av dev-libs/newt
    #rm -f vnc* zsh* .profile
}
#############################
void_linux_repository() {
    LINUX_DISTRO='void'
    LOCALE_FILE="/etc/default/libc-locales"
    sed -i "s/^#.*${TMOE_LANG} UTF-8/${TMOE_LANG} UTF-8/" ${LOCALE_FILE} 2>/dev/null
    if ! grep -Eq "^[^#]*${TMOE_LANG_HALF}" "${LOCALE_FILE}" 2>/dev/null; then
        #sed -i 's@^@#&@g;s@##@#@g' ${LOCALE_FILE} 2>/dev/null
        printf "\n" >>${LOCALE_FILE}
        sed -i "$ a${TMOE_LANG} UTF-8" ${LOCALE_FILE}
    fi
    cat >/etc/locale.conf <<-'EOF'
LANG=${TMOE_LANG}
LANGUAGE=${TMOE_LANG_HALF}:${TMOE_LANG_QUATER}
LC_ALL=${TMOE_LANG}
EOF
    mkdir -pv /etc/xbps.d
    cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
    sed -i 's@https://alpha.de.repo.voidlinux.org@https://mirrors.bfsu.edu.cn/voidlinux@g' /etc/xbps.d/*-repository-*.conf
    xbps-install -S
    xbps-install -uy xbps
    xbps-install -y wget curl newt
    neofetch
    xbps-reconfigure -f glibc-locales
}
##########################
if grep -Eq 'Funtoo|Gentoo' '/etc/os-release'; then
    gentoo_gnu_linux_make_conf
elif grep -qi 'Void' '/etc/issue'; then
    void_linux_repository
fi
####################
if [[ $(command -v apt) ]]; then
    apt update 2>/dev/null
    apt list --upgradable 2>/dev/null
    if [[ ! $(command -v curl) ]]; then
        apt install -y curl apt-utils
    fi
    printf "%s\n" "Upgrading all packages ..."
    printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}-y ${BLUE}dist-upgrade${RESET}"
    if [[ ${WEEKLY_BUILD_CONTAINER} != true && ! -e /etc/apt/sources.list.d/system76-ubuntu-pop-focal.list ]]; then
        eatmydata apt upgrade -y 2>/dev/null
        dpkg --configure -a
        eatmydata apt dist-upgrade -y 2>/dev/null || apt dist-upgrade -y 2>/dev/null
        dpkg --configure -a
    else
        printf "%s\n" "You are using weekly/moothly build container,${PURPLE}skipping automatic upgrade${RESET}..."
    fi
    if [[ ! $(command -v pkill) ]]; then
        printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}procps${RESET}"
        eatmydata apt install -y procps 2>/dev/null || apt install -y procps 2>/dev/null
    fi
    #i + dialog
    for i in whiptail; do
        if [[ ! $(command -v ${i}) ]]; then
            printf "%s\n" "${GREEN}eatmydata apt ${YELLOW}install -y ${BLUE}${i}${RESET}"
            eatmydata apt install -y ${i} 2>/dev/null || apt install -y ${i} 2>/dev/null
        fi
    done
    apt clean 2>/dev/null
fi
#############################
#grep -q 'export DISPLAY' /etc/profile || printf "%s\n" "export DISPLAY=":1"" >>/etc/profile
printf "%s\n" "Welcome to kali GNU/Linux."
sed -n p /etc/issue 2>/dev/null || sed -n p /etc/os-release
uname -a
rm -f .profile ~/.zlogin 2>/dev/null
if [ -f ".profile.bak" ]; then
    mv -f .profile.bak .profile
fi
####################
#fedora mirrors.bfsu.edu.cn/fedora/releases/
#########################
fedora_rpmfusion_repo() {
    printf "%s\n" "You are using fedora system. Adding rpmfusion repo ..."
    printf "%s\n" "${GREEN}dnf ${YELLOW}install -y --nogpgcheck ${BLUE}https://mirrors.bfsu.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.bfsu.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm${RESET}"
    dnf install -y --nogpgcheck https://mirrors.bfsu.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.bfsu.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    case ${TMOE_GITHUB} in
    true) ;;
    *)
        for i in $(ls /etc/yum.repos.d/rpmfusion*repo | grep -v rawhide); do
            #cp -vf ${i} ${i}.backup
            sed -e 's!^metalink=!#metalink=!g' \
                -e 's!^#baseurl=!baseurl=!g' \
                -e 's!//download1\.rpmfusion\.org/!//mirrors.bfsu.edu.cn/rpmfusion/!g' \
                -e 's!http://mirrors\.bfsu!https://mirrors.bfsu!g' \
                -i ${i}
        done
        ;;
    esac
}
######################
if [ "$(grep 'ID=' /etc/os-release | head -n 1 | cut -d '=' -f 2 | cut -d '"' -f 2)" = "fedora" ]; then
    tar -Ppzcf ~/yum.repos.d-backup.tar.gz /etc/yum.repos.d
    mv -f ~/yum.repos.d-backup.tar.gz /etc/yum.repos.d
    FEDORA_VERSION="$(grep 'VERSION_ID' /etc/os-release | cut -d '=' -f 2)"
    sed -i -E "s@(enabled)=1@\1=0@" /etc/yum.repos.d/fedora-updates-testing-modular.repo /etc/yum.repos.d/fedora-updates-testing.repo
    if grep -q '=rawhide' /etc/os-release; then
        sed -i -E 's@^(gpgcheck)=.*@\1=0@g' /etc/yum.repos.d/*.repo
    fi

    regen_dns_conf

    if ((${FEDORA_VERSION} >= 32)); then
        if ! grep -q '=rawhide' /etc/os-release; then
            [[ ${TMOE_CHROOT} != true ]] || fedora_rpmfusion_repo
        fi
    fi
    printf "%s\n" "${GREEN}dnf ${YELLOW}update -y${RESET}"
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        dnf update -y
    else
        printf "%s\n" "You are using weekly/moothly build container,${PURPLE}skipping automatic upgrade${RESET}..."
    fi
    [[ $(command -v hostname) ]] || dnf install -y hostname
    [[ $(command -v systemctl) ]] || dnf install -y systemd
    regen_dns_conf
    [[ $(command -v ip) ]] || dnf install -y iproute
    [[ $(command -v sudo) ]] || dnf install -y sudo

    printf "%s\n" "${GREEN}dnf ${YELLOW}install -y --skip-broken ${BLUE}dnf-utils passwd findutils man-db glibc-all-langpacks${RESET}"
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        dnf install -y --skip-broken dnf-utils passwd findutils man-db glibc-all-langpacks || yum install -y --skip-broken dnf-utils passwd findutils man-db glibc-all-langpacks
    fi
    if [[ ! $(command -v pkill) ]]; then
        printf "%s\n" "${GREEN}dnf ${YELLOW}install -y ${PURPLE}--skip-broken ${BLUE}procps-ng procps-ng-i18n${RESET}"
        dnf install -y --skip-broken procps-ng procps-ng-i18n
    fi
    #TMOE_LANG_HALF=$(printf '%s\n' "${LANG}" | cut -d '.' -f 1 |cut -d '_' -f 1)
    #glibc-all-langpacks
    #dnf install -y --skip-broken glibc-minimal-langpack.aarch64 "glibc-langpack-${TMOE_LANG_QUATER}*"
    [[ $(command -v whiptail) ]] || dnf install --skip-broken -y newt

    # is_whiptail_0_52=$(LANG=C rpm -qi newt 2>/dev/null | awk '/^Version/ {b = match($3, /0\.52\.21([+\-.~]+)?$/)} END{print (b)?"true":"false"}' 2>/dev/null)
    fix_whiptail_0_52_21

elif grep -Eq 'CentOS|Rocky Linux|rhel' /etc/os-release; then
    [[ ! -e /etc/yum.repos.d/CentOS-Base.repo ]] || cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    #curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
    #curl -Lo /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-8-anon.repo
    [[ $(command -v dnf) ]] || yum install -y dnf
    [[ $(command -v dnf) ]] || ln -svf $(command -v yum) /usr/bin/dnf
    printf "%s\n" "${GREEN}dnf ${YELLOW}install -y ${PURPLE}--skip-broken ${BLUE}epel-release${RESET}"
    yes | dnf install -y --skip-broken epel-release

    printf "%s\n" "${GREEN}dnf ${YELLOW}install -y --skip-broken ${BLUE}dnf-utils glibc-langpack-${TMOE_LANG_QUATER}*${RESET}"
    dnf install -y dnf-utils "glibc-langpack-${TMOE_LANG_QUATER}*" || yum install -y --skip-broken dnf-utils glibc-all-langpacks
export LANG=${TMOE_LANG}

    for i in hostname sudo; do
        if [[ ! $(command -v ${i}) ]]; then
            printf "%s\n" "${GREEN}dnf ${YELLOW}install -y ${PURPLE}--skip-broken ${BLUE}${i}${RESET}"
            dnf install -y --skip-broken ${i}
        fi
    done
    [[ $(command -v whiptail) ]] || yum install --skip-broken -y newt
fi
############################
printf "%s\n" "Automatically configure zsh after 2 seconds,you can press Ctrl + C to cancel."
#printf "%s\n" "2s后将自动开始配置zsh，您可以按Ctrl+C取消，这将不会继续配置其它步骤，同时也不会启动Tmoe-linux工具。"
################
################
slackware_mirror_list() {
    LINUX_DISTRO='slackware'
    sed -i 's/^ftp/#&/g' /etc/slackpkg/mirrors
    sed -i 's/^http/#&/g' /etc/slackpkg/mirrors
    sed -i '$ a\https://mirrors.bfsu.edu.cn/slackwarearm/slackwarearm-current/' /etc/slackpkg/mirrors
    cat /etc/slackpkg/mirrors
    slackpkg update gpg
    slackpkg update
}
###################
if [ "$(grep 'ID=' /etc/os-release | head -n 1 | cut -d '=' -f 2)" = "slackware" ]; then
    slackware_mirror_list
    slackpkg install newt
fi
note_of_non_debian() {
    case ${TMOE_LANG} in
    zh_*UTF-8) printf "%s\n" "您可以输${GREEN}debian-i${RESET}或${YELLOW}tmoe t${RESET}来打开软件安装工具" ;;
    *) ;;
    esac
    printf "%s\n" "You can type ${GREEN}debian-i${RESET} or ${YELLOW}tmoe t${RESET} to start ${BLUE}tmoe tools.${RESET}"
    bash zsh.sh
}
################
regen_dns_conf

if ! grep -Eq 'debian|ubuntu' '/etc/os-release'; then
    note_of_non_debian
else
    bash zsh.sh
fi
