由于平时频繁配置Linux系统，很多软件和配置要搞经常浪费时间，因此写个shell脚本希望能够通过菜单选项的方式快捷地进行安装和配置

# 配置方面：
1. 查看一系列系统信息
2. 快速创建一个包含sudo权限的用户
3. 更改apt和pio的源为清华源，提高下载速度
4. 重启网络，用于虚拟机中Ubuntu偶尔断网的现象
5. 配置Git，主要完成添加密钥到GitHub的操作
6. 切换python版本，主要是通过修改软链接来切py2与py3（前提是你系统里得 两个版本的python）

# 安装方面：
1. 安装用于支持32位程序的各种东西
2. pwntools（目前还是基于python2安装的，python3的还不太完善，装起来总有bug）
3. pwnGDB+pwndbg
4. onegadget
5. angr（8的版本，基于虚拟化的python3环境）
6. afl-fuzz

输入如下命令即可使用：

wget https://raw.githubusercontent.com/23R3F/linux_kits/master/linux_kits.sh && chmod u+x ./linux_kits.sh && ./linux_kits.sh
