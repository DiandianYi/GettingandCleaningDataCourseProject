## The instruction of the R script 
### For the R script "run_analysis.R"
This script has 7 steps to complete the assignment:
* Set the working directory using setwd();
* Load the data into R use read.table(). This script seperately load test data, train data, feature lable for variables, activity label for both test and train datasets, subject lable for both test and train datasets into R;
* Load tidy verse package using library();
* Add subject and activity label column to test and train datasets(mutate()), append test and train datasets together into a big dataset(rbind.data.frame()), label this dataset with descriptive variable nemas according to feature info;
* Use descriptive activity names to name the activities in the dataset(factor());
* Create a second independent tidy dataset with the average of each variable for each activity and each subject(group_by(),summarise_all());
* Write a table into the working directory(write.table()).
Please do set the working directory using setwd(), put the Samsung data in your working directory, then fill in the path of your working directory between quotes in setwd() before running this script. Then source the whole script in R, you will get the resulted tidy dataset with the average of each variable for each activity and each subject. 


   