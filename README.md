# data_cleaning
## Getting and Cleaning Data Course Project

This project contains an R script (**run_analysis.R**) that performs the analysis of the
*Human Activity Recognition Using Smartphones Dataset* according to project requirements.

To run the script simply source the file from R terminal.

> source("run_analysis.R")

For our analysis we will use the dataset downloaded from the following link:
[Human Activity Recognition Using Smartphones Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The script will perform the following tasks:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. Create a tidy data set with the average of each variable for each activity and each subject.

Final tidy data set is saved in a separate file **tidyset.txt**.
