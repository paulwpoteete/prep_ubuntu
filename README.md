# prep_ubuntu
```
Prepare a RPi 3 for production use running Ubuntu 20.04

This script will auto-configure a base installation of Ubuntu 20.04 on a Raspberry Pi Model 3x for production use.

These options are entirely based on my opinion, and may or may not be suitable for your particular needs.
There is no warranty of any kind.
```
## What you need:
```
  A RaspberryPi
  An image of Ubuntu 20.04 for the RPi
  An Internet connection
```
## Part I: Download Ubuntu 20.04 and Image your pi
```
  http://cdimage.ubuntu.com/ubuntu/releases/20.04/release/ubuntu-20.04-preinstalled-server-armhf+raspi.img.xz
  or
  http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz

  dd if=ubuntu-20.04-preinstalled-server-arm64+raspi.img of=/dev/YOURSDCARD status=progress
```
## Part II: Start your pi (keyboard and screen required)
```
  Login: ubuntu/ubuntu
  sudo to root and type: bash -c "$(curl http://public.cybernados.net/pub/prep_ubuntu/prep_ubuntu.sh)"
```
