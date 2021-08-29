
library(dplyr)

current_exam <- "Math"

setwd("C:/Users/geethika.wijewardena/Workspace/R/R Dynamic column names and variables")

dat_raw <- read.csv("Test Scores.csv", stringsAsFactors = F, na.strings = c(""))

#--------------------------------------------------------
# 1. Select data from a dataframe where the column name is dynamically generated using a parameter
# Get the scores of the current exam
dat_current <- dat_raw %>% select(Name, !!as.name(paste0(current_exam, "_Score")))

#--------------------------------------------------------
# 2. Generate the needed columns dynamically and assign them to variables that are also generated dynamically using assign()
# Get scores of the other exams into seperate dataframes
for (exam in c("Math", "Science", "English")){
  if (exam != current_exam){
    dat_temp <- dat_raw %>% select(Name, !!as.name(paste0(exam,"_Score")), !!as.name(paste0(exam,"_Rank")))
    assign(paste0("dat_", exam), dat_temp)
  }
}

#--------------------------------------------------------
# Get all the columns of other exams
other_exams <- dat_raw %>% select(-starts_with(current_exam))

# 2. Generate the needed columns dynamically and assign them to variables that are also generated dynamically using := 
# For each other exam generate the Result column based on score
for (exam in c("Math", "Science", "English")){
  if (exam != current_exam){
    result_col = paste0(exam, "_Result")
    other_exams <- other_exams %>% 
      mutate(!!as.name(result_col) := ifelse(!!as.name(paste0(exam, "_Score")) > 60, "Pass", "Fail"))
  }
}



