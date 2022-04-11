library(tidyverse)
library(haven)



# First eliminate the variables that are not useful 
ACS_raw <- read_dta("inputs/data/usa_00001.dta")
ACS_cleaned <- ACS_raw %>% select(region, stateicp, strata, sex, race, hispan, age, 
                                bpl, citizen, hcovany, educ, labforce, ftotinc, poverty)

ACS_cleaned <- na.omit(ACS_cleaned)

ACS_cleaned$stateicp <- labelled::to_factor(ACS_cleaned$stateicp)



# Fix the variables in race, (1 = White, 2 = Black, 3 = American Indian or Alaska Native, 4 = Asian, 5 = Others)

ACS_cleaned <- 
  ACS_cleaned %>% 
  mutate(race = case_when(
    race ==1 ~ 1,
    race ==2 ~ 2,
    race ==3 ~ 3,
    race ==4 ~ 4,
    race ==5 ~ 4,
    race ==6 ~ 4,
    race ==7 ~ 5,
    race ==8 ~ 5,
    race ==9 ~ 5
  ))  

# Fix the variables in Hispanic 

ACS_cleaned <- 
  ACS_cleaned %>% 
  mutate(hispan = ifelse(hispan > 0, 1, 0))


# Fix the gender

ACS_cleaned <- 
  ACS_cleaned %>% 
  mutate(sex = ifelse(sex == 1, 1, 0))

# Fix the age 

ACS_cleaned <-
  ACS_cleaned %>%  filter(age > 17)



# Fix the variable in education,(1 = below high school diploma, 2= high school diploma, 3 = post-secondary diploma)

ACS_cleaned <- 
  ACS_cleaned %>% 
  mutate(education_category = case_when(
    educ ==0 ~ 1,
    educ ==1 ~ 1,
    educ ==2 ~ 1,
    educ ==3 ~ 1,
    educ ==4 ~ 1,
    educ ==5 ~ 1,
    educ ==6 ~ 2,
    educ ==7 ~ 2,
    educ ==8 ~ 2,
    educ ==9 ~ 2,
    educ ==10 ~ 3,
    educ ==11 ~ 3
  ))    

ACS_cleaned$education_category <- as.factor(ACS_cleaned$education_category)
ACS_cleaned$age <- as.numeric(ACS_cleaned$age)
ACS_cleaned$race <- as.factor(ACS_cleaned$race)
ACS_cleaned$hispan <- as.factor(ACS_cleaned$hispan)
ACS_cleaned$sex <- as.factor(ACS_cleaned$sex)

ACS_cleaned$stateicp <- str_to_title(ACS_cleaned$stateicp)

write_csv(ACS_cleaned, "outputs/paper/data/ACS.csv")

