#set the working directory, put the Samsung data in the working directory
getwd()
setwd("")

#load data into R 
test_dataset <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
train_dataset <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
features <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_label <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
train_subjects <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
test_subjects <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

#load tidyverse package
library(tidyverse)

#add two columns into dataset named as "subject" and "activity"
test_dataset <- mutate(test_dataset,subject=test_subjects$V1,activity=test_activities$V1)
train_dataset <- mutate(train_dataset,subject=train_subjects$V1,activity=train_activities$V1)

#append test dataset and train dataset togother into a big dataset
whole_dataset <- rbind.data.frame(test_dataset,train_dataset)

#appropriately labels the data set with descriptive variable names
col_names <- c(as.character(features$V2),"subject","activity")
names(whole_dataset) <- col_names

#uses descriptive activity names to name the activities in the data set
whole_dataset$activity <- factor(whole_dataset$activity, 
                        levels=c(1,2,3,4,5,6), 
                        labels=activity_label$V2)

#only extracts the measurements on the mean and standard deviation for each measurement
whole_dataset <- tbl_df(whole_dataset[,c(1:296,345:381,424:460,503:563)])
whole_dataset <- select(whole_dataset,subject,activity,contains("mean"),contains("std"))

#creates a second independent tidy data set with the average of each variable for each activity and each subject
grouped_data <- group_by(whole_dataset,subject,activity)
ave_persub_peract <- summarise_all(grouped_data,mean)

#write a table into the working directory
write.table(ave_persub_peract, file = "./result_tidy_dataset.txt", row.names = FALSE)
