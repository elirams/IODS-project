# Name: Elisabet Rams 
# Date: 16/11/2017
# File description: Exercise on logistic regression
# Source of the data: UCI Machine Learning Repository, Student Performance Data
# Link to data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# We read the data files:

math <- read.csv("C:/Users/Elisabet/Desktop/ELI/MASTER'S DEGREE/Open Data Science/GitHub/IODS-project/IODS-project/Data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("C:/Users/Elisabet/Desktop/ELI/MASTER'S DEGREE/Open Data Science/GitHub/IODS-project/IODS-project/Data/student-por.csv", sep = ";", header = TRUE)

# We explore the structure and dimensions:

str(math)
dim(math)

str(por)
dim(por)

# Join the two datasets, keeping only the students present in both data sets:

library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(math, por, by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet"), suffix = c(".math", ".por"))

# To look at the joined data:
colnames(math_por)
glimpse(math_por)

# To combine the "duplicated" answers in the joined data (for those variables that we have not used for joining the data):

# create a new data frame with only the joined columns
alc <- select(math_por, one_of("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
colnames(alc)
glimpse(alc)

#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data:

library(ggplot2)
alc <- mutate (alc, alc_use = (Dalc + Walc)/2)

# New logical column "high_use", which is TRUE if alc_use > 2

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

# Save data:

write.csv(alc, file = "C:/Users/Elisabet/Desktop/ELI/MASTER'S DEGREE/Open Data Science/GitHub/IODS-project/IODS-project/alc.csv", row.names = FALSE)