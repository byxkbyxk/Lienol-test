#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
# sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

cat >$NETIP <<-EOF
uci set network.lan.ipaddr='192.168.88.1'                                    # IPv4 地址(openwrt后台地址)
uci set network.lan.netmask='255.255.255.0'                                 # IPv4 子网掩码
uci set network.lan.gateway='192.168.88.2'                                   # IPv4 网关
uci set network.lan.broadcast='192.168.88.255'                               # IPv4 广播
uci set network.lan.dns='61.132.163.68 202.102.213.68'                         # DNS(多个DNS要用空格分开)
uci set network.lan.delegate='0'                                            # 去掉LAN口使用内置的 IPv6 管理
uci commit network                                                          # 不要删除跟注释,除非上面全部删除或注释掉了
uci set dhcp.lan.ignore='1'                                                 # 关闭DHCP功能
uci commit dhcp                                                             # 跟‘关闭DHCP功能’联动,同时启用或者删除跟注释
uci set system.@system[0].hostname='OpenWrt-prodigal'                            # 修改主机名称为OpenWrt-123
EOF

sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile            # 选择argon为默认主题

sed -i "s/OpenWrt /${Author} compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ           # 增加个性名字 ${Author} 默认为你的github帐号

git clone https://github.com/sirpdboy/luci-app-advanced.git ./package/lean/luci-app-advanced
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git ./package/luci-theme-infinityfreedom
# git clone https://github.com/destan19/OpenAppFilter.git ./package/OpenAppFilter
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git ./package/lean/luci-app-jd-dailybonus
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/lean/openwrt-passwall
# https://github.com/messense/aliyundrive-webdav
git clone https://github.com/vernesong/OpenClash.git ./package/lean/luci-app-openclash
