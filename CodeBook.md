The R-script script run_analysis.R creates a data set tidydata.txt.

The data from which tidydata.txt is produced comes from 
measurements on 30 volunteers, within an age bracket of 19-48 years,  while  performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The measurements were taken by a smartphone (Samsung Galaxy S II) the subjects wore around their waists.

The original data consists of 10299 cases (divided into a test set and a training set which are merged by run_analysis.R) and 561 variables (listed in the file features.txt).  For each case, there is a record of the subject (an integer from 1 to 30) and of an activity (one of 6), so the cases can be grouped in to 30 x 6 = 180 groups based on subject and activity.

The data set tidydtata.txt is based on a subset of 66 of the variables.  These are the 66 among the 561 original variables that contain in their names either of the strings "mean()" or "std()" indicating computed variables. This selection is a response to requirements of the Coursera project specifications, which is also the reason none of the variables in the intertial signal files are considered.

The variables can be obtained from the following list:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Each of the listed names above corresponds to 6 or 2 variables in tidydataset in the following manner. 

* For the names ending in XYZ, there are 6 variables that follow the pattern of tBodyAcc-XYZ:

tBodyAcc_mean_X

tBodyAcc_mean_Y

tBodyAcc_mean_Z

tBodyAcc_std_X

tBodyAcc_std_Y

tBodyAcc_std_Z

* For the names ending in Mag, there are 2 variables that follow the pattern of tBodyAccMag:

tBodyAccMag_mean

tBodyAccMag_std

The product of tidydata.txt is a data set consisting of 180 rows and 69 columns. 

column 1: subject.  a categorical variable with levels integer  from 1 to 30.  Indicate the subject (person) on whom measurements were taken.

column 2: action.  a categorical variable with six levels: Lay, Sit, Stand, Walk, WalkDown, WalkUp.  Indicates the action engaged in when the measurements were taken.

Column 3: combo: a categorical variable with 180 levels, the cross product of the subject and action variables.  For example, level 1:Stand indicate subject 1, action Stand.  There is one level for every row in tidydata.txt

Columns 4 through 69: 66 quantitative variables. The values in each row are the mean values of the originally chosen 66 out of 561 variables, averaged for each combo of subject and action. 




 