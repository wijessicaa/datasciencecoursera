# Getting and Cleaning Data
The run_analysis.R script does the following:

Read the raw data 
Read the activities and subjects tables
Merge data to one single dataframe, called data_merged
Extract the mean and std data only
Change the label of activity from their Id to their Name
Rename the columns properly
Compute the mean by subject/activity/signal
Output the result to the file tidy.txt
