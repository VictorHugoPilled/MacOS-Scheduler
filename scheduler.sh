#!/bin/zsh


# get todays scripts from a csv that must be passed
# to this script as the first argument
function parseCSV(){

    # csv variable
    csv=$1

    # if the csv doesn't exist, exit the function
    if [[ ! -f "$csv" ]]; then
	echo "File not found"
	return
    fi

    # create filelength integer variable so we don't get the header
    typeset -i fileLength=$(< $csv | wc -l)

    # read in the file and ignore the header
    scripts=$( < $csv | tail -n $fileLength )

    # return the scripts read in from the csv
    echo $scripts

}


# pass the scheduler as the first argument
function getTodaysScripts(){

    # %A = locale's full weekday name (e.g., Sunday)
    day=$(date "+%A")
    
    # store the csv variable
    csv=$1

    # parse the csv config file
    scripts=$(parseCSV "$csv")

    # if there are no scripts today do nothing
    if [[ ! -n "$scripts" ]]; then
	echo "No scripts today"
	return
    fi

    # create associate array for scripts
    typeset -A todaysScripts

    # iterate through each script
    while read -r lines;do
	scriptDay=$(echo $lines | awk -F"," '{print $1}')
	if [[ $scriptDay == $day ]]; then
	    # read in scriptname and time
	    scriptName=$(echo $lines | awk -F"," '{print $3}')
	    scriptTime=$(echo $lines | awk -F"," '{print $2}')
	    # place them in the associative array
	    todaysScripts[$scriptName]=$scriptTime
	fi
    # pipe the scripts variable into the above loop
    done <<< $scripts

    # return the associative array of todays scripts
    echo ${(kv)todaysScripts}
    
}


# first argument is scriptname
# second argument is the time you would like to schedule the script
function schedule() {
    
    # Get script time
    scriptTime=$2

    # Wait until its time to run
    # %R = 24-hour hour and minute
    while [[ $(date "+%R") != $scriptTime ]]; do
	sleep 1
    done
    
    # Check if the file exists before running it
    scriptName=$1
    [[ -f "$scriptName" ]] && python3 "$scriptName" &  || echo "File does not exists"
    
}

# takes csv with files as first argument
# and runs every script that needs to be run today
function main(){

    # store the csv
    csv=$1
    
    # create an associate array for todays scripts
    typeset -A todaysScripts

    # get a copy of today's associative array
    todaysScripts=( $(getTodaysScripts $csv) )

    # if the variable is empty exit the script
    if [[ ! -n "$todaysScripts"  ]];then
	echo "No scripts to run"
	return
    fi
    
    for scriptName scriptTime in ${(kv)todaysScripts};do
	echo "scheduling ${scriptName} to run at ${scriptTime}"

	# schedule each script
	schedule ${scriptName} ${scriptTime}
    done

    # wait for all scripts to run before exiting
    wait

    # all scripts have finished running
    echo 'Done'
}







