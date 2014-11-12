# Check existence of the directory
if (!file.exists("./data")) {dir.create("./data")}

# Check existence of the file, if not, download the file and unzip it
file <- "./data/UCI HAR Dataset"
if (!file.exists(file)) {
  url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  tmp_file <- "./data/temp.zip"
  download.file(url,tmp_file)
  unzip(tmp_file, exdir="./data")
  unlink(tmp_file)
}

# Read in Subjects
SubjectTest <- read.table("./data//UCI HAR Dataset/test/subject_test.txt", header = FALSE)
SubjectTrain <- read.table("./data//UCI HAR Dataset/train//subject_train.txt", header = FALSE)

# Read in Activity
ActivityTest <- read.table("./data//UCI HAR Dataset/test//y_test.txt", header = FALSE)
ActivityTrain <- read.table("./data//UCI HAR Dataset/train//y_train.txt", header = FALSE)
ActivityLabels <- read.table("./data//UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Read in Feature
FeatureTest <- read.table("./data//UCI HAR Dataset/test//X_test.txt", header = FALSE)
FeatureTrain <- read.table("./data//UCI HAR Dataset/train//X_train.txt", header = FALSE)
FeatureName <- read.table("./data//UCI HAR Dataset/features.txt", header = FALSE)

# Create index to differ train and test data
type <- c(rep("Test", dim(ActivityTest)[1]), rep("Train", dim(ActivityTrain)[1]))

# Combine Test and Train data
Subjectdata <- rbind(SubjectTest, SubjectTrain)
Activitydata <- rbind(ActivityTest, ActivityTrain)
Featuredata <- rbind(FeatureTest, FeatureTrain)

# Add names
names(Featuredata) <- FeatureName$V2
names(Subjectdata) <- "Subject"
names(Activitydata) <- "Activity"

# Merge all data into one form
dt <- cbind(Subjectdata, Activitydata, Type =type, Featuredata)

# Subset the dataframe, only keep the Feature with mean() and std()
subnames <- FeatureName$V2[grep("mean\\(\\)|std\\(\\)", FeatureName$V2)]
subnames <- as.character(subnames)
dt <- subset(dt, select = c("Subject", "Activity", "Type", subnames))

# Factorize Type with levels train and test
dt$Type <- factor(dt$Type)

# Factorize the Activities with the descriptive names
dt$Activity <- factor(dt$Activity)
levels(dt$Activity) <- ActivityLabels$V2

# Change the Feature names to be descriptive
names(dt)<-gsub("^t", "time", names(dt))
names(dt)<-gsub("^f", "frequency", names(dt))
names(dt)<-gsub("Acc", "Accelerometer", names(dt))
names(dt)<-gsub("Gyro", "Gyroscope", names(dt))
names(dt)<-gsub("Mag", "Magnitude", names(dt))
names(dt)<-gsub("BodyBody", "Body", names(dt))

# Create a second tidy data set with average of each variable for each activity and subject
library(plyr);
dt2 <- aggregate(. ~Subject + Activity, dt[ ,-3], mean)
dt2 <- dt2[order(dt2$Subject, dt2$Activity), ]

# Write the new table two text file
write.table(Data2, file = "tidydata.txt",row.name=FALSE)