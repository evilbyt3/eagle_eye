#!/bin/bash
#	 ___________	
#   |.---------.|		Contact
#   ||         ||		-------
#   || JellyPi ||			Website:	
#   ||         ||			Gitlab : https://gitlab.com/JellyPi101
#   |'---------'|
#	`._________.'		Description
#	   |	 |			-----------
#	  /		  \				
#   .-		   -.  			
#  /		 	 \ 			Options 
#  |			 |				
#  |			 |				
#  |			 |
#  |			 |



#### FUNCTIONS ####

function usage() {
	printf "  Usage: $script_name <options>\n\t-i -- Show system information\n\t-u -- Show usage (cpu, hard disk partitions)\n\t-s -- Show status of the provided services. Services need to be separated by a space (default: nginx, tor, sshd, mongodb)\n\t-t -- Show temperatures (CPU Cores, Partitions)\n\t-p -- Show processes\n"
}

# This function displays a basic overview of your system
# such as: Distribution, kernel version, processes, memory, etc
function display_system_info() {
	# Distro
	distro=$(cat /etc/*release | grep PRETTY_NAME | cut -d "=" -f 2- | sed 's/"//g')

	# Kernel
	kernel=$(uname -sr)

	# Uptime
	uptime=$(uptime -p)

	# Load
	load=`cat /proc/loadavg | awk '{ print $1,$2,$3,$5 }'`

	# Processes
	procs=`ps -eo user | sort | uniq -c | awk '{print $2 " " $1}'`
	proc_root=`echo "$procs" | grep root | awk '{print $2}'`
	proc_user=`echo "$procs" | grep -v root | awk '{print $2}' | awk '{ SUM += $1} END { print SUM }'`
	proc_all=`echo "$procs" | awk '{print $2}' | awk '{ SUM += $1} END { print SUM }'`

	# CPU
	CPU=`grep "model name" /proc/cpuinfo | cut -d ' ' -f3- | head -1`

	# Memory
	IFS=" " read total used free <<<$(free -htm | grep "Mem" | awk {'print $3,$4,$2'})

	echo -e "${BOLD}${YELLOW}system info:${RST}\n
  Distro....:	$distro
  Uptime....:	$uptime
  Kernel....:	$kernel

  Load......:	$load
  Processes.:	${GREEN}$proc_all${RST} (total)	${GREEN}$proc_root${RST} (root)	${GREEN}$proc_user${RST} (user)

  Memory....:	${GREEN}$total${RST} (total)	${GREEN}$used${RST} (used)	${GREEN}$free${RST} (free)
  CPU.......:	$CPU\n"
}



#### GLOBAL VARIABLES ####

# Colors
RST=`tput sgr0`
RED=`tput setaf 1`
BOLD=`tput bold`
GREEN=`tput setaf 2`
BLACK=`tput setaf 0`
WHITE=`tput setaf 7`
YELLOW=`tput setaf 3`
dim="\e[2m"
undim="\e[0m"

# Bools
sprocs=0
snet=0
susage=0
sinfo=0
stemp=0
services=(nginx sshd tor mongodb)

# Config
script_name=$0
no_args=1

# Main
#	-p -- show procs
#	-n -- network
#	-u -- usage (cpu, hard)
#	-t -- temperature
#	-i -- sys info
#	-s -- services
#	
#	Default everything is turned on and services are: nginx, sshd, tor, mongodb


# stat -p (shows only procs)


while getopts ":pnuis:h" opts; do
	case "${opts}" in
		p) sprocs=1;;
		n) snet=1;;
		u) susage=1;;
		i) sinfo=1;;
		s) services=${OPTARG};;
		t) stemp=1;;
		h) usage && exit;;
		*) usage && exit;;
	esac
	no_args=0
done

[ $sinfo -eq 1 ] && display_system_info
# [ -n $sprocs ] && 
