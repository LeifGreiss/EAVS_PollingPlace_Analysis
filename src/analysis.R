#
# 
#

# import packages
library(tidyverse)
library(readxl)
library(gridExtra)

# import EAVS section A
EAVS2016A = read_excel("data/EAVS_A/2016EAVS2.xlsx")%>%
  rename(Jurisdiction = JurisdictionName)
EAVS2014A = read_excel("data/EAVS_A/2014EAVS2.xlsx")%>%
  rename(A1a = QA1a, A3a = QA3a, A4a = QA4a)
EAVS2012A = read_excel("data/EAVS_A/2012EAVS2.xlsx")%>%
  rename(A1a = QA1a, A3a = QA3a, A4a = QA4a)
EAVS2010A = read_excel("data/EAVS_A/2010EAVS2.xlsx")%>%
  rename(A1a = QA1a, A3a = QA3a, A4a = QA4a)
EAVS2008A = read_excel("data/EAVS_A/2008EAVS2.xls")%>%
  rename(State = STATE_, Jurisdiction = JurisName, A1a = A1)

# import EAVS section D
EAVS2016D = read_excel("data/EAVS_D/2016EAVS-D.xlsx")%>%
  rename(Jurisdiction = JurisdictionName)
EAVS2014D = read_excel("data/EAVS_D/2014EAVS-D.xlsx")%>%
  rename(D1a = QD1a, D2a = QD2a, D2b = QD2b, D2c = QD2c, D2e = QD2e, D2f = QD2f)
EAVS2012D = read_excel("data/EAVS_D/2012EAVS-D.xls")%>%
  rename(D1a = QD1a, D2a = QD2a, D2b = QD2b, D2c = QD2c, D2e = QD2e, D2f = QD2f)
EAVS2010D = read_excel("data/EAVS_D/2010EAVS-D.xlsx")%>%
  rename(D1a = QD1a, D2a = QD2a, D2b = QD2b, D2c = QD2c, D2e = QD2e, D2f = QD2f)
EAVS2008D = read_excel("data/EAVS_D/2008EAVS-D.xls")%>%
  rename(State = STATE_, Jurisdiction = JurisName, D1a = D1)

# import and rename columns in EAVS section F
EAVS2016F = read_excel("data/EAVS_F/2016EAVS-F.xlsx")%>%
  rename(Jurisdiction = JurisdictionName)
EAVS2014F = read_excel("data/EAVS_F/2014EAVS-F.xlsx")%>%
  rename(F1a = QF1a, F1b = QF1b)
EAVS2012F = read_excel("data/EAVS_F/2012EAVS-F.xlsx")%>%
  rename(F1a = QF1a, F1b = QF1b)
EAVS2010F = read_excel("data/EAVS_F/2010EAVS-F.xlsx")%>%
  rename(F1a = QF1a, F1b = QF1b)
EAVS2008F = read_excel("data/EAVS_F/2008EAVS-F.xls")%>%
  rename(State = STATE_, Jurisdiction = JurisName)

