#! /bin/sh

VarArray=(gctiboot DBServer ConfigServer GenesysLCA FlexLM)
VarLogFile='/opt/GCTI/logs/scripts/gctiboot_initd.log'
VarStartScript=$(echo "$stArray started at $(date '+%X on %x')" >> $VarLogFile)
VarStopScript=$(echo "$spArray stopped at $(date '+%X on %x')" >> $VarLogFile)

case "$1" in
'start')
	
	for stArray in "${VarArray[@]}"
		do 
			echo $stArray
		done 
	
### start DBserver
		echo $VarStartScript
        cd /opt/GCTI/dbs/
        ./multiserver -host ctilabtrfw3 -port 2020 -app cfg_dbserver &

### start Confefe Server
        echo $VarStartScript
        cd /opt/GCTI/cs/
        ./confserv &

### run Genesys LCA
        echo $VarStartScript
        cd /opt/GCTI/lca/
        ./lca 4999 &

### run flexlm licence manager
#       if [ -f "/opt/GCTI/flexlm/licence.dat" ] then
#               echo "Starting license server"
#               cd /opt/GCTI/flexlm/
#               ./run.sh
#       fi
;;

'stop')

	for (( spArray=${#ARRAY[@]}-1; i>=0; i-- ))
		do
			echo ${ARRAY[$spArray]}
		done
# Stop FlexLM
		echo $VarStopScript
        pkill lmgrd
# Stop the lca
        echo $VarStopScript
        pkill lca
# Stop Confefe Server
        echo $VarStopScript
        pkill confserv
# Stop DBServer
        echo $VarStopScript
        pkill multiserver
# All is stopped
		echo $VarStopScript

;;

*)
        echo "Usage: $0 { start | stop}"
        exit 1
;;

esac
exit 0    