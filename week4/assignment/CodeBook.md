# Code book for Getting and Cleaning Data Course Project

## Background
Analysing wearable data. 

## Data source
Data used in this repository represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Steps to reproduce tidy data set
1. Launch RStudio
2. Ensure correct work directory is setup with ```setwd()```
3. Execute run_analysis.R in RStudio
4. tidy_data.txt can be found in the designated working directory.

## Data transofrmation
Data transformation is done in run_analysis.R file. The file perform 6 tasks to produce tidy data.

 1. Prepare data
	1.1 Create data directory
	1.2 Download respective data in zip format
	1.3 Unzip the data

2. Merge the training and the test sets to create one data set.
	2.1 Gets different data set
	2.2 Assign names to data table
	2.3 Merge data set

3. Extracts only the measurements on the mean and standard deviation for each measurement.
	3.1 Get column name (feature names) from data set that contains both train and test data
	3.2 Extract only names that contains means and standard deviation
	3.3 Get all the rows with variables that contains only mean and standard deviation

4. Uses descriptive activity names to name the activities in the data set

5. Appropriately labels the data set with descriptive variable names. 

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	6.1 Remove column that cannot be averaged, which is activity column
	6.2 Find eaverage of each variable
	6.3 Add activity name to the tidy set
	6.4 Order the data by subject and by activity
	6.5 Write tidy data into tidy_data.txt
	
## About variables
```features```:  List of all features and is read from the original data set.

```test_x```: Test data set and is read from the original data set.
```test_y```: Test label set and is read from the original data set.
```test_subject```: Test subject data set who performed the activity and is read from original data set. 

```train_x```: Train data set and is read from the original data set.
```train_y```: Train data set and is read from the original data set.
```train_subject```: Train subject data set who performed the activity and is read from original data set. 

```merged_train```: Resulting data set from merging ```train_y``` (activity_id), ```train_subject``` and ```train_x```.
```merged_test```: Resulting data set from merging ```test_y``` (activity_id), ```test_subject``` and ```test_x```.
```merged_data```: Resulting data set that merges ```merged_train``` and ```merged_test```.

```col_names```: Column names extracted from ```merged_data``` that contains columns of interest.

```mean_and_std_data```: Data set that contains only mean and standard deviations variables
```mean_and_std_activity_data```: Date set that contains descriptive activity for each mean and standard deviation acticity.

```avg_data```: Data set that contains the average of each variable in ```mean_and_std_activity_data```

```tidy_data```: Final tidy data set
