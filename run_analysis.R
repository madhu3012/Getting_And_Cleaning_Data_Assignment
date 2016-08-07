# Synopsis - The goal of the assignment is to arrive at a tidy data set for further analysis.
# Data - The data linked to from the course website represent data collected from accelerometers from the Samsung Galaxy Smartphone.
# A full description is available at the site where the data is obtained - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data for the project - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Assignment - This R Script shows all the steps right fom downloading the data to arriving at a tidy data set.The activities include:
# 1. Downloading and unzipping the dataset
# 2. Loading activity labels and features
# 3. Extracting only the measurements on the mean and standard deviation for each measurement.
# 4. Loading the train and test datasets.
# 5. Merging the two datasets.
# 6. Adding labels to the dataset.
# 7. Turning activities and subjects into factors.
# 8. Writing a tidy dataset.

library(reshape2)

filename <- "getdata_dataset.zip"

# Downloading the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename)
}

# Unzipping the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Loading activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracting only the measurements on the mean and standard deviation for each measurement.
featuresRequired <- grep(".*mean.*|.*std.*", features[,2])
featuresRequired.names <- features[featuresRequired,2]
featuresRequired.names = gsub('-mean', 'Mean', featuresRequired.names)
featuresRequired.names = gsub('-std', 'Std', featuresRequired.names)
featuresRequired.names <- gsub('[-()]', '', featuresRequired.names)

# Loading the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresRequired]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresRequired]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merging datasets
allData <- rbind(train, test)

# Adding labels to the datset
colnames(allData) <- c("subject", "activity", featuresRequired.names)

# Turning activities and subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# Writing a tidy dataset
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
