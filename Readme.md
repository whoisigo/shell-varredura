Antes de executar o script, certifique-se de configurar o arquivo que irá registrar os logs.

1) Em /etc/rsyslog.d crie um arquivo por exemplo "script.conf", e o edite com a seguinte configuração de facility/priority:
	local0.* 	/var/log/script.log
2) Em /var/log crie o arquivo script.log;
3) Defina as permissões adequadas > "640 (-rw-r-----)";
4) Mude o proprietário > chown root:adm script.log; 
