# CodeBook

`run_analysis.R`, by default, assumes that the relevant dataset has been placed into a directory called "UCI HAR Dataset" that is at the same level as `run_analysis.R`.

`run_analysis.R` performs the following:

- Combine the training and testing datasets into one

- Filter out all columns that are not means or standard deviations

- Apply human readable labels to all columns

- Create a new dataset of averages of each variable for each activity and each subject

For best results, run `run_analysis.R` in RStudio.
