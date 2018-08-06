import numpy as np
#import pandas as pd
import os
import glob
from datetime import datetime, timedelta
import zipfile
from zipfile import ZipFile

# Define path of the directory
path = 'C:/Users/Owner/Desktop/Perl/'

# Define sender and receiver
sender = "transportal@topslab.wisc.edu"
host = "smtp.wiscmail.wisc.edu"
receiver = "cheng8@wisc.edu"

# Check current date and set the number of days ago
# Save the past N days *zip files into list
N = 1
check_file_list = []

while (N != 0):
    date_N_days_ago = datetime.now() - timedelta(days=N)
    file_N_days_ago = "d2d" + str(date_N_days_ago)[:4] + str(date_N_days_ago)[5:7] + str(date_N_days_ago)[8:10] + ".zip"
    check_file_list.append(file_N_days_ago)
    N -= 1
print(check_file_list)

# Create log file and write track information
with open('log.txt', 'w') as f:

    # Past N days file record
    f.write("Check files of " + str(N) + " days ago!\n")

    # Email information record
    f.write("Open log.txt!\n")
    f.write("Sent from: " + sender + "\n")
    f.write("Host: " + host + "\n")
    f.write("Receiver: " + receiver + "\n")

    # Open directory and iterate the *zip files
    f.write("Opening the *zip files in target directory " + path + "!\n") # Open the goal directory

    # Rename files
    file1 = "d2d_detlog.csv"
    file2 = "d2d_Controllers.csv"
    file3 = "d2d_Detectors.csv"


    for item in check_file_list:
        # Old file name
        old_file1 = item[:-4] + ".csv"
        old_file2 = item[:-4] + "Controllers.csv"
        old_file3 = item[:-4] + "Detectors.csv"

        fantasy_zip = zipfile.ZipFile(path + item)
        if(fantasy_zip):
            f.write("Starting to extract files!\n")
        else:
            f.write("Downloading to extract files!\n")

        fantasy_zip.extractall(path)
        fantasy_zip.close()

        os.rename(old_file1,file1)
        os.rename(old_file2, file2)
        os.rename(old_file3, file3)

        f.write("Rename " + item + " done!\n")
        os.remove(item)

        with ZipFile(item, 'w') as myzip:
            myzip.write(file1)
            myzip.write(file2)
            myzip.write(file3)

        myzip.close()

        os.remove(old_file1)
        os.remove(old_file2)
        os.remove(old_file3)




