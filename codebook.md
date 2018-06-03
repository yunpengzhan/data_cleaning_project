1.x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
2.x_data, y_data and subject_data merge the previous datasets to further analysis.
3.features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
4.A similar approach is taken with activity names through the activities variable.
5.all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
