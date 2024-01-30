KEYMAPOPTS="us us"
HOSTNAMEOPTS=auth

#содержимое /etc/network/interfaces
INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
"

TIMEZONEOPTS="UTC"
PROXYOPTS=none
APKREPOSOPTS="-c -f"

USEROPTS=none
#USEROPTS="-a -u -g audio,video,netdev juser"

#USERSSHKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIiHcbg/7ytfLFHUNLRgEAubFz/13SwXBOM/05GNZe4 juser@example.com"
#USERSSHKEY="https://example.com/juser.keys"

SSHDOPTS=openssh

#ROOTSSHKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIiHcbg/7ytfLFHUNLRgEAubFz/13SwXBOM/05GNZe4 juser@example.com"
#ROOTSSHKEY="https://example.com/juser.keys"

NTPOPTS=none

#sys без swap
DISKOPTS="-m sys -s 0 /dev/sda"
