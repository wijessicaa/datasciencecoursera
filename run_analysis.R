library(data.table)
# read the features
features<- read.table("./UCI HAR Dataset/features.txt",header = FALSE, sep = ' ')
features<-as.character(features[,2])
#read the train data
train_data_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_data_y <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep =" ")
train_data_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep =" ")

train_data <- data.frame(train_data_subject, train_data_y, train_data_x)
names(train_data)<- c(c("subject","activity"),features)

#read the test data
test_data_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_data_y <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep =" ")
test_data_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep =" ")

test_data <- data.frame(test_data_subject, test_data_y, test_data_x)
names(test_data)<- c(c("subject","activity"),features)

#1. merge the test and train data
data_merged <- rbind(train_data, test_data)

#2 extract only the measurement on the mean adn std for each measurement
mean_std <- grep("mean|std",features)
data2 <- data_merged[,c(1,2,(mean_std + 2))]

#3. use descriptive activity names to name the activities in the dataset
activity_label<- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
activity_label <- as.character(activity_label[,2])
data2$activity <- activity_label[data2$activity]

#4. Appropriately labels the data set with descriptive variable names
name <- names(data2)
name <- gsub("[(][)]","",name)
name <- gsub("^t", "TimeDomain",name)
name <- gsub("^f","FrequencyDomain",name)
name<- gsub("Acc", "Accelerometer", name)
name <- gsub("Gyro","Gyroscope",name)
name <- gsub("Mag","Magniture",name)
name <- gsub("-","_",name)
names(data2)<- name

#5. creates a second independent tidy data
data_tidy <- aggregate(data2[,3:81], by = list(activity = data2$activity, subject = data2$subject),FUN = mean)
write.table(x=data_tidy, file ="data tidy.txt", row.names = FALSE)