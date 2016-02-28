

## Description

Additional information about the variables, data and transformations used in the course project.

## Source Data 
Description of the data:
<a href = http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
Human Activity Recognition Using Smartphones</a><br><br>
Data set:<br>
<a href = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip > Download .zip </a></p>

## Data information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#### Information about attributes.

For each record it is provided.

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### Part 1 - Merging data sets
After unzipping files next files were opened and data tables were created:

- features.txt (variable 'features')
- activity_labels.txt (variable 'typeActivity')
- subject_train.txt (variable 'subjectsT')
- x_train.txt (variable 'xTrain')
- y_train.txt (variable 'yTrain')
- subject_test.txt (variable 'subjectsTs')
- x_test.txt (variable 'xTest')
- y_test.txt (variable 'yTest')

Than columns in data tables were renamed and data combined.

####Part 2 - Extracting columns with mean and StdDev for each measurment

I retrieved names from columns and created a vector variable 'naMes'. With the 'grepl' received new logical vector 'neededCol' with needed column names. Last I have got necessary data in a new variable 'ndData'.

####Part 3 - Use descriptive activity names to name the activities in the data set

Here 'ndData' and 'typeActivity' had been merged and a new variable 'mergedData' created.

####Part 4 - Appropriately label the data set with descriptive variable names.

Variable 'naMes' had been modified (because data was changed according to Part3) and with the help of 'for' loop names had been renamed according to description. Column names in variable 'mergedData' had been modified. 

####Part 5 - Creating second independent tidy data.
Firstly a new variable 'final' was created without "activityType" column. Than 'mean' was calculated with the help of 'aggregation' function and placed in new variable 'tidyData'. After this tidyData was merged with 'typeActivity' and new tidyData.txt was created and saved.
