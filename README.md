# parallels-overlay
Gentoo Portage Overlay to install parallels-tools.

## Steps to install

1. Mount the Parallels Guest Tools CD at /mnt/cdrom
2. Run scripts/import-parallels-tools.sh which imports the important files from the guest tools into /usr/portage/distfiles
3. Emerge sys-kernel/parallels-tools for the kernel modules and sys-apps/parallels-tools for the user space applications

## Usage

I have to admit my requirement was having OpenGL natively (non-remote) on my VM, 
as I found out that when using remote X11 connections the OpenGL version degrades from 2.1 to 1.4 
which wasn't sufficient for the application I wanted to run. So after installing these two packages, 
this is how I would start X11 on my machine:

2. Xorg &
3. export DISPLAY=:0
4. wm2 &
5. prlcc &

The /etc/init.d line starts the tools daemon and loads the kernel modules. Xorg gets you the X-Server. 
Setting the DISPLAY variable makes in your current shell known where X is available. 
wm2 is my favorite window manager for minimal setups like this one. prlcc gets you the mouse and changing resolution 
when you change the VM's window size. Without prlcc you won't have a mouse at this stage.
