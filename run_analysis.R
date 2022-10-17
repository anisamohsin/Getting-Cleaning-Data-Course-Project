#set the working directory to the unzipped folder "UCI HAR Dataset"
#the code for this is not included here since it will depend on path
#of this folder

#load packages
library(dplyr)

# read test data
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")


#read train data
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# rename the variables in subject_test, subject_train, y_test & y_train
subject_test <- rename(subject_test, subjectID = V1)
subject_train <- rename(subject_train, subjectID = V1)
y_test <- rename(y_test, activity = V1)
y_train <- rename(y_train, activity = V1)

# merge test & train data
test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
data <- rbind(test, train)

#read features file
features <- read.table("features.txt")

#change the features columns names to descriptive names
colnames(data)[3:length(data)] <- sub("V","", colnames(data)[3:length(data)])
colnames(data)[3:length(data)] <- features[colnames(data)[3:length(data)],]$V2

#extract only the measurements on the mean & standard deviation
data <- select(data, contains("subjectID") | contains("activity") | contains("mean()") | contains("std()"))

#read activity_labels file & replace the labels in the data with activity names
activities <- read.table("activity_labels.txt")
data$activity <- activities[data$activity,]$V2

#rename the variables in the data set
names <- colnames(data)[3:length(data)]
names <- gsub("t","Time", names)
names <- gsub("f","Frequency", names)
names <- gsub("Acc","Accelerometer", names)
names <- gsub("Gyro","Gyroscope", names)
names <- gsub("Mag","Magnitude", names)
names <- gsub("BodyBody","Body", names)
names <- gsub("\\(", "", names)
names <- gsub("\\)", "", names)
names <- gsub("-","", names)
colnames(data)[3:length(data)] <- names

#Create a second independent tidy data set with the average of
#each variable for each activity and each subject
TidyData <- group_by(data, subjectID, activity)
TidyData <- summarize(TidyData, across(timeBodyAccmeanX:freqBodyBodyGyroJerkMagstimed, ~ mean(.x, na.rm = TRUE)))

#write the tidy data to a text file
write.table(TidyData, "TidyData.txt")
