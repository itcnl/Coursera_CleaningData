CodeBook for Tidy Data
=====


## Description of Raw Data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## Step-by-step Tidying of Data

### Pre-step
The script starts off from having downloaded the .zip containing measurement data around **Human Activity Recognition Using Smartphones Dataset** to the local folder. The working directory should point towards the folder immediately unzipped from the file.

**Note**: One may need to reset the working directory at the top of the script to one's own working directory.

### Step 1: Merge the dataset for training and test
The script loads in *features.txt* and *activity_labels_txt*, labels their respective columns, and stores them as data frames *features* and *act_labels*. The object *features* represents the variables measured in the x_dataset. The object *act_labels* summarizes the activity ID in the y_dataset and map it against recognizable activity meaningful for a human reader.

The script goes on to load in the x_dataset (measurement results), y_dataset (activity recorded), and subject_dataset. Each of the dataset consists of a training data subset and test data subset. The script first combines the columns of each data subset by SubjectID, ActivityID, and then measurement results. After that, the observations in training and test data subsets are combined into a single large dataset, for a total of 10,299 observations and 563 variables (2 of which are SubjectID and ActivityID). The end result is stored as a data frame *merged_data*.

### Step 2: Extract measurements on the mean and standard deviation
The Code Book describes the mean to have *-mean()* and standard deviation to have *-std()* in its labeling. The script uses the `grep` function to match an or-condition using `|` for mean and std to be matched, and returns their respective values based on the order of variables. This is stored into *colSelection* variable. Note that **meanFreq** and **angle-related variables** are not specifically mean-related and is **excluded** in the selection.

The *colSelection* variable is further enriched with the first and second columns containing the Subject ID and Activity ID. Lastly, the column-filtered dataset is stored as a data frame *filtered_data*.

### Step 3: Add activity name
The activity name is contained in the *act_labels* and needs to be merged into this "filtered_data*, so that each observation of the *filtered_data* contains the descriptive activity name. The `merge` function is used to merge `x = *filtered_data*` and `y = *act_labels*`, by the matching of ActivityID field, and all observations are to be merged.

The outcome is stored in the data_frame *merged_actdata*.

### Step 4: Label dataset with descriptive names
As the dataset contains multiple measurement, and abbreviated, they are descriptive enough in their own sense in conjunction with the Code Book. For this step, the leading *t* for time and *f* for frequency in the variable names are fleshed out to spell *time* and *freq* respectively. Judgment is used so that each variable names don't end up too long and also end up uneasily readable.

The `gsub` function is used to find the leading *t* and *f* in the column labels, and replace them with *time* and *freq*

### Step 5: Create a tiny dataset by averaging unique subject-activity identifiers
Every column in the current *merged_actdata* contains numerical-like values except the column Activity that contains string/character. Therefore, this column is factorized to enable aggregation at the next step.

The `aggregate` function is used to apply the function `mean` by unique **Activity** and **SubjectID**.
After the aggregation is done, the tidy dataset is further cleaned up to remove legacy of the aggregation and to remove the last column containing the previous character type describing the Activity.

Lastly, the tidy dataset is written out as a *TidyData.txt* in the working directory.

## Description of Tidy Data
The tidy data contains 68 fields in total, with the first two being an identification of the activity type, and the subject identification. There are a total of 180 observations, where 30 subjects with each having 6 types of activities.
Each field is comma-separated. The values in the dataset are either mean or standard deviation, aggregated across each subject-activity combination. Specifically, it consists of the following.

1. Activity
2. SubjectID
3. time-BodyAcc-mean()-X
4. time-BodyAcc-mean()-Y
5. time-BodyAcc-mean()-Z
6. time-BodyAcc-std()-X
7. time-BodyAcc-std()-Y
8. time-BodyAcc-std()-Z
9. time-GravityAcc-mean()-X
10. time-GravityAcc-mean()-Y
11. time-GravityAcc-mean()-Z
12. time-GravityAcc-std()-X
13. time-GravityAcc-std()-Y
14. time-GravityAcc-std()-Z
15. time-BodyAccJerk-mean()-X
16. time-BodyAccJerk-mean()-Y
17. time-BodyAccJerk-mean()-Z
18. time-BodyAccJerk-std()-X
19. time-BodyAccJerk-std()-Y
20. time-BodyAccJerk-std()-Z
21. time-BodyGyro-mean()-X
22. time-BodyGyro-mean()-Y
23. time-BodyGyro-mean()-Z
24. time-BodyGyro-std()-X
25. time-BodyGyro-std()-Y
26. time-BodyGyro-std()-Z
27. time-BodyGyroJerk-mean()-X
28. time-BodyGyroJerk-mean()-Y
29. time-BodyGyroJerk-mean()-Z
30. time-BodyGyroJerk-std()-X
31. time-BodyGyroJerk-std()-Y
32. time-BodyGyroJerk-std()-Z
33. time-BodyAccMag-mean()
34. time-BodyAccMag-std()
35. time-GravityAccMag-mean()
36. time-GravityAccMag-std()
37. time-BodyAccJerkMag-mean()
38. time-BodyAccJerkMag-std()
39. time-BodyGyroMag-mean()
40. time-BodyGyroMag-std()
41. time-BodyGyroJerkMag-mean()
42. time-BodyGyroJerkMag-std()
43. freq-BodyAcc-mean()-X
44. freq-BodyAcc-mean()-Y
45. freq-BodyAcc-mean()-Z
46. freq-BodyAcc-std()-X
47. freq-BodyAcc-std()-Y
48. freq-BodyAcc-std()-Z
49. freq-BodyAccJerk-mean()-X
50. freq-BodyAccJerk-mean()-Y
51. freq-BodyAccJerk-mean()-Z
52. freq-BodyAccJerk-std()-X
53. freq-BodyAccJerk-std()-Y
54. freq-BodyAccJerk-std()-Z
55. freq-BodyGyro-mean()-X
56. freq-BodyGyro-mean()-Y
57. freq-BodyGyro-mean()-Z
58. freq-BodyGyro-std()-X
59. freq-BodyGyro-std()-Y
60. freq-BodyGyro-std()-Z
61. freq-BodyAccMag-mean()
62. freq-BodyAccMag-std()
63. freq-BodyBodyAccJerkMag-mean()
64. freq-BodyBodyAccJerkMag-std()
65. freq-BodyBodyGyroMag-mean()
66. freq-BodyBodyGyroMag-std()
67. freq-BodyBodyGyroJerkMag-mean()
68. freq-BodyBodyGyroJerkMag-std()

The field "Activity" can only take on the following values.

1. LAYING
2. SITTING
3. STANDING
4. WALKING
5. WALKING DOWNSTAIRS
6. WALKING UPSTAIRS

The field "SubjectID" ranges from 1-30, representing the subject being studied.

The remaining fields will follow the definition in the initial code book. The leading word can either be:
1. time - representing time
2. freq - representing frequency
The values in the dataset are either averages (mean) or standard deviations, and are appropriately labeled.








