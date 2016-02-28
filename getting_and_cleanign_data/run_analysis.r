library(tydyr)
library(dplyr)
library(data.table)

# Part 1 - Merge data sets

setwd("C:/Users/user/Documents/GitHub/datasciencecoursera/getting_and_cleanign_data/UCI HAR Dataset")

# Reading files in tables 
# About features in sets
features <- read.table("./features.txt", header = FALSE)

# About activity
typeActivity<- read.table('./activity_labels.txt', header = FALSE)

# About training
subjectsT<- read.table('./train/subject_train.txt', header = FALSE)
xTrain <- read.table('./train/x_train.txt', header=FALSE)
yTrain <- read.table('./train/y_train.txt', header=FALSE)

# Naming columns according to info
names(typeActivity)<- c("activityID", "activityType")
names(subjectsT)<- "subjectID"
names(xTrain)<- features[,2]
names(yTrain)<- "activityID"

# Training data complete
training<-cbind(yTrain, subjectsT, xTrain)

# About testing
subjectsTs<- read.table('./test/subject_test.txt', header = FALSE)
xTest <- read.table('./test/x_test.txt', header=FALSE)
yTest <- read.table('./test/y_test.txt', header=FALSE)

names(subjectsTs) <- "subjectID"
names(xTest) <- features[,2]
names(yTest) <- "activityID"

# Data about tests

tests <-cbind(yTest,subjectsTs,xTest)

# Now I have data about testing and training so I combine them
finalT<- rbind(training, tests)

# Part 2 - Extract only the measurements on the mean and standard deviation for each measurement

#Retrieving names
naMes<-names(finalT)

#Creating a vector with TRUE or FALSE
neededCol <- (grepl("activity..", naMes)|grepl("subject..", naMes)| grepl("-mean..",naMes) & !grepl("-meanFreq..",naMes) & !grepl("mean..-",naMes) | grepl("-std..",naMes) & !grepl("-std()..-",naMes) == "TRUE")

# Retrieving needed data
ndData<- finalT[neededCol == TRUE]

# Part 3 - Use descriptive activity names to name the activities in the data set

mergedData<-merge(ndData, typeActivity, by = "activityID", all.x = TRUE)

# Part 4 - Appropriately label the data set with descriptive variable names.

#Retrieving names (one more time, because data changed in Part 3)

naMes <- names(mergedData)

# Renaming 
for (name in 1:length(naMes)) {
        naMes[name] <- gsub ("\\()","",naMes[name])
        naMes[name] = gsub("-std$","StandartDev",naMes[name])
        naMes[name] = gsub("-mean","Mean",naMes[name])
        naMes[name] = gsub("^(t)","Time",naMes[name])
        naMes[name] = gsub("^(f)","Frequency",naMes[name])
        naMes[name] = gsub("([Gg]ravity)","Gravity",naMes[name])
        naMes[name] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",naMes[name])
        naMes[name] = gsub("[Gg]yro","Gyroscope",naMes[name])
        naMes[name] = gsub("AccMag","AccMagnitude",naMes[name])
        naMes[name] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",naMes[name])
        naMes[name] = gsub("JerkMag","JerkMagnitude",naMes[name])
        naMes[name] = gsub("GyroMag","GyroMagnitude",naMes[name])
        naMes[name] = gsub("[Mm]ag","Magnitude",naMes[name])
}

# Applying names to columns
names(mergedData) <- naMes

# Part 5 - create a second, independent tidy data 
# set with the average of each variable for each activity and each subject
final<-select(mergedData, -contains("activityType"))
tidyData = aggregate(final[,names(final) != c('activityID','subjectID')],by=list(activityID=final$activityID,subjectId = final$subjectID),mean);

# Merging the tidyData with activityType to include activity names
tidyData = merge(tidyData,typeActivity,by='activityID',all.x=TRUE);

# Saving
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')