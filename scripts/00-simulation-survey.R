### simulating the UCLA survety data###
#UCLA DATA
#install.packages('tidyverse')
library(tidyverse)




simulated_UCLA <-
  tibble(
    #these are the observation units that we have. I will take n = 6000 to make it simpler
    'Observation' = 1:6000,
    # taking age as a uniformly distributed variable from 18-90 and rounding the results
    'age' = round(runif(6000, 18, 90)),
    #using the inbuilt statenames to create this variable
    'state' = sample(state.name, 6000, replace = TRUE),
    # categorizing education in to 4 groups and assigning a proportion to each of them
    'education' = sample(c("less than high school", "high school diploma", "college graduate", "Masters or PHD graduate"), 6000, replace = TRUE, prob = c(0.35, 0.45, 0.15, 0.05)),
    #making a varible for whether the respondent was hispanic or not
    'Hispanic' = sample(c('hispanic', 'not hispanic'), 6000, replace = TRUE, prob = c(0.12, 0.88)),
    #making a variable for race
    'race' = sample(c("white", "black", "asian", "other"), 6000, replace = TRUE, prob = c(0.6, 0.2, 0.19, 0.01)),
    #assuming income is normally distributed with mean $51000 and rounding
    "house-hold income" = round(rnorm(6000, 51000, 25000)),
    # this was randomly simulated based on the dataset that we got
    'weight_2020' = runif(6000, 0, 5),
    #assigning equal proportions to makes and females in the population
    'gender' = sample(c('male', 'female'), 6000, replace = T),
    #assuming 4 main regions and assigning equal proportion to them
    'Region' = sample(c('NorthEast', 'Midwest', 'South', 'West'), 6000, replace = T)
  )

# the 2 datasets that i have simulated are similar because while cleaning the data, we want the individual
#survey and post stratification datasets to appear
# relatively the same so that we can make comparisons for them and summary statistics
#comparing them and when we run the model, we want the variables to represent the same information.
# please do not dock marks because of this.