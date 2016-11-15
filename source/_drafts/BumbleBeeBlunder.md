---
title: BumbleBeeBlunder
tags:
---

TODO: Below is copy-pasta from wordpress.




tl:dr I tried to install Bumblbee on Ubuntu 15.10, messed up, fixed the mistake, back to square one.





So today I attempted to install Bumblebee onto my laptop. Before we begin, here are the relevant specs of my laptop.

Model: Lenovo Y50
OS: Ubuntu 15.10
Video: Integrated Intel and discrete NVIDIA card
The reason why mostly revolves around power consumption. My laptop has two video devices in it, the integrated one in the Intel CPU and the discrete NVIDIA card. With Bumblebee, the graphics card would only be used when called upon by running the command

[bash]optirun program-to-be-run-on-NVIDIA-card [/bash]
thus saving lots of power by not constantly running the NVIDIA card and increasing battery life. In my case over an hour!

Now, getting into this, I knew there were risks and on top of that, there were signs that this wouldn't work. Upon doing some online searching (aka Google) it was easy to see that the general internet public viewed Bumblebee as old and to be depreciated. But that did not stop me, I had previously used Bumblebee on this laptop for an older version and it was awesome! I wanted the joy of a longer battery life to come back. Later in this post I will bring this point back up along with what one should use instead of Bumblebee for scenarios like mine. However, probably the biggest sign was that nobody else on the internet seemed to get Bumblebee up and running on a newer NVIDIA card running on Ubuntu 15.10. This is the moment where I should have stopped. But alas, I did not, and I moved on to the installation.



Installing Bumblebee

For the most part I followed the instructions from the top answer to this question on askubuntu.com. In case that link ever changes or otherwise becomes invalid, and for simplicity, I will reiterate what I did below.

Before installing, I had to remove any packages that might interfere the installation.

[bash]sudo apt-get remove --purge nvidia*
sudo apt-get --purge remove xserver-xorg-video-nouveau[/bash]
Note: If one had already installed a version of bumblebee that would need to be removed as well

Now for some preliminary installs to make sure all the required headers are installed

[bash]sudo apt-get install linux-source
sudo apt-get install linux-headers-$(uname -r)[/bash]
Then, blacklist nouveau and nvidia drivers that could cause problems, but first I backed up the files of course!

[bash]
sudo cp /etc/modprobe.d/blacklist.conf /etc/modprobe.d/blacklist.conf.bak
sudo vim /etc/modprobe.d/blacklist.conf
[/bash]
Append these lines to the end of the file:

[code]
# Necessary to install nvidia drivers
blacklist nouveau
blacklist lbm-nouveau
blacklist nvidia-173
blacklist nvidia-96
blacklist nvidia-current
blacklist nvidia-173-updates
blacklist nvidia-96-updates
alias nvidia nvidia_current_updates
alias nouveau off
alias lbm-nouveau off
options nouveau modeset=0
[/code]
then save and exit.

Before continuing I brought everything up to speed.

[bash]
sudo apt-get update &amp;amp;amp;amp;&amp;amp;amp;amp; sudo apt-get dist-upgrade -y
[/bash]
It was at this point things got interesting. To continue, I was going to have to stop lightdm so I had to move to working in tty1

Note: tty1 is accessible by pressing CTRL+ALT+F1

After logging in to the terminal I proceeded to stop the lightdm service and to start installing the nvidia packages.

[bash]
sudo service lightdm stop
sudo apt-get install nvidia-352-updates nvidia-settings
[/bash]
Now, with the latest NVIDIA drivers, the installation also installs nvidia-prime which is supposed to automatically switch between the integrated Intel video device and the NVIDIA discrete graphics card. This means no user control and that both cards are always on. This means that I would not be able to decrease my laptop's power consumption.

So in order for Bumblebee to work, and since I had no intention of using nvidia-prime I removed it from the system.

[bash]
sudo apt-get remove --purge nvidia-prime
[/bash]
And now to add to the PPA for Bumblebee and to install it along with virtualgl packages.

