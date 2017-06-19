# Project Code Book

This **CodeBook.md** describes the variables, the data, and any transformations or work that was performed
to clean up the data.

The script contains one helper function called **file2dt()**. The function is a wrapper for standard **fread()**.
It takes two parameters -- file name to load the data from, and an optional list of column names to be
assigned to the loaded data table.

Data sets are loaded into the following variables using **file2dt()** function:

```
Variable Name       File Name
------------------  ------------------------
activity_labels     activity_labels.txt
features            features.txt
train_x             train/X_train.txt
train_y             train/y_train.txt
train_subj          train/subject_train.txt
test_x              test/X_test.txt
test_y              test/y_test.txt
test_subj           test/subject_test.txt
```

Subsequently, data sets are merged by rows and saved in:
```
merged_x
merged_y
merged_subj
```

*merged_x* is filtered to contain just the measurements on the mean and standard deviation for each measurement.

*merged_set* combines *merged_x*,*merged_y*, and *merged_subj* data sets as columns into one data.table.

*merged_activity* variable contains factorized Training labels and is build using *activity_labels* definition.

**tidy_data** variable contains the final tidy data set with aggregated measurements.

Finally, the **tidy_data** is saved in the **tidyset.txt**.
