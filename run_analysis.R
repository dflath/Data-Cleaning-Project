setwd("/Users/flath/Google Drive/Coursera/DataScience/DataCleaning/dataCleaningProject")

## Make sure we have the data files

if (!file.exists("UCI HAR Dataset")) {    
        if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {   
                stop("was expecting HAR Dataset folder or zip file")      
        } else {        
                unzip("getdata_projectfiles_UCI HAR Dataset.zip")    
        }    
}

## Read in labels 

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Read in data from the test sets 

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# testfilelist <- list.files(path="./UCI HAR Dataset/test/Inertial Signals")  
# testdatalist <- lapply(testfilelist, function(x) read.table(paste("./UCI HAR Dataset/test/Inertial Signals/", x  , sep=""))) 

## Read in data from the training sets xs

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# trainfilelist <- list.files(path="./UCI HAR Dataset/train/Inertial Signals")  
# traindatalist <- lapply(trainfilelist, function(x) read.table(paste("./UCI HAR Dataset/train/Inertial Signals/", x  , sep="")))

######  Deal with the activity vectors

active<-c("Walk", "WalkUp", "WalkDown", "Sit","Stand", "Lay")  # Descriptive names

testActivity <- as.character(vector())
for (n in 1:nrow(y_test)) { 
        testActivity[n] <- active[y_test[n,1]]
}

y_test <-cbind(y_test, testActivity)

trainActivity <- as.character(vector())
for (n in 1:nrow(y_train)) { 
        trainActivity[n] <- active[y_train[n,1]]
}

y_train <- cbind(y_train, trainActivity)

## change the names of the variables 

names(X_test) <- features[,"V2"]
names(X_test) <- gsub("-", "_", names(X_test), fixed=TRUE)
names(X_train) <- features[, "V2"]
names(X_train) <- gsub("-", "_", names(X_train), fixed=TRUE)

## find the features that involve mean or std

meanFeatures <-grepl("mean()",as.character(features[,"V2"]))
stdFeatures <-grepl("std()",as.character(features[,"V2"]))
goodFeatures <- meanFeatures|stdFeatures

## keep only the good features and give legal names to the variables

X_testgood <- X_test[,goodFeatures]
X_traingood <-X_train[,goodFeatures]  
names(X_testgood) <- gsub("()", "", names(X_testgood), fixed=TRUE )
names(X_traingood) <-gsub("()", "", names(X_testgood), fixed=TRUE )

## insert subject and activity variables into the data frames

X_testAll <- cbind(subject = as.factor(subject_test[,"V1"]), action = y_test[,"testActivity"], X_testgood)

X_trainAll <- cbind(subject = as.factor(subject_train[,"V1"]), action = y_train[,"trainActivity"], X_traingood)

## combine the two datasets

X_avg_std <- rbind(X_testAll, X_trainAll)

X_ordered <- X_avg_std[order(X_avg_std$subject), ]

## Establish cross product of subject and action as a factor

X_avg_std$group <- with(X_avg_std, paste(subject, action, sep = ":"))

## Calculate averages within groups

Xsplit <- split(X_avg_std, X_avg_std$group)

groupnames <- names(Xsplit)

drops <- c("subject", "action", "group")

for(n in 1:length(Xsplit)) 
groupAvgs <- data.frame() 
subject1 <- character()
action1 <- character()


for(n in 1:length(Xsplit) ) {
        subject1 <- c(subject1, as.character(Xsplit[[n]][1,"subject"]))
        action1 <- c(action1, as.character(Xsplit[[n]][1,"action"]))
        temp <- Xsplit[[n]][, !(names(Xsplit[[1]]) %in% drops)]
        temp2 <- as.data.frame(t(colSums(temp)/nrow(temp)))
        groupAvgs <- rbind(groupAvgs, temp2)
}
groupAvgs <- cbind(subject = subject1, action = action1, combo = groupnames, groupAvgs)

tidyDataSet <- groupAvgs[order(as.numeric(groupAvgs$subject), groupAvgs$action),]
 
write.csv(tidyDataSet, file = "./tidydata.csv")
 
# failed effort that would have been beautiful if it had worked for more than  one column.
# library(plyr)
# tidyDataSet <- ddply(X_avg_std, c(.(subject), .(action) ), summarize, mean = mean(tBodyAcc_mean_X))



