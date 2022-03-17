#! /bin/bash/

helper="Alphy"
versnum="1.0"

	alphy=$(zenity --list --checklist \
	--title="$helper $versnum" \
	--text="Please select the display manager(s) to install"
	"" "GDM3" \
	"" "KDM" \
	"" "LXDM" \
	"" "Ly" \
	"" "SDDM" \
	"" "tbsm" \
	"" "XDM")

	GDM=$(echo $alphy | grep -c "GDM3")
	KDM=$(echo $alphy | grep -c "KDM")
	LXDM=$(echo $alphy | grep -c "LXDM")
	LY=$(echo $alphy | grep -c "Ly")
	SDDM=$(echo $alphy | grep -c "SDDM")
	TBSM=$(echo $alphy | grep -c "tbsm")
	XDM=$(echo $alphy | grep -c "XDM")


	if [ $GDM -gt "0" ]; then
	sudo apt-get install gdm3 -y && \
	zenity --notification --text="GDM3 installed" || \
	zenity --notification --text="GDM3 could not be installed"
	fi

	if [ $KDM -gt "0" ]; then
	sudo apt-get install kdm -yy && \
	zenity --notification --text="KDM installed" || \
	zenity --notification --text="KDM could not be installed"
	fi

	if [ $LXDM -gt "0" ]; then
	sudo apt-get install lxdm -y && \
	zenity --notification --text="LXDM installed" || \
	zenity --notification --text="LXDM could not be installed"
	fi

	if [ $LY -gt "0" ]; then
	#clone repository
	git clone https://github.com/nullgemm/ly.git
	cd ./ly
	#make submodules
	make github
	#Compile
	make
	sudo make run
	#Install ly
	sudo make install && \
	zenity --notification --text="Ly installed" || \
	zenity --notification --text="Ly could not be installed"
	#enable ly
	sudo systemctl enable ly.service
		zenity --question --title="$helper $versnum" \
		--text="Would you like to dissable tty2?"
		if [ $? -eq "0" ]; then
		sudo systemctl disable getty@tty2.service
		else
		zenity --notification --text="tty2 can be disabled by entering 'sudo systemctl disable getty@tty2.service' from your terminal"
		fi
	fi

	if [ $TBSM -gt "0" ]; then
	git clone https://github.com/loh-tar/tbsm
	cd ./tbsm
	sudo make Makefile
	sudo make install && \
	zenity --notification --text="TBSM installed" || \
	zenity --notification --text="TBSM could not be installed"

	#trigger autostart?
	touch AS-tbsm.txt
	echo "#Auto start tbsm after login on first two VTs" >> AS-tbsm.txt
	echo "[[ $XDG_VTNR -le 2 ]] && tbsm" >> AS-tbsm.txt
	echo "tbsm doc man" >> AS-tbsm.txt
	echo "tbsm help" >> AS-tbsm.txt
	sudo cat AS-tbsm.txt >> /etc/bash.bashrc
	fi


	if [ $SDDM -gt "0" ]; then
	sudo apt-add-repository ppa:blue-shell/sddm
	sudo apt-get update
	sudo apt-get install sddm -yy && \
	zenity --notification --text="SDDM installed" || \
	zenity --notification --text="SDDM could not be installed"
	fi

	if [ $XDM -gt "0" ]; then
	sudo apt-get install xdm -y && \
	zenity --notification --text="XDM installed" || \
	zenity --notification --text="XDM could not be installed"
	fi
