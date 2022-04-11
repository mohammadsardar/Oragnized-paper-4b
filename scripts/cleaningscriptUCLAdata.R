library(tidyverse)
library(haven)

UCLAdirty <- read_dta("inputs/data/ns20201224.dta")
UCLAsmaller <- UCLAdirty %>% select(census_region, vote_2020_retro ,age, gender, census_region, hispanic, 
                                    race_ethnicity, household_income, education, state,
                                    congress_district, weight_2020)




UCLAsmaller <- na.omit(UCLAsmaller)

#voting for trump or not as a binary response variable
UCLAsmaller <- UCLAsmaller %>%  filter(vote_2020_retro == 1 | vote_2020_retro == 2)
UCLAtrial <- UCLAsmaller %>% mutate(vote_trump = ifelse(vote_2020_retro == 1, 1, 0))



#fixing Hispanic

UCLAsmaller$hispanic <- as.numeric(UCLAsmaller$hispanic)

UCLAtrial <- UCLAtrial %>% mutate(is_hispanic = ifelse(hispanic == 1, 0, 1))

#age is already fixed

#gender First numeric then binary
UCLAtrial <- UCLAtrial %>% mutate(is_female = ifelse(gender == 1, 1, 0))


#race
UCLAtrial$race_ethnicity <- as.factor(UCLAtrial$race_ethnicity)
#UCLAtrial <- UCLAtrial %>% mutate(race = if(race_ethnicity == 1){1}
#                                  else if(race_ethnicity == 2){2}
#                                  else if(race_ethnicity == c(4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)){3}
#                                  else if(race_ethnicity == 3){4}
#                                 else if(race_ethnicity == 15){5})

UCLAtrial <- UCLAtrial %>% mutate(race = case_when(
  race_ethnicity==1 ~ 1,
  race_ethnicity==2 ~ 2,
  race_ethnicity==4 ~ 4,
  race_ethnicity==5 ~ 4,
  race_ethnicity==6 ~ 4,
  race_ethnicity==7 ~ 4,
  race_ethnicity==8 ~ 4,
  race_ethnicity==9 ~ 4,
  race_ethnicity==10 ~ 4,
  race_ethnicity==11 ~ 4,
  race_ethnicity==12 ~ 4,
  race_ethnicity==13 ~ 4,
  race_ethnicity==14 ~ 4,
  race_ethnicity==3 ~ 3,
  race_ethnicity==15 ~ 5
))  
UCLAtrial$race <- as.factor(UCLAtrial$race)


#householdincome

UCLAtrial<- UCLAtrial %>%  mutate(income = ifelse(household_income < 8, 1,
                               ifelse(household_income < 20, 2 ,
                                      ifelse(household_income < 23, 3,
                                             4))))
UCLAtrial$income <- as.factor(UCLAtrial$income)

#education
UCLAtrial$education <- as.factor(UCLAtrial$education)

UCLAtrial <- UCLAtrial %>% mutate(education_category = case_when(
  education==1 ~ 1,
  education==2 ~ 1,
  education==3 ~ 1,
  education==4 ~ 2,
  education==5 ~ 2,
  education==6 ~ 2,
  education==7 ~ 3,
  education==8 ~ 3,
  education==9 ~ 3,
  education==10 ~ 3,
  education==11 ~ 3
))

UCLAtrial$education_category <- as.factor(UCLAtrial$education_category)

UCLAfinal <- UCLAtrial %>% select(vote_trump ,census_region, state, age, weight_2020,
                                  is_hispanic, is_female, race, income, education_category)

names_state <- tibble(stateicp = state.name, state = state.abb)
UCLAfinal <- UCLAfinal %>% 
  left_join(names_state)

UCLAfinal <- UCLAfinal %>% rename(hispan = is_hispanic,
                     sex = is_female)

UCLAfinal$stateicp[is.na(UCLAfinal$stateicp)] = "District Of Columbia"

write_csv(UCLAfinal, "outputs/paper/data/UCLA.csv")
