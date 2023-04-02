# Reshape by gathering prices into a single feature
band_data_long <- gather(
  band_data_wide,   # data frame to gather from
  key = band,     # name for new column listing the gathered features
  value = price,  # name for new column listing the gathered values
  -city           # columns to gather data from, as in dplyr's `select()`
)

# Reshape long data (Table 12.2), spreading prices out among multiple features
price_by_band <- spread(
  band_data_long, # data frame to spread from
  key = city,     # column indicating where to get new feature names
  value = price   # column indicating where to get new feature values
)

# Load data, skipping the unnecessary first 4 rows
wb_data <- read.csv("data/world_bank_data.csv",stringsAsFactors = F, skip = 4)

# Visually compare expenditures for 1990 and 2014

# Begin by filtering the rows for the indicator of interest
indicator <- "Government expenditure on education, total (% of GDP)"
expenditure_plot_data <- wb_data %>%
  filter(Indicator.Name == indicator)

# Plot the expenditure in 1990 against 2014 using the `ggplot2` package
# See Chapter 16 for details
expenditure_chart <- ggplot(data = expenditure_plot_data) +
  geom_text_repel(
    mapping = aes(x = X1990 / 100, y = X2014 / 100, label = Country.Code)
  ) + scale_x_continuous(labels = percent) + scale_y_continuous(labels = percent) +
  labs(title = indicator, x = "Expenditure 1990", y = "Expenditure 2014")


# Reshape the data to create a new column for the `year`
long_year_data <- wb_data %>%
  gather(
    key = year, # `year` will be the new key column
    value = value, # `value` will be the new value column
    X1960:X # all columns between `X1960` and `X` will be gathered
  )

# Filter the rows for the indicator and country of interest
indicator <- "Government expenditure on education, total (% of GDP)"
spain_plot_data <- long_year_data %>%
  filter(
    Indicator.Name == indicator,
    Country.Code == "ESP" # Spain
  ) %>%
  mutate(year = as.numeric(substr(year, 2, 5))) # remove "X" before each year

# Show the educational expenditure over time
chart_title <- paste(indicator, " in Spain")
spain_chart <- ggplot(data = spain_plot_data) +
  geom_line(mapping = aes(x = year, y = value / 100)) +
  scale_y_continuous(labels = percent) +
  labs(title = chart_title, x = "Year", y = "Percent of GDP Expenditure")

# Reshape the data to create columns for each indicator
wide_data <- long_year_data %>%
  select(-Indicator.Code) %>% # do not include the `Indicator.Code` column
  spread(
    key = Indicator.Name, # new column names are `Indicator.Name` values
    value = value # populate new columns with values from `value`
  )

# Prepare data and filter for year of interest
x_var <- "Literacy rate, adult female (% of females ages 15 and above)"
y_var <- "Unemployment, female (% of female labor force) (modeled
  ILO estimate)"

lit_plot_data <- wide_data %>%
  mutate(
    lit_percent_2014 = wide_data[, x_var] / 100,
    employ_percent_2014 = wide_data[, y_var] / 100
  ) %>%
  filter(year == "X2014")

# Show the literacy vs. employment rates
lit_chart <- ggplot(data = lit_plot_data) +
  geom_point(mapping = aes(x = lit_percent_2014, y = employ_percent_2014)) +
  scale_x_continuous(labels = percent) +
  scale_y_continuous(labels = percent) +
  labs(
    x = x_var,
    y = "Unemployment, female (% of female labor force)",
    title = "Female Literacy Rate versus Female Unemployment Rate"
  )

#FROM CLASS VIDEO EXAMPLES

library(dplyr)
library(tidyr)

cereal_filtered <- read.csv('data/filtered_cereal_dplyr.csv', stringsAsFactors = FALSE)

cereal_filtered <- cereal_filtered %>% 
  mutate(over_50_rating = rating > 50)

grouped <- cereal_filtered %>% 
  group_by(mfr, over_50_rating) %>% 
  summarize(mean_sugars = mean(sugars))
#this produces a 3 column tibble filtered by manufacturer 

