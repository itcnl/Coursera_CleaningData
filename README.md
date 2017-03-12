# ReadMe for Coursera Cleaning Data Project

This is a project involving the cleaning of "Human Activity Recognition Using Smartphones Dataset" data. The source data can be found in the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The data is unzipped, and analyzed using R code, leading to a clean, concise dataset as an output. The 'README.txt' and 'features_info.txt' files in the zipped document contains description of the original dataset.

The script and code book in this repo describe the transformation process in the cleaning and creation of a tidy data set.


## High level script description
This script *"run_analysis.R"* is an R-script that reads in a training and test data set respectively. The measured variables and organization of the datasets are described in the original Code Book ('README.txt' and 'features_info.txt').

In each dataset, the training data and test data are first organized (in column) by Subject, Activity, and the measurement values, and subsequently combined into a single large dataset. Only columns of interest are selected, namely those containing *mean* or *standard deviation*. The relevant columns are filtered out, and the label names are further enriched. The activity code-idenfifier is also mapped into descriptive activity name. Finally, the data is aggregated to take the average across each subject's activity, and presented in a concise summary. The output is a *TidyData.txt* file, which contains the aggregated measured mean and standard deviation for each subject's activity.


## High level code book description
A detailed description of the script and transformation process is written in the code book. This can be found in the file *"CodeBook.md"* saved in this repo.

## High level output (TidyData.txt) description
This is an output created by running the *"run_analysis.R"* file in this repo. The data within this file is described in the *"CodeBook.md"* saved in this repo.


