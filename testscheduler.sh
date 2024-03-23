#!/bin/zsh
# This is how it runs when used in a workflow
function testWithCSV() {

    csv='scheduler.csv'
    source scheduler.sh
    main $csv
    
}

# Test running without a workflow
function testNoCSV() {

    source scheduler.sh
    main
    
}


