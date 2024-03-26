function testcsvcreator() {
    # delete the test.csv
    rm -rf testschedule.csv

    # delete previous files created by tests

    rm -rf test.json
    rm -rf ~/testfile.txt
  
    # store for heredoc
    testcsv="testschedule.csv"
    # python test files
    pyfile1="createFile.py"
    pyfile2="basicdownload.py"
    pyfile3="~/thirdkey.py"
    
    # create three entries for today using heredoc
    cat <<EOF > $testcsv
$(date +%A),$(date +%R),$pyfile1
$(date +%A),$(date +%R),$pyfile2
$(date +%A),$(date +%R),$pyfile3
EOF

    echo "Done"
    
}
