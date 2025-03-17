library(boot)
library(glmnet)
install.packages("dplyr")  # Run this once if you haven't installed dplyr
library(dplyr)


data2023 <- read.csv("2023.csv", stringsAsFactors = T, skip=17)
data2022 <- read.csv("2022.csv", stringsAsFactors = T, skip=17)
data2021 <- read.csv("2021.csv", stringsAsFactors = T, skip=17)
data2020 <- read.csv("2020.csv", stringsAsFactors = T, skip=17)
data2019 <- read.csv("2019.csv", stringsAsFactors = T, skip=17)
data2018 <- read.csv("2018.csv", stringsAsFactors = T, skip=17)
data2017 <- read.csv("2017.csv", stringsAsFactors = T, skip=17)
data2016 <- read.csv("2016.csv", stringsAsFactors = T, skip=17)
data2015 <- read.csv("2015.csv", stringsAsFactors = T, skip=17)
location <- read.csv("uk_universities_locations.csv", stringsAsFactors = T)

# List of datasets
# merge two data frames by ID
# List of datasets
# List of datasets
data_list <- list(data2023, data2022, data2021, data2020, data2019, 
                  data2018, data2017, data2016, data2015)

# Combine all datasets, keeping only common HE.provider values
total <- Reduce(function(x, y) semi_join(x, y, by = "HE.provider"), data_list)

# Stack the filtered datasets
total <- do.call(rbind, data_list)

colnames(total)[colnames(total) == "HE.provider"] <- "Name"

write.csv(total, "uni_data.csv", row.names = FALSE)

finished <- merge(total, location, by="Name")

write.csv(finished, "uni_data.csv", row.names = FALSE)

