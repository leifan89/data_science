library(data.table)
library(dplyr)

merge_train_and_test <- function(subject_train_file="./UCI HAR Dataset/train/subject_train.txt",
                                 X_train_file="./UCI HAR Dataset/train/X_train.txt",
                                 y_train_file="./UCI HAR Dataset/train/y_train.txt",
                                 subject_test_file="./UCI HAR Dataset/test/subject_test.txt",
                                 X_test_file="./UCI HAR Dataset/test/X_test.txt",
                                 y_test_file="./UCI HAR Dataset/test/y_test.txt") {
  
  subject_train <- fread(subject_train_file)
  X_train <- fread(X_train_file)
  y_train <- fread(y_train_file)
  subject_test <- fread(subject_test_file)
  X_test <- fread(X_test_file)
  y_test <- fread(y_test_file)
  
  combined_subject <- rbind(subject_train, subject_test)
  combined_X <- rbind(X_train, X_test)
  combined_y <- rbind(y_train, y_test)
  
  return(list(subj=data.frame(combined_subject), X=data.frame(combined_X), y=data.frame(combined_y)))
}

mean_and_stddev <- function(combined, features_file="./UCI HAR Dataset/features.txt") {
  features <- fread(features_file)
  means_stddev_filter <- grep("(mean\\(\\)|std\\(\\))", features$V2)
  filtered_X <- combined$X[, means_stddev_filter]
  names <- extract_activity_names(features)
  names <- gsub("\\(\\)", "", names)
  colnames(filtered_X) <- names
  return(list(subj=combined$subj, X=filtered_X, y=combined$y))
}

extract_activity_names <- function(features) {
  means_stddev_filter <- grep("(mean\\(\\)|std\\(\\))", features$V2)
  names <- features$V2[means_stddev_filter]
  return(as.character(names))
}

single_dataset <- function(combined) {
  y_labels <- change_y_names(combined$y)
  single_dataset <- cbind(combined$subj, y_labels, combined$X)
  colnames(single_dataset)[1] <- "Subject"
  colnames(single_dataset)[2] <- "Activity"
  return(single_dataset)
}

change_y_names <- function(ys, activity_labels_file="./UCI HAR Dataset/activity_labels.txt") {
  activities <- fread(activity_labels_file)
  lapply(ys, function(y) {
    return(activities$V2[y])
  })
}

combined <- merge_train_and_test()
filtered <- mean_and_stddev(combined)
single_dataset <- single_dataset(filtered)
tbl <- tbl_df(single_dataset)
summary <- (tbl %>% group_by(Subject, Activity) %>% summarize_all(mean))