[bash]
sudo add-apt-repository ppa:bumblebee/stable
sudo apt-get update
sudo apt-get install bumblebee bumblebee-nvidia virtualgl virtualgl-libs virtualgl-libs-ia32:i386 virtualgl-libs:i386
[/bash]
Now that Bumblebee is installed, I added my account to the bumblebee group so I could use it

[bash]
sudo usermod -a -G bumblebee $USER
[/bash]
and then reboot.

Once I go back into the system, I had to modify some configuration files. So first, I went to their location and backed them up.

[bash]
cd /etc/bumblebee
sudo cp bumblebee.conf  bumblebee.conf.bak
sudo cp xorg.conf.nvidia xorg.conf.nvidia.bak
[/bash]
For the next part, I am just going to quote from the source mentioned at the top of this post.

Then, let's go to modify the first file with sudo gedit bumblebee.conf, adding (all without quotes)

[bumblebeed] section: after "Driver=" insert "nvidia"
[nvidia-driver] section: after "KernelDriver=" insert "nvidia-XXX-updates"
[nvidia-driver] section: after "LibraryPath=" insert "/usr/lib/nvidia-XXX-updates, /usr/lib/nvidia-331-updates:/usr/lib32/nvidia-XXX-updates"
[nvidia-driver] section: after "XorgModulePath=" insert "/usr/lib/nvidia-XXX-updates/xorg,/usr/lib/xorg/modules"
Assure that the "XorgConfFile" under [nvidia-driver] is equal to "/etc/bumblebee/xorg.conf.nvidia" (again, without quotes), then save and close gedit.

Now we have to edit the other file with sudo gedit xorg.conf.nvidia (in this case we have to insert the quotes also!!). Replace Option "ConnectedMonitor" "DFP" with Option "UseDisplayDevice" "none", save and exit.

8. Run gedit /etc/modprobe.d/bumblebee.conf and make sure that all the lines containing blacklist <something> are not commented (i.e. they don't start with #).

Then I ran this command:

[bash][/bash]
sudo service bumblebeed start

[bash][/bash]
and this is where the error began...

The problem

After this command, I did not get a response back like I was to expect, error or otherwise. And upon running this command,

[bash]
service --status-all | grep bumblebeed
[/bash]
The service wasn't showing as on, and nothing I could do would fix that.
I also tried just running a program to be sure

[bash]
optirun glxspheres
[/bash]
and I got this error:

[code]
[ERROR]The Bumblebee daemon has not been started yet or the socket path /var/run/bumblebee.socket was incorrect.
[ERROR]Could not connect to bumblebee daemon - is it running?
[/code]
So I did what seemed logical and rebooted my laptop and that's when things went from bad to worse.

Upon starting back up, instead of being greeted with the Ubuntu login screen, the startup decided to hang up on this line:

[code]
Starting Light Display Manager ... and deal with any system changes ..
[/code]
And it was at this point, I decided it was time to backtrack and just get my laptop back to working again. Especially cause I had class in an hour and I needed to be able to take notes.

The Solution

First, I reinstalled xorg and lightdm.

The first part was accomplished by going back to tty1 terminal and running these commands:

[bash]
sudo apt-get purge xorg lightdm
sudo apt-get autoremove
sudo apt-get install xorg lightdm
[/bash]
Upon a reboot I removed all traces of NVIDIA and Bumblebee.

[bash]
sudo apt-get purge nvidia* '^bumblebee.*'  
[/bash]
After another reboot, I reinstalled the stable NVIDIA proprietary drivers

[bash]
sudo apt-get update
sudo apt-get install nvidia-352 nvidia-prime
[/bash]
One final reboot and everything was back to the way it was before this little adventure.

In Conclusion

Well this was a very frustrating exercise, but lesson be learned, wait for it to be tested/verified before installing it.
I have reinstalled nvidia-prime and until I find an option that will work and allow me to keep my discrete card off when not in use, this will be my option.

I hope this post helps others who get into this situation fix their computer and get back on with their lives.
