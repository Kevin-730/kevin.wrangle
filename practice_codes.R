# -------------------------------
# Mini Project: Student Attendance Cleaning
# -------------------------------

# 1. Load necessary library
library(dplyr)   # optional but helpful for data manipulation
library(readr)   # for reading CSV with UTF-8 safely

# 2. Import raw CSV file
data <- read_csv("student_attendance_raw.csv")  # UTF-8 safe

# 3. Clean Attendance column
data$attendance <- gsub("%", "", data$attendance)  # remove % sign
data$attendance <- tolower(data$attendance)       # lowercase for text matching
data$attendance <- ifelse(data$attendance == "ninety", 90,
                          ifelse(data$attendance == "eighty", 80,
                                 as.numeric(data$attendance)))  # convert numbers
# Fill missing attendance with mean
data$attendance[is.na(data$attendance)] <- mean(data$attendance, na.rm = TRUE)

# 4. Clean Age column
data$age <- as.numeric(data$age)  # ensure numeric
data$age[is.na(data$age)] <- median(data$age, na.rm = TRUE)

# 5. Standardize Gender column
data$gender <- tolower(data$gender)
data$gender[data$gender %in% c("f", "female")] <- "Female"
data$gender[data$gender %in% c("m", "male")] <- "Male"
data$gender[data$gender==""] <- NA  # optional: handle blanks

# 6. Optional: reorder columns or fix formatting
data <- data %>% select(student_id, name, attendance, gender, age)

# 7. Save cleaned dataset
write_csv(data, "student_attendance_clean.csv")  # UTF-8 safe

# 8. Preview cleaned data
print(data)

