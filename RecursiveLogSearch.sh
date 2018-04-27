#!/bin/bash


FuncDirect() {
	echo "Enter directory of logs you wish to look under"
	read -r VarDirect
	}

FuncDate() {
	echo "Enter date range per log format (per your requirements), i.e. *20180404_1*"
	read -r VarDate
	}


ArrStrings=( "OOPS" "Error GVP Port" "Disconnect the call requested by VIS" "PlayApplication Error" "Exit VHT Outbound" "Default Route occured target was" )

FuncDirect
FuncDate

cd "$VarDirect" || return

for i in "${ArrStrings[@]}"; do 
	echo "'$i'" '*'"$VarDate"'*'
	gzgrep "$i" *"$VarDate"*
done

	
# for i in "${ArrStrings[@]}"; do gzgrep "$i" *"$VarDate"* ; done


