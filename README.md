Getting and Cleaning Data Course Project
============

##Overview

This repo contains:

- **run_analysis.R**: A R-script which reading and processing the raw data, output a cleaned tidy data set.

- **tidydata.txt**: The output of the above R-script

##Data Source and Description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Getting and Cleaning data process

**1. Merges the training and the test sets to create one data set.**

- Download the data sets

- Read in all the tables needed by read.table(). For this project the files used are **subject_test.txt, subject_train.txt, y_test.txt, y_train.txt, activity_labels.txt, X_test.txt, X_train.txt, features.txt**

- Combine the Training and Testing data, create a label for Train/Test

- Merged all variables into one big data set **dt**

**2. Extracts only the measurements on the mean and standard deviation for each measurement. **

Use **grep()** to locate the column names with "mean()" or "std()" and subset **dt**.

```{r}
subnames <- FeatureName$V2[grep("mean\\(\\)|std\\(\\)", FeatureName$V2)]
subnames <- as.character(subnames)
dt <- subset(dt, select = c("Subject", "Activity", "Type", subnames))
```
**3. Uses descriptive activity names to name the activities in the data set**

Factorize the Activities with the descriptive names

```{r}
dt$Activity <- factor(dt$Activity)
levels(dt$Activity) <- ActivityLabels$V2
```

**4. Appropriately labels the data set with descriptive variable names. **

Substitute all the Feature names with full description: t -> time, f -> frequency, Acc -> Accelerometer, Gyro -> Gyroscope, Mag -> Magnitude, BodyBody -> Body

```{r}
names(dt)<-gsub("^t", "time", names(dt))
names(dt)<-gsub("^f", "frequency", names(dt))
names(dt)<-gsub("Acc", "Accelerometer", names(dt))
names(dt)<-gsub("Gyro", "Gyroscope", names(dt))
names(dt)<-gsub("Mag", "Magnitude", names(dt))
names(dt)<-gsub("BodyBody", "Body", names(dt))
```
**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

```{r}
dt2 <- aggregate(. ~Subject + Activity, dt[ ,-3], mean)
dt2 <- dt2[order(dt2$Subject, dt2$Activity), ]
```

