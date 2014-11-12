Code Book
============
##Data Source and Description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Data Cleaning Process

-Merges the training and the test sets to create one data set.

-Extracts only the measurements on the mean and standard deviation for each measurement. 

-Uses descriptive activity names to name the activities in the data set.

-Appropriately labels the data set with descriptive variable names.

-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##tidydata.txt

**tidydata.txt** is a 180 x 68 data frame containing the mean of selected test results from the original data set for different Subject and Activity.

**Variables:**

-**Subject**: (Integer). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Eache subject is labeled with a integer 1, 2, ... 30.

-**Activity**: (Factor). Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

-**Features**: (Numeric) 66 columns of means of test results from the original data. The descriptive names show the specific test. More details can be found in **features_info** from the original data set.


