# 1. download data
if(!file.exists('./data')) {
  # 1.1 create data directory
  dir.create('./data/')
  
  # 1.2 download file
  zipFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(zipFileUrl, destfile='./data/rawData.zip', method="curl")
  
  # 1.3 unzip files
  unzip('./data/rawData.zip', exdir = './data', unzip = 'internal') 
}

# 2. Merge the training and the test sets to create one data set.
  # 2.1 get data
    # get data description names
    features <- read.table('./data/UCI HAR Dataset/features.txt')

    # get activity label
    activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

    # get test data
    test_x <- read.table('./data/UCI HAR Dataset/test/X_test.txt')
    test_y <- read.table('./data/UCI HAR Dataset/test/y_test.txt')
    test_subject <- read.table('./data/UCI HAR Dataset/test/subject_test.txt')

    # get train data
    train_x <- read.table('./data/UCI HAR Dataset/train/X_train.txt')
    train_y <- read.table('./data/UCI HAR Dataset/train/y_train.txt')
    train_subject <- read.table('./data/UCI HAR Dataset/train/subject_train.txt')
    
  # 2.2 assign names to data table
    colnames(train_x) <- features[, 2]
    colnames(train_y) <- 'activity_id'
    colnames(train_subject) <- 'subject_id'
    
    colnames(test_x) <- features[,2]
    colnames(test_y) <- 'activity_id'
    colnames(test_subject) <- 'subject_id'
    
    colnames(activity_labels) <- c('activity_id', 'activity')
    
  # 2.3 merge data set
    merged_train <- cbind(train_subject, train_y, train_x)
    merged_test <- cbind(test_subject, test_y, test_x)
    merged_data <- rbind(merged_train, merged_test)

# 3. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3.1 get feature names from data set that contains both train and test data
    col_names <- colnames(merged_data)
  
  # 3.2 extract only names that contains means and standard deviation
    col_names <- (grepl('subject_id', col_names) |
                  grepl('activity_id', col_names) |
                  grepl('mean\\(\\)', col_names) |
                  grepl('std\\(\\)', col_names))
    
  # 3.3 get all the rows with variables that contains only mean and standard deviation
    mean_and_std_data <- merged_data[, col_names == TRUE]
    
# 4. Uses descriptive activity names to name the activities in the data set
     mean_and_std_activity_data <- merge(activity_labels,
                                         mean_and_std_data,
                                         by = 'activity_id',
                                         all.x = TRUE)

# 5. Appropriately labels the data set with descriptive variable names. 
  # Label has been provided in step 1.2, 2.2 and 3

# 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # 6.1 remove column that cannot be averaged, which is activity column
  avg_data <- select(mean_and_std_activity_data, -activity)
  
  # 6.2 find eaverage of each variable
  avg_data <- aggregate(. ~activity_id + subject_id, avg_data, mean) 
  
  # 6.3 add activity name to the tidy set
  avg_data <- merge(activity_labels, 
                   avg_data,
                   by = 'activity_id',
                   all.x = TRUE)
  
  # 6.4 order the data by subject and by activity
  tidy_data <- avg_data[order(avg_data$subject_id, avg_data$activity_id), ]
  
  # 6.5 produce tidy data
  write.table(tidy_data, file = 'tidy_data.txt', row.names = FALSE, col.names = TRUE)
  