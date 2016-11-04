## Getting and Cleaning Data Week 4 project

This repository contains the following files:

1. **README.md** - this file explaining the contents of the repository
2. **CodeBook.md** - code book containing details on all data included in the file tidydata.txt
3. **run_analysis.R** - R script that performs the following steps:
   - checks for existance of the data folder and creates it if needed, establishes the source data url, downloads file, unzips file and collapses all folders to 1 directory
   - imports header data from features.txt
   - imports training data, subject ID and activity code; sets column names and adds the columns for subject id, activity code and names the columns
   - imports test data, subject ID and activity code; sets column names and adds the columns for subject id, activity code and names the columns
   - combines the test and training data into 1 dataframe
   - imports the activity lookup and adds the labels to the data
   - filters to the columns containing mean() and std() functions calculating mean and standard deviation
   - checks for and installs package dplyr if necessary
   - calculates the average of all columns by subject and activity
   - exports this summary data to a text file named tidydata.txt
4. **tidydata.txt** - contains the results from the R script run_analysis.R referenced above
