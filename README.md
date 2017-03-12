# ReadMe for Coursera Cleaning Data Project

## High level script description
This script reads in a training and test data set respectively. The measured variables and organization of the datasets are described in the Code Book.
In each dataset, the data is first organized (in column), by Subject, Activity, and the measurement values.


## Pre-step
The script starts off from having downloaded the .zip containing measurement data around "Human Activity Recognition Using Smartphones Dataset" to the local folder. The working directory should point towards the folder immediately unzipped from the file.

...Note: One may need to reset the working directory at the top of the script to one's own working directory.

## Step 1: Merge the dataset for training and test
The script loads in *features.txt* and *activity_labels_txt*, labels their respective columns, and stores them as data frames *features* and *act_labels*. The object *features* represents the variables measured in the x_dataset. The object *act_labels* summarizes the activity ID in the y_dataset and map it against recognizable activity meaningful for a human reader.

The script goes on to load in the x_dataset (measurement results), y_dataset (activity recorded), and subject_dataset. Each of the dataset consists of a training data subset and test data subset. The script first combines the columns of each data subset by SubjectID, ActivityID, and then measurement results. After that, the observations in training and test data subsets are combined into a single large dataset, for a total of 10,299 observations and 563 variables (2 of which are SubjectID and ActivityID). The end result is stored as a data frame *merged_data*.

## Step 2: Extract measurements on the mean and standard deviation
The Code Book describes the mean to have *-mean()* and standard deviation to have *-std()* in its labeling. The script uses the `grep` function to match an or-condition using `|` for mean and std to be matched, and returns their respective values based on the order of variables. This is stored into *colSelection* variable. Note that **meanFreq** and **angle-related variables** are not specifically mean-related and is **excluded** in the selection.

The *colSelection* variable is further enriched with the first and second columns containing the Subject ID and Activity ID. Lastly, the column-filtered dataset is stored as a data frame *filtered_data*.

## Step 3: Add activity name
The activity name is contained in the *act_labels* and needs to be merged into this "filtered_data*, so that each observation of the *filtered_data* contains the descriptive activity name. The `merge` function is used to merge `x = *filtered_data*` and `y = *act_labels*`, by the matching of ActivityID field, and all observations are to be merged.
..The outcome is stored in the data_frame *merged_actdata*.

## Step 4: Label dataset with descriptive names
As the dataset contains multiple measurement, and abbreviated, they are descriptive enough in their own sense in conjunction with the Code Book. For this step, the leading *t* for time and *f* for frequency in the variable names are fleshed out to spell *time* and *freq* respectively. Judgment is used so that each variable names don't end up too long and also end up uneasily readable.
..The `gsub` function is used to find the leading *t* and *f* in the column labels, and replace them with *time* and *freq*

## Step 5: Create a tiny dataset by averaging unique subject-activity identifiers
Every column in the current *merged_actdata* contains numerical-like values except the column Activity that contains string/character. Therefore, this column is factorized to enable aggregation at the next step.
..The `aggregate` function is used to apply the function `mean` by unique **Activity** and **SubjectID**.
After the aggregation is done, the tidy dataset is further cleaned up to remove legacy of the aggregation and to remove the last column containing the previous character type describing the Activity.

Lastly, the tidy dataset is written out as a *TidyData.txt* in the workind directory.






