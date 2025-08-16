# run_analysis.R
library(dplyr)

# Step 1: Merge training and test datasets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

# Load test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$name)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")

# Load train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$name)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")

# Combine data
merged_data <- rbind(
  cbind(subject_test, y_test, x_test),
  cbind(subject_train, y_train, x_train)
)

# Step 2: Extract mean and standard deviation measurements
tidy_data <- merged_data %>%
  select(subject, activity_id, contains(".mean."), contains(".std."))

# Step 3: Add descriptive activity names
tidy_data$activity_id <- activity_labels[tidy_data$activity_id, "activity"]

# Step 4: Label variables descriptively (renaming columns)
colnames(tidy_data) <- gsub("^t", "Time_", colnames(tidy_data))
colnames(tidy_data) <- gsub("^f", "Frequency_", colnames(tidy_data))
colnames(tidy_data) <- gsub("\\.mean\\.", "_Mean_", colnames(tidy_data))
colnames(tidy_data) <- gsub("\\.std\\.", "_STD_", colnames(tidy_data))
colnames(tidy_data) <- gsub("BodyBody", "Body", colnames(tidy_data))
colnames(tidy_data)[2] <- "activity"

# Step 5: Create final tidy dataset with averages
final_tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean))

# Save output
write.table(final_tidy_data, "tidy_data.txt", row.names = FALSE)
