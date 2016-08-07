Coursera: Getting-and-Cleaning Data Assignment

Synopsis - The goal of the assignment is to arrive at a tidy data set for further analysis.

Data - The data linked to from the course website represent data collected from accelerometers from the Samsung Galaxy Smartphone.
A full description is available at the site where the data is obtained - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+SmartphonesHere are the data for the project - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Analysis Files - Following are the Analysis files:

1) Read.md - This readme.md file explains how the analysis is done.
2) R Script i.e (run_analysis.R) shows all the steps right from downloading the data to arriving at a tidy data set.The activities include:
   1. Downloading and unzipping the dataset
   2. Loading activity labels and features
   3. Extracting only the measurements on the mean and standard deviation for each measurement.
   4. Loading the train and test datasets.
   5. Merging the two datasets.
   6. Adding labels to the dataset.
   7. Turning activities and subjects into factors.
   8. Writing a tidy dataset.

3) Codebook gives all information about all variables and summaries calculated.
4) tidy.txt - This file gives the end result i.e tidy dataset that has been arrived using the process mentioned in R Script.
