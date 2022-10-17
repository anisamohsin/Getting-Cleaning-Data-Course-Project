
## **Week 4 Project - Getting & Cleaning Data in R**

Author: Anisa Al Hafeedh  
Data Source: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


This codebook was created for the purpose of explaining more about the variables in the data, the transformation and reshaping of data done in the script and other relevant information.

### **Data Set Information (from the website)**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See *features_info.txt* for more details. 
  
  
**For each record it is provided:**  

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.  

- Triaxial Angular velocity from the gyroscope.  

- A 561-feature vector with time and frequency domain variables.  

- Its activity label.  

- An identifier of the subject who carried out the experiment.
  
**The pre-cleaned dataset includes the following files:**  

- 'README.txt'  

- 'features_info.txt': Shows information about the variables used on the feature vector.  

- 'features.txt': List of all features.  

- 'activity_labels.txt': Links the class labels with their activity name.  

- 'train/X_train.txt': Training set.  

- 'train/y_train.txt': Training labels.  

- 'test/X_test.txt': Test set.  

- 'test/y_test.txt': Test labels.

**The following files are available for the train and test data. Their descriptions are equivalent.**  

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.  

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.  

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

### **Task**
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
  
  
**Brief walk through of thought process**  

The data was downloaded from the provided [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The file was unzipped in a folder created specifically for this project. The working directory was set to the unzipped folder "UCI HAR Dataset". The **dplyr** package was loaded using```library(dplyr)``` since functions from this package are used here. Data sets were read using ```read.table```. To merge the training and test set, we first have to merge the data provided for each set in the three files (e.g. for the test data merge: *X_test*, *y_test* & *subject_test* using ```cbind```. the same is done for the train data). We then merge the test & train data using ```rbind```. To filter out the mean and standard deviation, we first load the features text file, then select the corresponding columns with patterns which matches the words *"mean()"*, and *"std()"* in their names. We also read *activity_labels.txt* and use it to replace the activity IDs in the second column with activity names. Then, We work on tidying the variables names to make them descriptive using ```gsub```.

With a merged data set, we have to create a new data set with the average of each variable for each activity and each subject. To do that we first group the data set by subject ID and activity using ```group_by```. We then use ```summarize``` to compute the mean across all columns for each pair of subject & activity. ```across``` is used inside ```summarize``` in order to achieve this. Finally, write the tidy and clean data set into a new file using ```write.table```.
  
As for giving descriptive names for labels, here's what I changed:  
"t" = "Time"  
"f" = "Frequency"  
"Acc" = "Accelerometer"  
"Gyro" = "Gyroscope"  
"Mag" = "Magnitude"  
"BodyBody" = "Body"  
"()" = ""  
"-" = ""
