#!/bin/bash
logfile=/home/pi/midi/ewi.log
exec > $logfile 2>&1
echo "*** $(date): $0 $@ ********************"

function midi {
 amidi --port=$outport --send-hex="$1"
}

input=$(aconnect -l | grep client.*EWI | awk '{gsub(":","",$2);print $2}')
output=$(aconnect -l | grep client.*SD-50 | awk '{gsub(":","",$2);print $2}'):0
outport=$(amidi -l | grep "SD-50 Synth" | awk '{print $2}')
echo "Connecting $input -> $output port $outport"

aconnect -d $input $output

midi B07E01 #Mono mode 1ch
midi C042   #PGM 67
midi 904040 #Note on
sleep 1
midi 804000 #Note off

aconnect $input $output
aconnect -l

