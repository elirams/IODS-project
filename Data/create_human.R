# Name: Elisabet Rams 
# Date: 16/11/2017
# File description: Exercise 4
# Source of the data: Introduction to Open Data Science course through MOOC.

# We read the data files:

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Look the structure, dimensions and summaries:

str(hd)
dim(hd)
summary(hd)

###########################################################

str(gii)
dim(gii)
summary(gii)


# Rename variables with shorter names:

colnames(hd)[1] <- "HDI.rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "lifexp"
colnames(hd)[5] <- "yr.eduexp"
colnames(hd)[6] <- "meanyr.edu"
colnames(hd)[7] <- "GNI.cap"
colnames(hd)[8] <- "GNIrank-HDIrank"


colnames(gii)[1] <- "GII.rank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "matermor"
colnames(gii)[5] <- "adobirth"
colnames(gii)[6] <- "repreparl"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labforceF"
colnames(gii)[10] <- "labforceM"

colnames(hd)
colnames(gii)

# Mutate the "Gender inequality" data to create 2 new variables. First is the ratio edu2F/edu2M. Second is labforceF/labforceM.

gii <- mutate(gii, ratio.edu2 = gii$edu2F/gii$edu2M)
gii <- mutate(gii, ratio.labforce = gii$labforceF/gii$labforceM)

colnames(gii)
summary(gii$ratio.edu2)
summary(gii$ratio.labforce)

# Join the two datasets using variable country as the identifier:

library(dplyr)
human <- inner_join(hd, gii, by = "country")

# Overview the new dataset:

glimpse(human)

# Save the new dataset:

setwd("C:/Users/Elisabet/Desktop/ELI/MASTER'S DEGREE/Open Data Science/GitHub/IODS-project/IODS-project/Data")
write.table(human, file = "human.csv", sep = ",", col.names = TRUE)


