#!/usr/bin/env bash

# INSTALL.sh
#
# Instalador do Programa fix-rn-project, este instalador escrito em Shellscript
# fará a instalação do programa para facilitar seu uso, o mesmo precisará de
# permissão sudo para execução de alguns comandos.
#
# Versão 211228 : Criado recrusos fundamentaais de uso:
#		 -h ou --help : lista os comando de uso
#		 -i ou --install : instala o programa fix-rn-project
#		 -v ou --version : mostra a versão atual do instalador
#		 -a ou --autor : mostra o autor do software
#		 -b ou --bornin : mostra a data de criação do software
#
# Autor: Fabio Carneiro, 28 de Dezembro de 2021

DIR_INSTALL="/home/$USER/.fc-software"
DIR_SOFTWARE="$DIR_INSTALL/fix-rn-project"
PATH_SOFTWARE="$DIR_SOFTWARE/fix-rn-project.sh"
PATH_LINK="/usr/bin/fix-rn-project"
ARG_NAME="$1"
DIR_RES="$DIR_SOFTWARE/res"


case $ARG_NAME in
	-h | --help )
		clear
		echo
		echo " $(basename "$0")"
		echo
		less $DIR_RES/INSTALL.txt
		echo
	;;

	-i | --install )
		if [[ ! -d "$DIR_INSTALL" ]]
		then
			clear
			echo
			echo "Processo de instalação iniciado!"
			echo "Para confirmar digite ( Sim! ) no console:"
			echo
			echo -n "console ~$  "
			read OPC
			sleep 1
			if [[ "$OPC" == "Sim!" ]]
			then
				mkdir $DIR_INSTALL
				mkdir $DIR_SOFTWARE
				cp -r * $DIR_SOFTWARE
				sudo ln -s $PATH_SOFTWARE $PATH_LINK
				echo
				echo "$(basename "$0")" Instalado com sucesso!
				sleep 1
			fi
		fi
		exit 0
	;;

	-v | --version )
		echo -n $(basename "$0")
		grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
		exit 0
	;;

	-a | --autor )
		echo -n $(basename "$0") 
		grep '^# Autor: ' "$0" | tail -1 | cut -d , -f 1 | tr -d \#
		exit 0
	;;

	-b | --bornin )
		echo -n $(basename "$0"), criado em 
		grep '^# Autor: ' "$0" | tail -3 | cut -d , -f 2 | tr -d \#
		exit 0
	;;

	-d | --dir )
		echo $(basename "$0") será instalado em:
		echo $DIR_SOFTWARE
	;;
esac
