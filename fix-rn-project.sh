#!/usr/bin/env bash
# fix-rn-project.sh
#
# corrige erro comum em projetos react native no linux
# Obs. corrige o erro "Unable to load script"
#
# Versão 1 : Implementado todas opções fundamentais de uso:
#		-h ou --help : mostra menu de ajuda e modo de uso
#		-v ou --version : mostra a versão atual do programa
#		-f ou --fix : faz a correção do projeto informado
#
# Versão 2 : Correção textuais, gramaticais e organizacionais
#           dos textos de ajuda.
#
# Versão 241221 : Mudada sistema de versionamento de numeral real
#	            para referência por data de modificação ex:
#                Versão 241221
#
# Versão 211225 : Musado sistema de versionamento de referência por
#				data de "diaMesAno" para "anoMesDia"
#
#				adicionado correções ao códigoe melhorias no
# 				funcionamento do programa.
#
# Versão 211228 : Adicionado opçoes:
# 				-a ou --autor para mostrar o autor do Software.
# 				-d ou --dir para mostrar o diretório do Software.
#
#				-b ou --bornin para mostrar a data de criação do
#				do Software.
#
# 				-r ou --remove para remover o programa do
# 				computador.
#
# Autor: Fabio Carneiro, 21 de Dezembro de 2021

DIR_INSTALL="/home/$USER/.fc-software"
DIR_SOFTWARE="/home/$USER/.fc-software/fix-rn-project"
DIR_RES="$DIR_SOFTWARE/res"
ARG_NAME="$1"
PROJECT_NAME="$2"
DIR_PATH="android/app/src/main/assets"

case $ARG_NAME in
    -h | --help )
        clear
		echo
        echo "	$(basename "$0")"
        echo
        less $DIR_RES/HELP.txt
    ;;

    -f | --fix )
    	if [[ ! -d "$PROJECT_NAME" ]]
        then
        	echo
        	echo "O diretório de projeto $PROJECT_NAME não existe"
        	echo
        	exit 1
		elif [[ "$PROJECT_NAME" == "$PROJECT_NAME/" ]]
        then
        	clear
        	echo
        	echo " NÃO ACRESCENTE BARRA \"/\" AO FINAL DO NOME DO DIRETÓRIO DO PROJETO "
        	echo
        	echo "$HELP_MESS"
        	echo
        	exit 1
        elif [[ -d "$PROJECT_NAME" && ! -d "$PROJECT_NAME/$DIR_PATH" ]]
        then
        	cd $PROJECT_NAME
			mkdir $DIR_PATH
        	npx react-native bundle --platform android --dev false \
        		--entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle \
        		--assets-dest android/app/src/main/res
        	clear
        	echo
            echo "	Correção realizada com sucesso para o projeto $PROJECT_NAME"
            echo
            exit 0
        else
        	clear
        	echo
            echo "	Correção já aplicada para o projeto $PROJECT_NAME"
            echo
            echo "$HELP_MESS"
            exit 0
        fi
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
    	echo $DIR_SOFTWARE
    	exit 0
    ;;

    -r | --remove )
    	if [[ -d "$DIR_SOFTWARE" ]]
    	then
    		echo "Diretório encontrado, quer realmente excluir o programa?"
    		echo "Para confirmar a exclusão digite ( Sim! ) no console:"
    		echo
    		echo -n "console ~$  "
    		read OPC
    		if [[ "$OPC" == "Sim!" ]]
    		then
    			sleep 1
    			rm -r $DIR_INSTALL
    			sudo rm -r /usr/bin/fix-rn-project
    			echo "Diretório deletado com sucesso!"
				echo
			fi
		else
			echo "Diretório não encontrado ou não existe!."
		fi
	;;

    * )
        if [[ -n "$ARG_NAME" ]]
        then
            clear
            echo
            echo "	Opção inválida: $ARG_NAME"
	    echo
            echo "$HELP_MESS"
            exit 1
        elif [[ -z "$ARG_NAME" ]]
        then
        	clear
        	echo
        	echo "	Opção vázia "
        	echo
        	echo "$HELP_MESS"
        	exit 1
        fi
    ;;
esac