spreaded <- spread(grouped, over_50_rating, mean_sugars)
# creates a 3 column tibble with true and false columns adjacent to manufacturer where values of sugars are listed beneath

gathered <- gather(spreaded, over_50_rating, mean_sugars, -mfr)
#this pulls it back into similar to grouped code

# Exercise 4-13: tidyr

## Note: Use `dplyr` and `tidyr` functions for all exercises in this module. Do not use dollar
## sign ($) or bracket ([]) notation!

# Read in the data/Building_Permits.csv file and store it in a data frame named `permits`. This
# file contains building permits from the City of Seattle. See the link below for more info. Be sure
# set the working directory to the appropriate folder location.
# https://data.seattle.gov/Permitting/Building-Permits/76t5-zqzr

permits <- read.csv('data/Building_Permits.csv', stringsAsFactors = FALSE, na.strings = "")
write.csv(permits, 'data/permits.csv', row.names = FALSE)

# As you did in a previous exercise: filter the `permits` to only include instances where the 
# estimated project cost value (`EstProjectCost`) is greater than 0. Also filter to only include 
# new permits for building (Hint: use the `PermitTypeMapped` and `PermitTypeDesc` columns). Add 
# a `Year` column by taking the first four characters from the date. Store the result in a data 
# frame named `filtered_permits`

filtered_permits <- permits %>% 
  filter(EstProjectCost > 0 ) %>% 
  filter(PermitTypeMapped == "Building") %>%
  filter(PermitTypeDesc == "New") %>% 
  mutate(Year = substr(AppliedDate, 1, 4)) 

#View(filtered_permits)

# Similar to what you did in a previous exercise: create a grouping to get the number of records 
# for each year and `PermitClass` combination (i.e. group by both simultaneously and summarize 
# by both simultaneously). Store the results in a data frame named 'grouped_by_year_and_class`. 
# The data frame should have three columns: `PermitClass`, `Year`, and `N` (for the number of 
# records). (Hint: use the `n()` function in your summarize to get counts)

grouped_by_year_and_class <- filtered_permits %>% 
  group_by(Year, PermitClass) %>% 
  summarize(N = n()) %>% 
  select(PermitClass, Year, N) %>% 
  arrange(grouped_by_year_and_class, desc(Year))

View(grouped_by_year_and_class)

# As you can see, the `grouped_by_year_and_class` data frame is a "long" data frame. Create a 
# data frame named `grouped_by_year_and_class_wide` that is a wide version of the same data. Use 
# tidyr's `spread()` function to do this. Your "wide" data frame should have a column for the
# Year and then a column for every category of `PermitClass` (8 columns in total). The values of
# the data frame should be counts (i.e. your values for `N`)

grouped_by_year_and_class_wide <- spread(grouped_by_year_and_class, key = PermitClass, value = N)

#View(grouped_by_year_and_class_wide)

# Now, use the `grouped_by_year_and_class_wide` data frame to recreate the 
# `grouped_by_year_and_class` data frame using tidyr's `gather()` function. The cols to pivot
# should be everything except the Year column (written as "-Year" , note the "-" symbol). The
# column names should go to a column called "PermitClass", and the values should go to a column
# called "N" (to match the orignal data frame). After creating the data frame, filter out rows with
# NA values. Store the results in a data frame named `grouped_by_year_and_class_long`. Check that 
# the dimensions of the resulting data frame are the same as the `grouped_by_year_and_class` data frame

grouped_by_year_and_class_long <- gather(grouped_by_year_and_class_wide, key = PermitClass, value = N, -Year, na.rm = TRUE) %>% 
  relocate(PermitClass) %>% 
  arrange(Year)

View(grouped_by_year_and_class_long)

# Lastly, arrange both the `grouped_by_year_and_class` and `grouped_by_year_and_class` data
# frames by year and `PermitClass` (the order doesn't matter as long as it is consistent across)
# the two data frames). Ensure that the two data frames are identical by using the `identical()`
# function.

identical(grouped_by_year_and_class_long, grouped_by_year_and_class)

