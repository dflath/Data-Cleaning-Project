This document describes project materials produced by Dan Flath in May 2014 for Coursera's course  "Getting and Cleaning Data" originating at Johns Hopkins University.

The project concerns the "Human Activity Recognition Using Smartphones Dataset Version 1.0" available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
The data consists of many measurements on 30 subjects while engaged in 6 different activities: standing, walking, walking upstairs, walking downstairs, sitting, and laying. 

Dan Flath produced 3 documents:

1. runanalysis.R

2. tidydata.txt

3. codeBook.md

#### runanalysis.R
An R script to read in the raw data mentioned above, and to   output the data file tidydata.txt. This script assumes that a a folder named "UCI HAR Dataset", located in the current working directory, contains txt files containing data and labels named activity_labels.txt, features.txt, X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt.   

#### tidydata.txt
A comma separated data file, produced by runanalysis.R, and described in detail in codebook.md

#### codeBook.md 
A description of the dataset tidydata.txt, including the reasons for choices about variables made during its production. 

