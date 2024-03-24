
rm -rf ~/test.csv
rm -rf ~/testfile.txt
#create a new test file
touch ~/test.csv
# send one entry with today's date to the csv
echo "$(date +%A),$(date +%R),~/createFile.py" >> ~/test.csv
