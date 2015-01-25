## A script to demonstrate your ability to collect, work with, and clean a 
## data set.
run_analysis <- function(){

     ## Load data.table 
     library(data.table)
     ## Get list of dataset files
     ## You have to put in where YOUR files are, ie C:/Users/yourName/etc...

     directory <- "C:/Users/JoJo/Desktop/Coursera/Data Science - Johns Hopkins/R working directory/Projects/UCI HAR Dataset"
     list_label <- list.files(directory, full.names = TRUE)
     
     directory_train <- "C:/Users/JoJo/Desktop/Coursera/Data Science - Johns Hopkins/R working directory/Projects/UCI HAR Dataset/train"
     list_train <- list.files(directory_train, full.names = TRUE)
     
     directory_train_inertial <- "C:/Users/JoJo/Desktop/Coursera/Data Science - Johns Hopkins/R working directory/Projects/UCI HAR Dataset/train/Inertial Signals"
     list_train_inertial <- list.files(directory_train_inertial, full.names = TRUE)
     
     directory_test <- "C:/Users/JoJo/Desktop/Coursera/Data Science - Johns Hopkins/R working directory/Projects/UCI HAR Dataset/test"
     list_test <- list.files(directory_test, full.names = TRUE)
     
     directory_test_inertial <- "C:/Users/JoJo/Desktop/Coursera/Data Science - Johns Hopkins/R working directory/Projects/UCI HAR Dataset/test/Inertial Signals"
     list_test_inertial <- list.files(directory_test_inertial, full.names = TRUE)
     
     
     ## Get training and test dataset
     ## You can make fancy looping input objects to do this, but I'm using brute force
     ## because I'm not yet fluent enough in R! 
     
     ## Getting feature labels
     features <- read.table(list_label[2],sep="")
     feature_label <- as.character(features[,2])
     
     ## Getting training set
     subject_train <- read.table(list_train[2],sep="")
     x_train <- read.table(list_train[3],sep="")
     y_train <- read.table(list_train[4],sep="")
     
     ## These is for getting the inertial data
     ## However, for this assignment you don't really need them, so I put them as comments.
     
     ## body_acc_x_train <- read.table(list_train_inertial[1],sep="")
     ## body_acc_y_train <- read.table(list_train_inertial[2],sep="")
     ## body_acc_z_train <- read.table(list_train_inertial[3],sep="")
     ## body_gyro_x_train <- read.table(list_train_inertial[4],sep="")
     ## body_gyro_y_train <- read.table(list_train_inertial[5],sep="")
     ## body_gyro_z_train <- read.table(list_train_inertial[6],sep="")
     ## total_acc_x_train <- read.table(list_train_inertial[7],sep="")
     ## total_acc_y_train <- read.table(list_train_inertial[8],sep="")
     ## total_acc_z_train <- read.table(list_train_inertial[9],sep="")

     ## Getting testing set
     subject_test <- read.table(list_test[2],sep="")
     x_test <- read.table(list_test[3],sep="")
     y_test <- read.table(list_test[4],sep="")

     ## These is for getting the inertial data
     ## However, for this assignment you don't really need them, so I put them as comments.
     
     ## body_acc_x_test <- read.table(list_test_inertial[1],sep="")
     ## body_acc_y_test <- read.table(list_test_inertial[2],sep="")
     ## body_acc_z_test <- read.table(list_test_inertial[3],sep="")
     ## body_gyro_x_test <- read.table(list_test_inertial[4],sep="")
     ## body_gyro_y_test <- read.table(list_test_inertial[5],sep="")
     ## body_gyro_z_test <- read.table(list_test_inertial[6],sep="")
     ## total_acc_x_test <- read.table(list_test_inertial[7],sep="")
     ## total_acc_y_test <- read.table(list_test_inertial[8],sep="")
     ## total_acc_z_test <- read.table(list_test_inertial[9],sep="")
     
     
     ## Merge and label the training and test sets to create one data set 
     training_set <- cbind(subject_train, y_train, x_train)
     test_set <- cbind(subject_test, y_test, x_test)
     
     # Merge set
     complete_set <- rbind(training_set, test_set)
     
     # Label columns
     column_names <- c("Subject_number","Activity_number", feature_label)
     colnames(complete_set) <- column_names     
     
          
     ## Extracts only the measurements on the mean and standard deviation for each measurement.
          ## Uses descriptive activity names to name the activities in the data set
          ## Appropriately labels the data set with descriptive variable names. 
     
     ## Means and std from the features object are columns 1-5, 41-46, 81-86, 121-126, 161-166
     ## 201-202, 214-215, 227-228, 240-241, 266-271, 345-350, 424-429
     ## 503-504, 516-517, 529-530, 542-543, 555-561
     
     ## Since I've added a Subject and Activity column, everything shifts by two.
     ## Therefore, these are the columns I want:
     meanStd_columns <- c(1:7, 43:48,  83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 268:273, 347:352, 426:431, 505:507, 518:519, 531:532, 544:545, 557:563)
     
     ## This is the subset asked for in step 2
     meanStd_set <- complete_set[meanStd_columns]
     
     ## This replaces the activity number with the descriptive label.
     ## 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING

     ## The complete set now has descriptive labels for all columns
     activity_code <- c(WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, SITTING=4, STANDING=5, LAYING=6)
     meanStd_set$Activity_number <- names(activity_code)[match(meanStd_set$Activity_number, activity_code)]

     ## An independent tidy data set with the average of each variable for each activity and each subject.
     ## Change set from data.frame to data.table
     meanStd_set.dt <-data.table(meanStd_set)
     #setkey(meanStd_set.dt, "Subject_number","Activity_number")
     
     # Using data.table to get average of every column indexed by Subject number & Activity
     index_set <- meanStd_set.dt[, lapply(.SD, mean), by=c("Subject_number", "Activity_number")]

     write.table(index_set, file="index_set2",  row.name=FALSE)     
     
     
}
