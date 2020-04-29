installed_packages <- 'pacman' %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) { install.packages("pacman") }

library(pacman)
pacman::p_load(tidyverse, readr, ggplot2 ,lubridate, NLP, tm)

setwd("C:/Users/psabela/Desktop/R workspace/fairfaxcountycovid19")

df <- read_tsv("fairfaxcountycoronavirus.tsv")
my <- 850
deltas <- c(abs(diff(df$count)),0)

df %>% ggplot() + 
  geom_line(aes(x = date, y = count)) + 
  scale_x_date(date_labels="%m/%e",date_breaks  ="1 day") + 
  
  geom_vline(xintercept = ymd('2020-03-16'), colour="blue") +
  geom_text(aes(x=ymd('2020-03-16'), label="\nSchools Closed", y=my), colour="blue", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-03-23'), colour="red") +
  geom_text(aes(x=ymd('2020-03-23'), label="\nBusinesses and playgrounds closed", y=my), colour="red", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-03-24'), colour="orange") +
  geom_text(aes(x=ymd('2020-03-24'), label="\nGov Buildings and parks closed", y=my), colour="orange", angle=90, text=element_text(size=11)) +

  geom_vline(xintercept = ymd('2020-03-31'), colour="brown") +
  geom_text(aes(x=ymd('2020-03-31'), label="\nStay at Home Order", y=my), colour="brown", angle=90, text=element_text(size=11)) +
  
  geom_vline(xintercept = ymd('2020-03-30'),colour="blue", linetype="dotted", size = 1.5) +
  geom_text(aes(x=ymd('2020-03-30'), label="\n14 days after schools closed", y=my), colour="blue", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-04-06'),colour="red", linetype="dotted", size = 1.5) +
  geom_text(aes(x=ymd('2020-04-06'), label="\n14 days after businesses and parks closed", y=my), colour="red", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-04-07'),colour="orange", linetype="dotted", size = 1.5) +
  geom_text(aes(x=ymd('2020-04-07'), label="\n14 days after Gov buildings closed", y=my), colour="orange", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-04-14'),colour="brown", linetype="dotted", size = 1.5) +
  geom_text(aes(x=ymd('2020-04-14'), label="\n14 days after stay at home order", y=my), colour="brown", angle=90, text=element_text(size=11)) +
  
  ggtitle(label = 'Fairfax County, Virginia, COVID-19 Cases',subtitle = "source: https://www.fairfaxcounty.gov/covid19/case-information (chart by Peter Sabela)") +
  ylab(label = "count") +
  theme(panel.grid.minor =   element_blank(),
        panel.grid.major =   element_line(colour = "white",size=0.75),
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(position = "right", breaks = seq(from = 0,to = 3500,by = 100)) +
  geom_col(aes(x = date, y = deltas))


