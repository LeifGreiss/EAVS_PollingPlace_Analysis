#
# 
#

# import packages
library(tidyverse)
library(readxl)

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

# Combine the frames from the same survey years, slim them down to what we are interested in and remove Wisconsin entries (See the READMEs for the data)
EAVS2016 = EAVS2016A %>%
  full_join(EAVS2016D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2016F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2016", length(6467)))%>%
  filter(State != "WI")%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2014 = EAVS2014A %>%
  full_join(EAVS2014D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2014F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2014", length(8202)))%>%
  filter(State != "WI")%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2012 = EAVS2012A %>%
  full_join(EAVS2012D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2012F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2012", length(8154)))%>%
  filter(State != "WI")%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2010 = EAVS2010A %>%
  full_join(EAVS2010D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2010F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2010", length(4692)))%>%
  filter(State != "WI")%>%
  select(State, Jurisdiction, year, A1a, A3a, A4a, D1a, D2a, D2b, D2c, D2e, D2f, F1a, F1b)
EAVS2008 = EAVS2008A %>%
  full_join(EAVS2008D, by = c("State", "Jurisdiction"))%>%
  full_join(EAVS2008F, by = c("State", "Jurisdiction"))%>%
  mutate(year = rep("2008", length(4627)))%>%
  filter(State != "WI")%>%
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
         polling_per_voter = D1a/A1a*1000)

# Create frames for midterms and presidential elections
EAVS_mid = filter(EAVS, year == "2010" | year == "2014")
EAVS_pres = filter(EAVS, year == "2008" | year == "2012" | year == "2016")

# Time for analysis

# Summarize
EAVS %>% 
  group_by(State, year)%>%
  summarise(polling_places = sum(D1a, na.rm = TRUE))

ggplot(EAVS_state, aes(year, polling_places, color = State)) +
  geom_smooth()
