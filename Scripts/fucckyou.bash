#!/bin/bash
#/usr/bin/bindbackup.sh
#
# Backup /etc/bind daily (crontab running @ 2am)
# There's a service running on ctilabcwcc01.cti.lab to rip into D:\GCTI\backups\DNS\
#
# Obligatory 'created by Thomas Blakely (thomas.blakely@vodafone.com)'
#
# If running manually, ensure you create 
########################

#VaryingVariables
	varD=$(date +%F-%T)
	varT=/tmp/backups/bind_$varD.tar
	varB=/etc/bind/
	varP=$(echo "$varT" | awk 'BEGIN {FS="_"}{gsub(".tar", "");print $2}')
	
		
#FunFunFunctions
function funTime {
	if [[ ( $varP < $varD ) ]];  then 
		echo 'yes'
		echo 'varT: $varT'
	else 
		echo 'no'
		echo 'varD: $varD'
	fi
}

function funBackup {
	echo 'beginning backup of /etc/bind'
	tar -cvf $varT $varB
	echo 'gzipping $varT'
	gzip $varT
	echo 'complete'
	exit
}

##########################

#QualityControl
if [[ -f $varT ]] || [[ -f $varT.gz ]] ; then
    echo 'already exist!' ;; goto $funTime
	exit
else
	echo 'time to create!' ;; goto $funBackup
fi


########################


if [[ -f $varT ]]; then
    echo 'hey!'
else
	echo 'yo'
fi


#    tar -uvf my.tar file1 file2 file_new
    gzip -fk my.tar  # This keeps a copy of the tar.
    # -f --force overwrite existing .tar.gz
    # -k --keep Keep the input file (.tar file)
else
    tar -cvzf my.tar.gz file1 file2
fi