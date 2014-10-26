##########################################################################################################
#
# Filename:     run_analysis.R
# Author:       Chan Sing Eu
#
# Assumptions:
# 1. The source dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
#    has been downloaded and unzipped into the "UCI HAR Dataset" subfolder of the working directory.
#
# Description:
# This script will does the following: 
# 1. Merges the training and test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
##########################################################################################################


# Clean up workspace
rm(list=ls())

# Check is dplyr library is installed and loaded
if (!require("dplyr")) {
        install.packages("dplyr")
}

require("dplyr")

# Check if "UCI HAR Dataset" subfolder is found, else stop execution
if (file.exists("./UCI HAR Dataset")) {
        # 1. Merges the training and the test sets to create one data set.
        
        # Import features.txt, activity_labels.txt, subject_train.txt, X_train.txt, y_train.txt
        features     = read.table('UCI HAR Dataset/features.txt',header=FALSE); 
        activityLabels = read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE); 
        subjectTrain = read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
        xTrain       = read.table('UCI HAR Dataset/train/X_train.txt',header=FALSE); 
        yTrain       = read.table('UCI HAR Dataset/train/y_train.txt',header=FALSE); 
        
        # Assign column names to the imported training data
        colnames(activityLabels)  = c('activityId','activityLabel');
        colnames(subjectTrain)  = "subjectId";
        colnames(xTrain)        = features[,2]; 
        colnames(yTrain)        = "activityId";
        
        # Merge subjectTrain, xTrain and yTrain into a complete training set
        trainingData = cbind(subjectTrain,xTrain, yTrain);
        
        # Import test data (subject_test.txt, X_test.txt, y_test.txt)
        subjectTest = read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
        xTest       = read.table('UCI HAR Dataset/test/X_test.txt',header=FALSE); 
        yTest       = read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE); 
        
        # Assign column names to the imported test data
        colnames(subjectTest) = "subjectId";
        colnames(xTest)       = features[,2]; 
        colnames(yTest)       = "activityId";
        
        
        # Merge subjectTest, xTest and yTest into a complete test set
        testData = cbind(subjectTest,xTest,yTest);
        
        
        # Merge training and test sets into one complete data set
        completeData = rbind(trainingData,testData);
        
        # Create a vector for the column names from the completeData
        colNames  = colnames(completeData); 
        
        # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        
        # Create a logicalVector that contains TRUE values for the subjectId, activityId, mean() and std() 
        logicalVector = (grepl("subjectId",colNames) | grepl("activityId",colNames) | (grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames)) | grepl("-std",colNames));
        
        # Subset completeData table based on the logicalVector to keep only desired columns
        completeData2 = completeData[logicalVector==TRUE];
        
        # 3. Uses descriptive activity names to name the activities in the data set
        
        # Merge the completeData2 set with the acitivityLabels table to include descriptive activity names
        completeData3 = merge(completeData2,activityLabels,by='activityId',all.x=TRUE);
        
        # Update the colNames vector to include new column names 
        colNames  = colnames(completeData3); 
        
        # 4. Appropriately labels the data set with descriptive variable names. 

        for (i in 1:length(colNames)) 
        {
                colNames[i] = gsub("^(t)","time",colNames[i])
                colNames[i] = gsub("^(f)","freq",colNames[i])
                colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])   
                colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
                colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
                colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
                colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
                colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
                colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
                colNames[i] = gsub("-std","StdDev",colNames[i])
                colNames[i] = gsub("-mean","Mean",colNames[i])
                colNames[i] = gsub("\\()","",colNames[i])
        };
        
        # Assign the new descriptive column names to the completeData3 set
        colnames(completeData3) = colNames;
        
        # 5. From completeData3, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
        
        # Create completeData4 without the activityLabel column
        completeData4  = completeData3[,names(completeData3) != 'activityLabel'];
        
        # Summarize completeData4 to include the mean of each variable for each activity and each subject
        tidyData    = aggregate(completeData4[,names(completeData4) != c('activityId','subjectId')],by=list(activityId=completeData4$activityId,subjectId = completeData4$subjectId),mean);
        
        # Add activityLabels to tidyData
        tidyData2    = merge(tidyData,activityLabels,by='activityId',all.x=TRUE);
        
        # Arrange tidyData2 by activityId, subjectId
        tidyData3 = arrange(tidyData2, activityId, subjectId)
        
        # Export the tidyData set 
        write.table(tidyData3, './tidy.txt',row.names=FALSE,sep=',');
        
} else {
        stop("UCI HAR Dataset subfolder is not found in current working directory!");
}