#!/bin/zsh


# pass the csv as the first argument
function getTodaysScripts(){
    
    # store the csv variable
    csv=$1

    # if the csv doesn't exist, exit the function
    if [[ ! -f "$csv" ]]; then
	echo 'File not found'
	return
    fi

    # get current day
    currentday=$(date "+%A")
    
    # use sqlite3 to read in the csv
    # select only today's scripts
    # and order by time
    scripts=$(sqlite3 :memory: <<EOF
.mode csv
.import $csv scheduler
SELECT Time,ScriptPath FROM scheduler
WHERE Day = '$currentday'
ORDER BY Time;
EOF
 )
    
    
    # return the scripts
    echo ${scripts}
    
}



# first argument is scriptname
# second argument is the time you would like to schedule the script
function runner() {
    
    # Get script time
    scriptTime=$2

    if [[ ! -n "$scriptTime" ]];then
	echo 'A time to run is needed'
	return
    fi

    # Check if the file exists before running it
    scriptName=$1
    if [[ ! -f "$scriptName" ]]; then
	echo 'File does not exist'
	return
    fi

    
    # Wait until its time to run
    # %R = 24-hour hour and minute
    while [[ $(date "+%R") != $scriptTime ]]; do
	sleep 1
    done
    
    
    # run script in the background
    python3 "$scriptName" &

}



# takes csv as first argument
# and runs every script that needs to be run today
function main(){

    # store the csv
    csv=$1

    # if the variable is empty exit the script
    if [[ ! -n "$csv" ]];then
	echo 'CSV needed'
	return
    fi

    # get todays scripts from the csv
    todaysScripts=$(getTodaysScripts $csv)

    # if the variable is empty exit the script
    if [[ ! -n "$todaysScripts"  ]];then
	echo 'No scripts to run'
	return
    fi

    echo $

    # read in the scripts line by line
    while IFS= read -r line;do

	# split the line into an array
	typeset -a array=(${(@s:,:)line})

	# scriptTime is first item in the array
	scriptTime=${array[1]}
	# scriptName is the second item
	scriptName=${array[2]}

	echo "${scriptName} will run at ${scriptTime}"

	# send the script to the runner
	# and store the pid
	typeset -i pid=$(runner ${scriptName} ${scriptTime})
	
    done <<< $todaysScripts

    wait
    


    

}



