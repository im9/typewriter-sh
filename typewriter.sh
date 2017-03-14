#!/bin/bash
IFS_BACKUP=$IFS
IFS=$'\n'
CMDNAME=`basename $0`


/bin/echo ""
/bin/echo $'\e[33m ==> Dummy Loading \e[m'
/bin/echo ""


# loading spin animation
sp="/-\|"
sc=0
spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}


# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
}

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Proof of concept
for number in $(seq ${_start} ${_end})
do
    perl -MTime::HiRes -e 'Time::HiRes::sleep(0.01)'
    ProgressBar ${number} ${_end}
done
printf '\nFinished!\n'

# loading
for i in {0..15}
do
  spin
  perl -MTime::HiRes -e 'Time::HiRes::sleep(0.1)'
done
endspin


# Read file
readFile() {
FILENAME=$1
cat ${FILENAME} | while read LINE
do
  if [ "${LINE}" = "" ]; then
    /bin/echo  ${LINE}
    perl -MTime::HiRes -e 'Time::HiRes::sleep(0.3)'
  else
  	LENGTH=${#LINE}
  	COUNT=0
  	while [ ${LENGTH} -gt ${COUNT} ]
  	do
  	if [ $((LENGTH-1)) -eq ${COUNT} ]; then
      /bin/echo ${LINE:${COUNT}:1}
      perl -MTime::HiRes -e 'Time::HiRes::sleep(0.4)'
  	else
      /bin/echo -n ${LINE:${COUNT}:1}
  	fi
    COUNT=$(( COUNT + 1 ))
    perl -MTime::HiRes -e 'Time::HiRes::sleep(0.005)'
  	done
  fi
done
}

FILEPATH='sample.txt'
readFile ${FILEPATH}

exit 0
