#!/usr/bin/python3
from pathlib import Path
from time import time, strftime,localtime

# create a new file in home directory for testing
def creater(fileName: str = 'testfile.txt') -> None:
    currentTime: str = strftime("%a, %d %b %Y %H:%M:%S +0000", localtime(time()))
    file: Path = Path(Path.home(),fileName)
    file.touch()
    file.write_text(currentTime, encoding="utf-8")
    

if __name__ == "__main__":
    creater()
