
library(plyr)
library(data.table)

#download data
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCIHARDataset.zip')){
  download.file(fileurl,'./UCIHARDataset.zip', mode = 'wb')
  unzip("UCIHARDataset.zip", exdir = getwd())
}
path<-"./UCI HAR Dataset/"

list.files(path, recursive = T)

#read files
x.train <- read.table(file.path(path, "train", "X_train.txt"))
x.test <- read.table(file.path(path, "test", "X_test.txt"))

y.train <- read.table(file.path(path, "train", "Y_train.txt"))
y.test <- read.table(file.path(path, "test", "Y_test.txt"))

subjetc.train<- read.table(file.path(path, "train", "subject_train.txt"))
subjetc.test<- read.table(file.path(path, "test", "subject_test.txt"))


#merge files into one
x <- rbind(x.train, x.test )
y <- rbind(y.train, y.test )
s <- rbind(subjetc.train, subjetc.test)

setnames(s, "V1", "subject")
setnames(y, "V1", "activityNum")
data.all<-cbind(s, y, x)



#extract only the mean and standard deviation
features <- read.table(file.path(path, "features.txt"))
setnames(features, names(features), c("featureNum", "featureName"))
features2  <- features [grepl("mean\\(\\)|std\\(\\)", featureName)]
features2$featureCode<-features2[, paste0("V", featureNum)]
data.sub <- data.all[, features2$featureCode,with = FALSE]



#Uses descriptive activity names to name the activities in the data set
ActivityNames <- read.table(file.path(path, "activity_labels.txt"))
setnames(ActivityNames, names(ActivityNames), c("activityNum", "activityName"))
y[, 1] = ActivityNames[y[, 1], 2]



#Appropriately labels the data set with descriptive variable names

names(data.sub)<-unlist(features2[,2], recursive = TRUE, use.names = F)
name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

data.sub.descriptive<-cbind(s, y, data.sub)


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averagedata <- aggregate(data.sub.descriptive[,3:68], by = list(Activity=data.sub.descriptive$activityNum, Subject=data.sub.descriptive$subject),mean)
