# Getting and Cleaning Data Course Project
#
# The purpose of this script is to collect, work with, and clean a data set provided by
# a group of data scientists in the following publication:
#
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support
# Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
# Vitoria-Gasteiz, Spain. Dec 2012
#
# The script will perform the following steps:
#    1. Merge the training and the test sets to create one data set.
#    2. Extract only the measurements on the mean and standard deviation for each measurement.
#    3. Uses descriptive activity names to name the activities in the data set
#    4. Appropriately label the data set with descriptive variable names.
#    5. Create a tidy data set with the average of each variable for each activity and each subject.

# ----------------------
# Create helper read function
# ----------------------
file2dt <- function(file, col_names = c()) {
    fullpath <- paste(datadir, file, sep = "")
    dt <- fread(fullpath)
    if (length(col_names) > 0) {
        names(dt) <- col_names
    }
    dt
}

# ----------------------
# As per submission instructions, the data is already supposed to be in the working directory.
# So, we'll skip downloading and unzipping the dataset file.
#
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Dataset.zip")
# unzip("Dataset.zip")

datadir <- paste(getwd(), "/UCI HAR Dataset/", sep = "")

# ----------------------
# Load <common> files
activity_labels <- file2dt("activity_labels.txt", c("id", "Name"))
features <- file2dt("features.txt", c("id", "Name"))

# ----------------------
# 1) Merge the training and the test sets to create one data set.
# ----------------------

# ----------------------
# Load <train> files
train_x <- file2dt("train/X_train.txt")
train_y <- file2dt("train/y_train.txt", "ActivityId")
train_subj <- file2dt("train/subject_train.txt", "SubjectId")

# ----------------------
# Load <test> files
test_x <- file2dt("test/X_test.txt")
test_y <- file2dt("test/y_test.txt", "ActivityId")
test_subj <- file2dt("test/subject_test.txt", "SubjectId")

# ----------------------
# Merge datasets
merged_x <- rbind(train_x, test_x)
merged_y <- rbind(train_y, test_y)
merged_subj <- rbind(train_subj, test_subj)


# ----------------------
# 2) Extract only the measurements on the mean and standard deviation for each measurement.
# ----------------------

# Extract only mean/std measurements
chosen_features <- grep("-(mean|std)\\(\\)", features[, Name])
merged_x <- merged_x[, chosen_features, with = FALSE]

# ----------------------
# 3) Use descriptive activity names to name the activities in the data set
# ----------------------

merged_activity <- factor(merged_y[,ActivityId], levels = activity_labels[["id"]], labels = activity_labels[["Name"]])

# ----------------------
# 4) Appropriately label the data set with descriptive variable names.
# ----------------------

# Prepare selected Features names
measurements <- features[chosen_features, Name]
# Strip () from the names
measurements <- gsub('[()]', '', measurements)
# Set column names
names(merged_x) <- measurements
# Combine all columns
merged_set <- cbind(merged_subj, merged_activity, merged_x)
# Fix ActivityId column name
colnames(merged_set)[2] <- "ActivityId"

# ----------------------
# 5) From the data set in step 4, create a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
# ----------------------

total_cols <- ncol(merged_set)
# Aggregate measurements by Subject and Activity
tidy_data <- aggregate(merged_set[, 3:total_cols], list(merged_set$SubjectId, merged_set$ActivityId), mean)
# Assign proper names
colnames(tidy_data)[1:2] <- c("SubjectId","Activity")

# Save final tidy data set into csv file
#print(tidy_data)
write.table(x = tidy_data, file = "tidyset.txt", row.name = FALSE)
