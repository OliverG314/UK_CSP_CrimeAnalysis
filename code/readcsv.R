cat("\f")

library(tidyverse)

windowsFonts(Font = windowsFont("CMU Serif"))

setwd(dirname(parent.frame(2)$ofile))

df <- read.csv("../data/finalLongData.csv")

df <- df %>%
  select(-c(Offence.Code))

#Renaming columns that had different names in the data set
df[df == "Miscellaneous crimes against society"] <- "Miscellaneous crimes"
df[df == "Theft Offences"] <- "Theft offences"
df[df == "Rape offences"] <- "Rape"
df[df == "Stalking and Harassment"] <- "Stalking and harassment"
df[df == "London, City of"] <- "City of London"
df[df == "All other theft offences"] <- "Other theft offences"

#All London CSPs
ldnCSP <- c("Barking & Dagenham", "Barnet", "Bexley", "Brent",
            "Bromley", "Camden", "City of London",
            "City of Westminster", "Croydon", "Ealing", "Enfield",
            "Greenwich", "Hackney", "Hammersmith & Fulham",
            "Haringey", "Harrow", "Havering", "Hillingdon",
            "Hounslow", "Islington", "Kensington & Chelsea",
            "Kingston upon Thames", "Lambeth","Lewisham",
            "Merton", "Newham", "Redbridge", 
            "Richmond upon Thames", "Southwark", "Sutton",
            "Tower Hamlets", "Waltham Forest", "Wandsworth")

#Locations of interest (for plot1)
locs = c("Manchester", "Oxford", "Liverpool")

#Create data frame containing data for each year in `loc`
dfW <- df %>%
  transmute(year = Financial.Year,
            quarter = Financial.Quarter,
            location = CSP.Name,
            force = Force.Name,
            offDesc = Offence.Description,
            offGrp = Offence.Group,
            offSubGrp = Offence.Subgroup,
            count = Offence.Count) %>%
  group_by(year, quarter, location, offSubGrp) %>%
  summarise(count = sum(count, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(
    names_from = offSubGrp,
    values_from = count,
    values_fill = list(count = 0)) %>%
  filter(location %in% locs) %>%
  filter(quarter == 4)

#List of crimes of interest (for plot2)
crimes <- c("Bicycle theft", "Other theft offences",
            "Theft from a vehicle", "Theft from the person",
            "Theft of a motor vehicle")

#Location of interest (for plot2)
loc <- "Oxford"

#Long data frame of `dfL`
dfL <- dfW %>%
  filter(location == loc) %>%
  select(c(year, quarter, location, crimes)) %>%
  pivot_longer(all_of(crimes), 
               names_to = "crime",
               values_to = "count")

n <- length(unique(crimes))

#Colours and shapes for uniqueness of visualistion
cols <- scales::hue_pal()(n)
shps <- rep(0:5, length.out = n)

#Crime of interest (for plot1)
crime <- "Arson"

#Plot 1 crime, multiple locations
plot1 <- ggplot(dfW, aes(x = year,
                         y = .data[[crime]],
                         group = location,
                         color = location,
                         shape = location)) +
  geom_point() +
  geom_line() +
  scale_shape_manual(values = shps) +
  scale_color_manual(values = rep(cols, length.out = n)) +
  labs(title = paste(crime, "in various locations"),
       y     = "Count") + 
  theme(axis.text.x = element_text(angle = 45, hjust=1))

#Plot 1 location, multiple crimes
plot2 <- ggplot(dfL, aes(x = year,
                         y = count,
                         group = crime,
                         color = crime,
                         shape = crime)) +
  geom_point() +
  geom_line() +
  scale_shape_manual(values = shps) +
  scale_color_manual(values = cols) +
  labs(title = paste("Crime in", loc),
       y     = "Count") + 
  theme(axis.text.x = element_text(angle = 45, hjust=1)) 