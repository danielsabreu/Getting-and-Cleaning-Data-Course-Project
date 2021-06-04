
# 1. Merges the training and the test sets to create one data set.

X_test <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/test/Y_test.txt")

X_train <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/train/Y_train.txt")

X <- rbind(X_test,X_train)
Y <- rbind(Y_test,Y_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/features.txt")
activity_labels <- read.table("C:/Users/bpu313718/Desktop/coursera/UCI HAR Dataset/activity_labels.txt")

colnames(X)<-features$V2

X_mean <- X[,grep("mean()", names(X), value=TRUE)]
X_st <- X[,grep("st()", names(X), value=TRUE)]
X_mean_st <- cbind(X_mean,X_st)

# 3. Uses descriptive activity names to name the activities in the data set

library(dplyr)

data <- cbind(Y,X_mean_st)
data <- left_join(data,activity_labels) 
data<- data[,-1]
names(data)[80] <- "activity"

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

data_means <- aggregate(data[,1:79], list(data$activity), mean)
write.table(data_means,"run_analysis")