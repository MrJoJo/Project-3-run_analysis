This script tidies up the sample data provided for the Coursera Project - run_analysis.R

The data is from 
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
==================================================================

Load the necessary library 
     library(data.table)

Make list of files to get using list.files()

Getting training and test set using read.table (file_name, sep="") 

Merge with cbind()

Relabel columns with feature labels using colnames().
          
Set vector object to only those columns I want, ie mean and std.
     meanStd_columns <- c(1:7, 43:48,  83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 268:273, 347:352, 426:431, 505:507, 518:519, 531:532, 544:545, 557:563)
     
Relabel to descriptive labels for all columns
 
Change from data.frame to data.table for easier calculation of mean of each column.

Write indexed and sorted file as text.
 
