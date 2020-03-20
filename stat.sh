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


#### GLOBAL VARIABLES ####

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

# [ $sinfo -eq 1 ] && display_system_info
# [ -n $sprocs ] && 
