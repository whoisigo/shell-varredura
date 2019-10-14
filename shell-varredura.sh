#!/bin/bash
#----------------------------------------------------------------------
#									  
# Autor: Igor Nobre					  
# Descrição: Script entra em diversos 
# 			 diretórios e remove arquivos mais antigos que 90 dias  	  
#									  
#----------------------------------------------------------------------
cd /tmp/teste
#Declaração de variáveis
#Exibe diretório atual
DIR=`pwd`

#Declarando a função que vai fazer execução ao chegar no LOOP.
function rabbit () {	
	cd ${LISTA[i]} #Entra no diretório do respectivo Palo Alto.
	
	#Declarando variáveis de controle.
	COUNT=`find * -type f -mtime +90 | wc -l`
	FILE=`find * -type f -mtime +90`
	if [[ $COUNT != 0 ]]; then
		echo "Existem arquivos mais antigos que 90 dias em $DIR/${LISTA[i]}." 
		echo "Iniciando a remoção..."
		rm -fv $FILE ; sleep 2
		echo "Saindo do diretório atual!" ; echo ""
		cd ..
	else
		echo "Não existem arquivos mais antigos que 90 dias em $DIR/${LISTA[i]}. Saindo do diretório atual!" ; echo ""
		cd ..
	fi			
}

if [[ $DIR != /tmp/teste ]]; then
	echo "Erro! Execução em diretório incorreto, saindo do script!" | tee -a >(logger -p local0.err -t [$0])
	exit 1
else
#Declarando variáveis
LISTA=(`ls -d pa-*`) #Criando o array que será usado para entrar nos diretórios.
LOOP=`ls -d pa-* | wc -l` #Definindo a quantidade de saltos que será usada no Loop.

#Entrando no diretório dos PAs.
echo ""
echo "=====Iniciando o script====="	| tee -a >(logger -p local0.warn -t [$0])
	for (( i = 0; i < $LOOP; i++ )); do
		#Chamando a função que fará a remoção dos arquivos antigos.
		rabbit | tee -a >(logger -p local0.warn -t [$0])
		sleep 2
	done
echo "=====Fim do script=====" | tee -a >(logger -p local0.warn -t [$0])
echo ""
fi