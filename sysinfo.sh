#!/bin/bash



function pause(){

	message="Press [Enter] key to continue..."

        read -p "$message" enterKey

}



function tulisHeader(){

	echo "-------------------------------"

	echo "   $@"

	echo "-------------------------------"

}



function systemInfo(){

	tulisHeader "System Status"

	echo "Username : $(uname)"

	echo "OS : $(uname -mrs)"

	uptime | awk -F '( |,|:)+' '{print "Uptime :",$6":"$7",",$8}'

	ip addr show eth0 | head -n3 | tail -n1 | awk '{print "IP : "$2}'

	echo "Hostname : $(hostname -a)"

	pause

}



function hwList(){

	tulisHeader "Hardware List"

	echo "Machine Hardware : $(uname -m)"

	sudo lshw -short

	pause

}



function CPUDetail(){

	tulisHeader "CPU"

	lscpu | grep 'Model name'

	lscpu | grep 'CPU MHz' | awk -F '( |:)+' '{print "Frequency :           ",$3}'

	lscpu | grep 'L3' | awk -F '( |:)+' '{print "Cache     :           ",$3}'

	pause

}



function blkDetail(){

	tulisHeader "blk"

	lsblk

	pause

}



function hwDetail(){

	while true

	do

		clear

		echo "========================"

		echo "    Hardware Detail"

		echo "========================"

		echo "1. CPU"

		echo "2. Block Devices"

		echo "3. back"

		read -p "Chose [ 1 - 3 ] : " d

		case $d in

			1) CPUDetail; break;;

			2) blkDetail; break;;

			3) break;;

		esac

	done

}



function memory(){

	tulisHeader "MEMORY"

	echo "************"

	echo "   Memory"

	echo "************"

	free -m | awk '{print "Size :", $2, "mb"}' | head -n2 | tail -n1

	free -m | awk '{print "Free :", $4, "mb"}' | head -n2 | tail -n1

	echo "****************************"

	echo "     Memory Statistics"

	echo "****************************"

	vmstat

	echo "****************************************"

	echo "         Top 10 eating process"

	echo "****************************************"

	ps aux --sort=-%cpu | head -n 10

	pause

}



while true

do

	clear

	date

	echo "======================"

	echo "    Main Menu"

	echo "======================"

	echo "1.Operating System Info"

	echo "2.Hardware List"

	echo "3.free and Used Memory"

	echo "4.Hardware Detail"

	echo "5.exit"

	read -p "Chose [ 1 - 5 ] : " c

	case $c in 

		1) systemInfo ;;

		2) hwList;;

		3) memory;;

		4) hwDetail;;

		5) echo "Bye Bye...."; exit 0;;

	esac

done
