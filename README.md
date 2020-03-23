# Eagle-Eye
**Eagle-Eye** is a bash script that displays system information such as:
- CPU && Hard Disk usage
- CPU Core && Hard Disk Partition temperatures
- Network Usage
- Most intensive CPU && Memory processes
- Uptime, Kernel, Used Memory and Uptime

![Script Image Preview](https://gitlab.com/JellyPi101/eagle-eye/-/raw/master/eagle_eye.png)

# Usage
In order to see all the available options you can execute: `sudo ./eeye -h`
- **i** -- Show system information
- **u** -- Show usage (cpu, hard disk partitions)
- **s** -- Show status of the provided services. Services need to be separated by a comma and without spaces (e.g: nginx,tor,sshd,mongodb)
- **t** -- Show temperatures (CPU Cores, Partitions)
- **p** -- Show processes

***Show System Information + Temperatures***\
`sudo ./eeye -i -t`

***Show Service's Status + Show processes + Usage***\
`sudo ./eeye -s nginx,sshd -p -u`


# Setting it up
1. Once you deploy your server, you ca simply `git clone https://gitlab.com/JellyPi101/eagle-eye.git`
2. Then copy the script into your custom scripts path (for me that's `~/.scripts`): `cp eagle-eye/eeye ~/.scripts`
3. Add it to your `.bashrc`: `sudo eeye -i -u -s sshd,nginx,ntpd -p`
4. Change your `/etc/sudoers` file, with `visudo`, and add `%<your_group> ALL=(ALL) NOPASSWD: /home/<your_user>/.scripts/eeye`
