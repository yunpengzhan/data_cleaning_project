library(dplyr)

# download the zip file if it does not exist.
zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"

if (!file.exists(zipfile)) {
  download.file(zipurl, zipfile, mode = "wb")
}

# unzip the file, if the data directory does not exist
datapath <- "UCI HAR Dataset"
if (!file.exists(datapath)) {
  unzip(zipfile)
}

# step1: merge the training and the test sets to create one dataset
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' dataset
x_data <- rbind(x_train, x_test)

# create 'y' dataset
y_data <- rbind(y_train, y_test)

# create 'subject' dataset
subject_data <- rbind(subject_train, subject_test)

# step2: extract only the measurements on the mean and the standard deviation for each measurement
features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() and std()
mean_std_features <- grep("(mean|std)\\(\\)", features[,2])

# subset the desired columns
x_data2 <- x_data[, mean_std_features]

# correct the column names
names(x_data2) <- features[mean_std_features, 2]

# step3: use descriptive names to name the activities in the dataset
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[,1] <- activities[y_data[,1], 2]

# correct column name
names(y_data) <- "activity"

# step4: label the dataset with descriptive variable names

#correct column name
names(subject_data) <- "subject"

# bind all the data in a single dataset
all_data <- cbind(x_data2, y_data, subject_data)

# step5: create a second and independent tidy dataset with the average of each variable
# for each activity and each subject
activitymeans <- all_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# ourput to file "tidy_data.txt"
write.table(activitymeans, "tidy_data.txt", row.names = FALSE, quote = FALSE)
