



case "$1" in
'start')
	echo "gctiservices script started at $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
### start DBserver
		echo "started DBServer @ $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
		cd /opt/GCTI/dbs/
		./multiserver -host ctilabtrfw3 -port 2020 -app cfg_dbserver &

### start Confefe Server
		echo "Starting Config Server"
		cd /opt/GCTI/cs/
		./confserv &

### run Genesys LCA
		echo "Starting LCA"
		cd /opt/GCTI/lca/
		./lca 4999 &

### run flexlm licence manager
#	if [ -f "/opt/GCTI/flexlm/licence.dat" ] then
#		echo "Starting license server"
#		cd /opt/GCTI/flexlm/
#		./run.sh
#	fi

	;;

'stop')

	echo "gctiservices stopped at $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
# Stop the lca
		echo "Stopping LCA... at $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
		pkill lca
# Stop DBServer
		echo "Stopping DBServer at $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
		pkill multiserver
# Stop Confefe Server
		pkill confserv
# Stop flexlm
		echo "Stopping flexlm... at $(date '+%X on %x')" >> /opt/GCTI/logs/scripts/gctiboot_initd.log
		pkill lmgrd
	;;

*)
		echo "Usage: $0 { start | stop}"
		exit 1
		;;
esac
exit 0