# Create a vector to deal with states or territories that cause problems
badstate = c("AS", "WI", "VI")
# Combine the frames from the same survey years, slim them down to what we are interested in and remove Wisconsin entries (See the READMEs for the data)
EAVS2016 = EAVS2016A %>%
  full_join(EAVS2016D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2016F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2016", length(6467)))%>%
  filter(!State %in% badstate)%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2014 = EAVS2014A %>%
  full_join(EAVS2014D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2014F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2014", length(8202)))%>%
  filter(!State %in% badstate)%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2012 = EAVS2012A %>%
  full_join(EAVS2012D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2012F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2012", length(8154)))%>%
  filter(!State %in% badstate)%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2010 = EAVS2010A %>%
  full_join(EAVS2010D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2010F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2010", length(4692)))%>%
  filter(!State %in% badstate)%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2008 = EAVS2008A %>%
  full_join(EAVS2008D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2008F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2008", length(4627)))%>%
  filter(!State %in% badstate, Jurisdiction != "LICKING")%>% # Reporting on Licking was a problem in 2008 so exclude it
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)

# Append the data sets to create a giant tidyish one and arrange by state and jurisdiction 
EAVS = do.call("rbind", list(EAVS2008, EAVS2010, EAVS2012, 
                             EAVS2014, EAVS2016))%>%
  arrange(State, Jurisdiction)

# Convert necessery columns to numeric for EAVS 
EAVS$A1a = as.numeric(EAVS$A1a)
EAVS$A3a = as.numeric(EAVS$A3a)
EAVS$A4a = as.numeric(EAVS$A4a)
EAVS$D1a = as.numeric(EAVS$D1a)
EAVS$D2a = as.numeric(EAVS$D2a)
EAVS$D2b = as.numeric(EAVS$D2b)
EAVS$D2c = as.numeric(EAVS$D2c)
EAVS$D2e = as.numeric(EAVS$D2e)
EAVS$D2f = as.numeric(EAVS$D2f)
EAVS$F1a = as.numeric(EAVS$F1a)
EAVS$F1b = as.numeric(EAVS$F1b)
EAVS$year = as.numeric(EAVS$year)

# Create a column for participation rates
EAVS = EAVS %>%
  mutate(participation = F1a/A1a,
         participation_p = F1b/A1a,
         polling_per_voter = D2a/A1a*10000)# This is ratio to find the number of polling places per every 10,000 people

# Remove Inf and Nan Values from mutated cols
EAVS$participation[is.infinite(EAVS$participation) | is.nan(EAVS$participation)]= NA
EAVS$participation_p[is.infinite(EAVS$participation_p) | is.nan(EAVS$participation_p)]= NA
EAVS$polling_per_voter[is.infinite(EAVS$polling_per_voter) | is.nan(EAVS$polling_per_voter)]= NA

EAVS%>%
  filter(participation_p < 1 & participation > 0, 
         polling_per_voter > 0, D2a > 2)%>%
  ggplot(aes(participation_p, polling_per_voter)) +
  geom_point() +
  geom_smooth()

# Time for analysis

# Summarize states
EAVS_state = EAVS%>%
  group_by(State, year)%>%
  summarise(polling_places = sum(D2a, na.rm = TRUE),
            poll_ratio = mean(polling_per_voter, na.rm = TRUE),
            participation = mean(participation, na.rm = TRUE))
  
EAVS_state%>%
  ggplot(aes(year, polling_places)) +
  geom_line(aes(group = State, color = State))

EAVS_state%>%
  ggplot(aes(participation, poll_ratio)) +
  geom_point()

# create seperate frame just for 2008 and 2016
EAVS_state_gather = EAVS_state %>% 
  filter(year == 2008 | year == 2016)%>%
  mutate(lag = lag(polling_places),
         pct.change = (polling_places - lag) / lag(polling_places),
         ratio.lag = lag(poll_ratio),
         ratio.pct.change = (poll_ratio - ratio.lag) / lag(poll_ratio))

# Do the same as above but with 2012 and 2016
EAVS_state_gather2 = EAVS_state %>% 
  filter(year == 2012 | year == 2016)%>%
  mutate(lag = lag(polling_places),
         pct.change = (polling_places - lag) / lag(polling_places),
         ratio.lag = lag(poll_ratio),
         ratio.pct.change = (poll_ratio - ratio.lag) / lag(poll_ratio))

# Let's do the same but with 2014 and 2016 
EAVS_state_gather3 = EAVS_state %>% 
  filter(year == 2014 | year == 2016)%>%
  mutate(lag = lag(polling_places),
         pct.change = (polling_places - lag) / lag(polling_places),
         ratio.lag = lag(poll_ratio),
         ratio.pct.change = (poll_ratio - ratio.lag) / lag(poll_ratio))

# show if there is a general decline
EAVS_state_gather%>%
  filter(polling_places <= 4000)%>%
  ggplot(aes(year, polling_places)) +
  geom_line(aes(group = State)) +
  geom_point(aes(group = State))

pp_change0816 = EAVS_state_gather%>%
  filter(year == 2016)%>%
  ggplot(aes(State, pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent Change of Physical Polling Places 2008-2016"
)

pr_change0816 = EAVS_state_gather%>%
  filter(year == 2016)%>%
  ggplot(aes(State, ratio.pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent change of Ratio of Polling Places to Voters 2008-2016"
)
pp_change1216 = EAVS_state_gather2%>%
  filter(year == 2016)%>%
  ggplot(aes(State, pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent Change of Physical Polling Places 2012-2016"
)

pr_change1216 = EAVS_state_gather2%>%
  filter(year == 2016)%>%
  ggplot(aes(State, ratio.pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent change of Ratio of Polling Places to Voters 2012-2016"
)

pp_change1416 = EAVS_state_gather3%>%
  filter(year == 2016)%>%
  ggplot(aes(State, pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent Change of Physical Polling Places 2014-2016"
  )

pr_change1416 = EAVS_state_gather3%>%
  filter(year == 2016)%>%
  ggplot(aes(State, ratio.pct.change)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(title = "Percent change of Ratio of Polling Places to Voters 2014-2016"
  )
pp_change1416
pr_change1416

# Compare changes in the number of physical polling places
grid.arrange(pp_change0816, pp_change1216, nrow = 1)

# Compare changes in polling place ration
grid.arrange(pr_change0816, pr_change1216, nrow = 1)

# For checking outliers or incorrect data
EAVS_inspect = EAVS%>%
  filter(polling_per_voter > 1000)

