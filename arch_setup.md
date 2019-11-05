# Remove Old Partitions

- Use gparted to remove windows or everything else: `https://gparted.org/`
- Make it bootable (use your iso and device): `sudo dd bs=4M if=gparted-live-1.0.0-5-i686.iso of=/dev/sdc status=progress`
- Start GParted, you may have to select a keyboard etc. and remove all windows partitions. **Don't remove the EFI partition!**


# Start

- Download current arch iso: https://www.archlinux.org/download/
- Make a usb stick bootable (linux command on device sdc and image of 2019.10.01):`sudo dd bs=4M if=archlinux-2019.10.01-x86_64.iso of=/dev/sdc status=progress`
- **Make sure secure boot is disabled on the machine you try to install arch!**
- Boot arch from the usb device.


# After Booting

- After successfully booting you should see something like:
```
Arch Linux 5.3.1-arch1-1-ARCH (tty1)

archiso login: root (automatic login)

root@archiso ~ #
```

- First of all, keyboard layout is English, switch it by typing `loadkeys de-latin1` (if you want a german layout).
- Now we have to make space for the arch installation. The current partitions can be displayed with `lsblk` or with a more detailed list `blkid` .
- Create partitions with (in my case) `fdisk /dev/nvme0n1`
- Create label `p_arch` for the first partition: `mkfs.ext4 -L p_arch /dev/nvme0n1p1`
- Create label `p_swap` for the swap partition: `mkswap -L p_swap /dev/nvme0n1p2`
- Mount the root partition: `mount -L p_arch /mnt`
- Turn on the swap partition: `swapon -L p_swap`
- Connect to internet (via wifi) with `wifi-menu`, this guides you through setting up the connection.

# Installing the Base-System

- Selecting the correct mirror for the installation:
```
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
nano /etc/pacman.d/mirrorlist
```
    Removing all mirrors in nano with `strg + k` until the preferred mirror is on top. Save with `strg + o` and leave with `strg + x`
- Install base packages: `pacstrap /mnt base base-devel linux linux-firmware nano`
    - base: Metapaket for a minimal system
    - base-devel: Group of packages to build packages
    - linux: arch base kernel
    - linux-firmware: Firmware for different hardware
    - nano: Basic text editor

- Install further packages:
    - Bash completion: `pacstrap /mnt bash-completion`
    - CPU microcode:
        - Intel: `pacstrap/mnt intel-ucode`
        - AMD: `pacstrap/mnt amd-ucode`
    - For wifi: `pacstrap wpa_supplicant netctl dialog`

- Create `fstap` to create the file tree: `genfstab -Up /mnt > /mnt/etc/fstab`
- Control if file tree was created by printing it with `cat /mnt/etc/fstab`. It should look similar to this:
```
UUID=3eb2e7eb-1ef2-464f-8783-f888d4f630f2 / ext4  rw,relatime,data=ordered  0 1
UUID=67bed99b-1f51-42a5-8e32-35046df4f66e none  swap  defaults  0 0
```
- Change to the Os in `/mnt/` with `arch-chroot /mnt/`.



# Configure System Files

- Name of the computer (replace `myhost`): `echo myhost > /etc/hostname`
- Set the language (here english): `echo LANG=en_GB.UTF-8 > /etc/locale.conf` (german is `de_DE.UTF-8`)
- Remove the `#` in front of the preferred language in `/etc/locale.gen` to install that language, means from:
```
#de_DE.UTF-8 UTF-8
#de_DE ISO-8859-1
#de_DE@euro ISO-8859-15
#en_US.UTF-8 UTF-8
#en_US ISO-8859-1
```
- Generate locales: `locale-gen`
- Set keyboard layout and font:
```
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf
```
- Set timezone by linking to it: `ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime`
- Configuration of hosts. Use nano to set `nano /etc/hosts`:
```
#<ip-address> <hostname.domain.org> <hostname>
127.0.0.1 localhost.localdomain localhost
::1   localhost.localdomain localhost
```
- Enable the use of 32 bit package on 64 bit machines:
    - Remove the following lines from `/etc/pacman.conf`:
        ```
        [multilib]
        Include = /etc/pacman.d/mirrorlist
        ```
    - Load new repositories: `pacman -Sy`

- Create Initramfs: `mkinitcpio -p linux`
- Create root password: `passwd`
- Install bootloader, we use `systemd-boot` (https://wiki.archlinux.org/index.php/Systemd-boot) since it comes with linux and does not need further packages


## Notes

- If linuz-linux cannot be loaded do chroot from the stick and again install linux on the mounted system

# Furhter Steps

- Set up the wifi by enabling the NetworkManager with `systemctl enable NetworkManager`
- Install a DE
    - E.g. Budgie: https://wiki.archlinux.org/index.php/Budgie
    - To permanently start with the DE enable sddm (needs installation fist): `systemctl enable sddm`
    - Configure as you wish (it is highly configurable!!!)
- Install fish as shell for bash completion in the terminal etc. and tmux for terminal multiplexing
- Configure tmux with powerline and custom shortcuts etc. (you can use the most from github.com/schalkdaniel/ubuntu_setup)

# Compile R

- Install `gcc` and `gcc-fortran` as well as `textlive-full`
- Create a directiory for the installation, e.g. `~/R_source/`
- Download the source files and extract them in this directory
- cd into the R-xxx directory and run `./configure` then run `make`