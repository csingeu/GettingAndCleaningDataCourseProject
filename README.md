# Getting and Cleaning Data Course Project

## 1. Overview
This is the repo for the course project for Getting and Cleaning Data Course. It serves to demonstrate the collection and cleaning of a tidy dataset that can be used for subsequent analysis. 

## 2. Source Data
The dataset used is "Human Activity Recognition Using Smartphones Data Set".
For more information about the dataset, refer to the [CookBook.md](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/CookBook.md) in this repo.

## 3. Tidy Data
Refer to [tidy.txt](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/tidy.txt)

## 4. Repo Contents: 
* **README.md** The README file for this repo. 
* **[CodeBook.md](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/CookBook.md)** The code book that describes the variables, the data, and any transformations or work that is performed to clean up the data
* **[run_analysis.R](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/run_analysis.R)** The R script contains the steps to process the data and generate the required tidy dataset for submission. 
* **[tidy.txt](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/tidy.txt)** The text file contains the required tidy dataset for submission.  

## 5. Instructions
* Download and unzip [source data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Copy "UCI HAR Dataset" folder (including subfolders & files) to current working directory
* Download [run_analysis.R](https://github.com/csingeu/GettingAndCleaningDataCourseProject/blob/master/run_analysis.R) script into current working directory.
* Execute run_analysis.R script by typing:
	````
	source("run_analysis.R")
	````
* The required output file will be named "tidy.txt" in the current working directory.
	
## 6. System Information
* Instructions and script were tested OK on Windows 7 (32-bit) / RStudio 0.98.1049 / R version 3.1.1
* Should also work on other equivalent system configurations with R version 3.1.1 

## 7. Dependencies
* Requires **dplyr** package
