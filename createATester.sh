function testcsvcreator() {
    # delete the test.csv
    rm -rf testschedule.csv

    # delete previous files created by tests
    rm -rf ~/testfile.txt
    rm -rf test.json
    
  
    # store variables for heredoc
    testcsv="testschedule.csv"
    # python test files
    pyfile1='createFile.py'
    pyfile2='basicdownload.py'
    pyfile3=~/thirdkey.py

    # Create entries that are 2 minutes, 3 minutes and 5 minutes from now
    twominutes=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+2M`" "+%H:%M")
    threeminutes=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+3M`" "+%H:%M")
    fiveminutes=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+5M`" "+%H:%M")
    
    # create three entries for today using heredoc
    cat <<EOF > $testcsv
Day,Time,ScriptPath
$(date +%A),$twominutes,$pyfile1
$(date +%A),$threeminutes,$pyfile2
$(date +%A),$fiveminutes,$pyfile3
EOF

    echo "Done"
    
}

