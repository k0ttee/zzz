iso_name='alpine-virt-3.19.0-x86_64'
disk_size='10G'




brew update
brew install qemu

mkdir -p ~/QEMU/ISO/
mkdir -p ~/QEMU/QCOW2/

cp ~/Downloads/${iso_name}.iso ~/QEMU/ISO/${iso_name}.iso
qemu-img create -f qcow2 ~/QEMU/QCOW2/${iso_name}.qcow2 ${disk_size}




#############
# установка #
#############

qemu-system-x86_64 -cpu host \
-machine type=q35,accel=hvf \
-smp 1 -m 1G \
-display none -serial stdio \
-k us \
-hda ~/QEMU/QCOW2/${iso_name}.qcow2 \
-cdrom ~/QEMU/ISO/${iso_name}.iso

setup-alpine
sync
reboot




########
# пуск #
########

qemu-system-x86_64 -cpu host \
-machine type=q35,accel=hvf \
-smp 1 -m 1G \
-display none -serial stdio \
-hda ~/QEMU/QCOW2/${iso_name}.qcow2
