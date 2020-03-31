installed_packages <- 'pacman' %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) { install.packages("pacman") }

library(pacman)
pacman::p_load(tidyverse, readr, ggplot2 ,lubridate, NLP, tm)


df <- read_tsv("fairfaxcountycoronavirus.tsv")

df %>% ggplot() + 
  geom_line(aes(x = date, y = count)) + 
  scale_x_date(date_labels="%d %b",date_breaks  ="1 day") + 
  scale_y_continuous(breaks = seq(from = 0,to = 200,by = 10)) +
  
  geom_vline(xintercept = ymd('2020-03-16'), colour="blue") +
  geom_text(aes(x=ymd('2020-03-16'), label="\nSchools Closed", y=50), colour="blue", angle=90, text=element_text(size=11)) +
  
  geom_vline(xintercept = ymd('2020-03-23'), colour="red") +
  geom_text(aes(x=ymd('2020-03-23'), label="\nBusinesses and playgrounds closed", y=50), colour="red", angle=90, text=element_text(size=11)) +
  
  geom_vline(xintercept = ymd('2020-03-24'), colour="orange") +
  geom_text(aes(x=ymd('2020-03-24'), label="\nGov Buildings and parks closed", y=50), colour="orange", angle=90, text=element_text(size=11)) +

  geom_vline(xintercept = ymd('2020-03-30'),colour="blue", linetype="dotted") +
  geom_text(aes(x=ymd('2020-03-30'), label="\n14 days after schools closed", y=50), colour="blue", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-04-06'),colour="red", linetype="dotted") +
  geom_text(aes(x=ymd('2020-04-06'), label="\n14 days after businesses and parks closed", y=60), colour="red", angle=90, text=element_text(size=11)) +
  geom_vline(xintercept = ymd('2020-04-07'),colour="orange", linetype="dotted") +
  geom_text(aes(x=ymd('2020-04-07'), label="\n14 days after Gov buildings closed", y=50), colour="orange", angle=90, text=element_text(size=11)) +
  
  
  ggtitle(label = 'Fairfax County, Virginia, COVID-19 Cases',subtitle = "source: https://www.fairfaxcounty.gov/covid19/case-information (chart by Peter Sabela)") +
  ylab(label = "count") +
  theme(panel.grid.minor =   element_blank(),
        panel.grid.major =   element_line(colour = "white",size=0.75))
