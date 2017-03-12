setwd("/Users/private/Desktop/Coursera Data Science/03.PreparingData/FinalProject/UCI HAR Dataset/")
library(plyr)
library(dplyr)

## Instruction Step 1: Merges the training and the test sets to create one data set
# Read informational data set and label columns
features <- read.table("./features.txt", header = FALSE, sep = "")
        colnames(features) <- c("ColumnNumber", "ColumnName")
act_labels <- read.table("./activity_labels.txt", header = FALSE, sep = "")
        colnames(act_labels) <- c("ActivityID", "Activity")
        
# Read detailed data set (content) and label columns
x_train <- read.table("./train/X_train.txt", header = FALSE, sep = "")
        colnames(x_train) <- features$ColumnName
y_train <- read.table("./train/y_train.txt", header = FALSE, sep = "")
        colnames(y_train) <- c("ActivityID")
sub_train <- read.table("./train/subject_train.txt", header = FALSE, sep = "")
        colnames(sub_train) <- c("SubjectID")
x_test <- read.table("./test/X_test.txt", header = FALSE, sep = "")
        colnames(x_test) <- features$ColumnName
y_test <- read.table("./test/y_test.txt", header = FALSE, sep = "")
        colnames(y_test) <- c("ActivityID")
sub_test <- read.table("./test/subject_test.txt", header = FALSE, sep = "")
        colnames(sub_test) <- c("SubjectID")

# Merge training and test data set individually first
training_data <- cbind(sub_train, y_train, x_train)
test_data <- cbind(sub_test, y_test, x_test)
# Merge training and test data set together into one dataset
merged_data <- rbind(training_data, test_data)


## Instruction Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Select columns with mean and standard deviation in it
colSelection <- grep("(-mean|-std)\\(\\)", colnames(merged_data))       # excludes meanFreq, angle-related variables
# Superimpose first two columns (Subject & Activity) into the selection
colSelection <- c(1, 2, colSelection)
# Apply filter
filtered_data <- merged_data[, colSelection]


## Instruction Step 3: Uses descriptive activity names to name the activities in the data set
# Name each observation with the activity in the last column
merged_actdata <- merge(filtered_data, act_labels, by = "ActivityID", all = TRUE)


## Instruction Step 4: Appropriately labels the data set with descriptive variable names.
colnames(merged_actdata) <- gsub("^t", "time-", colnames(merged_actdata))       # rename "t" to "time"
colnames(merged_actdata) <- gsub("^f", "freq-", colnames(merged_actdata))       # rename "f" to "freq" (for frequency)


## Instruction Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Factorize Activity
merged_actdata$Activity <- as.factor(merged_actdata$Activity)

# Create a tidy dataset by unique Subject-Activity combination, and average the results
tidy_data <- aggregate(merged_actdata, 
                by = list(Activity = merged_actdata$Activity, SubjectID = merged_actdata$SubjectID),
                FUN = mean)
# Tidying up columns of the tidy dataset
tidy_data[, 3:4] <- NULL
tidy_data[, ncol(tidy_data)] <- NULL

# Write out the tidy dataset as a .csv file
write.table(tidy_data, "./TidyData.txt", sep = ",", row.names = FALSE)

