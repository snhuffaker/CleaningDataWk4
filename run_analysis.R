##check for data folder, establish url, download file, unzip file 
##and collapse all folders to one directory
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/wearables.zip", method="curl")
unzip("./data/wearables.zip", junkpaths = TRUE, exdir = "./data/wearables")

##import headers
headers <- read.table("./data/wearables/features.txt", header = FALSE)

##import training data, subject ID, activity code, set column names and
##bind the columns for the subject ID and activity code and add names
train <- read.table("./data/wearables/X_train.txt", header = FALSE)
train_subject <- read.table("./data/wearables/subject_train.txt", header = FALSE)
train_activity <- read.table("./data/wearables/y_train.txt", header = FALSE)
names(train) <- headers[,2]
train <- cbind(train_subject, train_activity, train)
names(train)[1] <- paste("subject")
names(train)[2] <- paste("activity")

##import test data, subject ID, activity code, set column names and
##bind the columns for the subject ID and activity code and add names
test <- read.table("./data/wearables/X_test.txt", header = FALSE)
test_subject <- read.table("./data/wearables/subject_test.txt", header = FALSE)
test_activity <- read.table("./data/wearables/y_test.txt", header = FALSE)
names(test) <- headers[,2]
test <- cbind(test_subject, test_activity, test)
names(test)[1] <- paste("subject")
names(test)[2] <- paste("activity")

##combine test and train data into 1 dataframe
data <- rbind(test,train)

##import activity lookup and add labels to the data
activities <- read.table("./data/wearables/activity_labels.txt", header = FALSE)
names(activities) <- c("activity","label")
data <- merge(activities, data, by.x = "activity", by.y = "activity")

##filter to columns containing mean and std deviation
colnames <- names(data)
cols <- (grepl("activity", colnames) |
         grepl("label", colnames) |
         grepl("subject", colnames) | 
         grepl("mean\\()", colnames) | 
         grepl("std\\()", colnames) 
       )
mean_std_dev <- data[,cols==TRUE]

##check for and install dplyr
dplyr_check <- require("dplyr")
ifelse (dplyr_check == FALSE, install.packages("dplyr"), library(dplyr))

##calculate average of all columns by subject and activity
tidydata <- mean_std_dev %>%
            group_by(activity,label,subject) %>%
            summarize_each(funs(mean))

##export tidy data set with mean values for each subject and activity for the
##selected columns
write.table(tidydata,"tidydata.txt", row.names = FALSE)