Code Book
==========

## Pre Analysis
This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## 1. Read data and Merge
* subject_test : subject IDs for test
* subject_train  : subject IDs for train
* x.test : values of variables in test
* x.train : values of variables in train
* y.test : activity ID in test
* y.train : activity ID in train
* ActivityNames : Description of activity IDs in y_test and y_train
* features : description(label) of each variables in X_test and X_train

* data.all: bind of X_train and X_test

## 2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset dataSet.
* features2  : a vector of only mean and std labels extracted from 2nd column of features
* ddata.sub : at the end of this step, dataSet will only contain mean and std variables

## 3. Uses descriptive activity names to name the activities in the data set

* y[, 1]: activities with descriptive name

## 4. Appropriately labels the data set with descriptive variable names
Combine test data and train data of subject and activity, then give descriptive lables. Finally, bind with dataSet. At the end of this step, dataSet has 2 additonal columns 'subject' and 'activity' in the left side.
* data.sub.descriptive : final results


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* averagedata  : casete baseData which has means of each variables

## 6. Output tidy data
 Finally output the data as "tidy_data.txt"
