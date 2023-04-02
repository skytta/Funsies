###############################################################################
### Assignment 2: COVID ###
### Analysis of COVID data from NYTimes (https://github.com/nytimes/covid-19-data/)
###
### Below each prompt in the file, write the code necessary/indicated to calculate 
### the answer. Results should be calculate directly from the data. 
### Each result should be stored in a variable with the name indicated 
### (to help us with grading). Don't use backtics in the variable name! 
### It's also a good idea to "print" the result so you can see the answers--don't 
### just look at RStudio's environmental variables.
### 
### IMPORTANT: You MUST use `dplyr` and `tidyverse` functions for this assignment; 
### do not use bracket or dollar-sign notation!
###
### Answer all Reflection questions with a comment in this file.

###############################################################################
##### PART 1: Setup #####
### In this section you will load the data and necessary packages

# Load `dplyr` and `tidyr` packages for use later
# You can alternatively just load the whole `tidyverse` package
# Do not include any `install.package()` calls in this file


# Use the `read.csv()` function to store the **US-level** data from
#   https://github.com/nytimes/covid-19-data/
# in a data frame variable called `national_df`.
# Note that you will need to use the url for the "raw csv"
# Scroll down and look in the README.MD for "U.S. Data (Raw CSV)" link
# The "raw CSV" file will be a webpage with a long, unformatted, list of data. 

national_df <- read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv', stringsAsFactors = FALSE, na.strings = "")

# Similarly, download and store the **state-level** data into a data frame
# variable called `state_df`
# Also download and store the **county-level** data into a data frame variable
# called `county_df`
# (This step should be 2 lines of code!)

state_df <- read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv', stringsAsFactors = FALSE, na.strings = "")

county_df <- read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv', stringsAsFactors = FALSE, na.strings = "")

# How many observations (rows) are in each of the above data sets?
# Define variables `num_obs_national`, `num_obs_state`, `num_obs_county`
# with this information.
View(state_df)
View(county_df)
View(national_df)
num_obs_national <- nrow(national_df)

num_obs_state <- nrow(state_df)

num_obs_county <- nrow(county_df)

# What features are in each data set? Define variables `feature_names_national`, 
# `feature_names_state`, and `feature_names_county`

feature_names_national <- attributes(national_df) 

feature_names_state <- attributes(state_df)

feature_names_county <- attributes(county_df)

# Reflection #1: What does each row in each of the data sets represent?
# Being able to "name" observations is important for understanding data!
# What does each feature in the data set represent? (It's not obvious; 
# check the documentation!) Why do the data sets have different features?

#county_df contains dates of results/reporting, county name, state name, and fips which are 
#geographical identifiers that allow data to be mapped to a specific place. The numbers 
#presented are cumulative numbers of deaths and cases positives 

#national_df contains dates of results/reporting, cumulative number of cases and deaths

#state_df contains dates of results/reporting, name of state identified, fips location data, 
# and cumulative number of cases and deaths       

###############################################################################
##### PART 2: Exploratory Analysis #####
### In this section you must use functions from the `dplyr` package to explore
### the data set by answering the following questions. Your variables will need
### to include the specific column or value being asked for (use `pull()`).
### For example, if asked about the county with the highest number of deaths,
### your answer should be a single string (the name of the county), not an
### entire row of data.
### 
### Note that because you have downloaded data from a specific point in time, 
### your numeric results will be specific to your data set.


# How many total cases have there been in the U.S. at the most recent date?
# Save result in `num_us_cases`

num_us_cases <- national_df %>% 
  filter(date == max(date)) %>% 
  pull(cases) 

# How many total deaths have there been in the U.S. at the most recent date?
# Save result in `num_us_deaths`

num_us_deaths <- national_df %>% 
  filter(date == max(date)) %>% 
  pull(deaths) 

# Which state has had the highest number of cases reported?
# Save result in `state_with_highest_cases`

state_with_highest_cases <- state_df %>% 
  filter(cases == max(cases)) %>% 
  pull(state) 

# How many cases were reported in that state? Use your `stat_with_highest_cases`
# variable to make sure you're only considering reports from that state!
# Save the result in `num_cases_in_highest_state`

num_cases_in_highest_state <- state_df %>% 
  filter(state == state_with_highest_cases) %>% 
  filter(cases == max(cases)) %>% 
  pull(cases) 

# Which state has the highest ratio of deaths to cases (deaths/cases) at the
# most recent date? (hint: try making a new column to help with this!)
# Save your result in `state_with_highest_ratio`

state_with_highest_ratio <- state_df %>% 
  mutate(ratios_death_to_cases = deaths/cases) %>% 
  filter(ratios_death_to_cases == max(ratios_death_to_cases)) %>% 
  pull(state) 


# Which state has had the lowest number of cases *at the most recent date*?
# Be careful that you're only considering the most recent date!
# Save result in `state_with_lowest_cases`

state_with_lowest_cases <- state_df %>% 
  filter(cases == min(cases)) %>% 
  filter(date == max(date)) %>% 
  pull(state) 

# Reflection #2: What did you learn about the data set when you calculated the
# state with the lowest number of cases (and what does that tell you about
# testing your assumptions of a dataset?)

# The answer to the lowest number of cases query tells me that American Samoa
# was included as a state in the dataset.  I had assumed the dataset was comprised of the 50 US states
# and not inclusive of US territories. 

# Which county has had the highest number of cases reported?
# Save result in `county_with_highest_cases`

county_with_highest_cases <- county_df %>% 
  filter(cases == max(cases)) %>% 
  pull(county) 

# What is the highest number of cases reported in a single county?
# Save result in `num_highest_cases_in_county`

num_highest_cases_in_county <- county_df %>% 
  filter(cases == max(cases)) %>% 
  pull(cases) 

# Because there are multiple counties with the same name in multiple states,
# it will be helpful to know which county is which. 
# Add a column to the `county_df` data frame called `county_state` that stores
# a string of the county and state names together (in the format
#   "COUNTY_NAME, STATE_NAME"
# not all caps). Do not remove any columns!
# You can any function from the tidyverse package to do this.

county_df <- county_df %>% 
  mutate(county_df, county_state = paste(county, state, sep = ', '))

# What is the name of the location (county & state name) with the highest number
# of deaths? Use the location as specified in your new `county_state` column.
# Note: you may need to remove `NA` values
# Save the result in `location_with_most_deaths`

location_with_most_deaths <- county_df %>% 
  drop_na(county_state) %>% 
  drop_na(deaths) %>% 
  filter(deaths == max(deaths)) %>% 
  pull(county_state) 

# Reflection #3: Is the location with the highest number of cases the location 
# with the most deaths? If not, why do you believe that is so? What does this
# imply about whether features can "substitute" for one another in analysis?

# The location with the highest number of cases is Los Angeles while the 
# location with the most deaths is New York City, New York. I would speculate
# this could be due to a variety of factors including when the deaths occurred
# relative to the emergency release of the vaccine and also vaccination rates
# in the areas being assessed. Since these are cumulative data and we know
# New York was an early hot spot pre-vaccine, they are likely to have experienced
# greater numbers of deaths compared to Los Angeles who may have had higher positives post
# vaccine leading to decreased mortality. 
# This distinction is important as it demonstates the need to parse data by 
# multiple confounding variables before drawing conclusions. 

# By now you (hopefully) realized that the `cases` and `deaths` columns are not
# the number of *new* cases and deaths each day. 
# Mutate the `national_df` data frame to add TWO new columns, called
# `new_cases` and `new_cases`, that contains the number of *new cases* and
# *new deaths* (respectively) each day. Use a single `mutate()` call.
# Hint: dplyr's `lag()` function can be useful here; look it up!
# You may also want to arrange the rows by date, just in case.

national_df <- national_df %>% 
  mutate(new_deaths = deaths - lag(deaths, default = first(deaths), order_by = date)) %>% 
  mutate(new_cases = cases - lag(cases, default = first(cases), order_by = date))

View(national_df)
# Nationally, what was the date when the most new cases were recorded?
# Save your result as `date_with_most_new_cases`

date_with_most_new_cases <- national_df %>% 
  filter(new_cases == max(new_cases)) %>% 
  pull(date) 

# Nationally, what was the date when the most new deaths were recorded?
# Save your result as `date_with_most_new_deaths`

date_with_most_new_deaths <- national_df %>% 
  filter(new_deaths == max(new_deaths)) %>% 
  pull(date) 

# Nationally, how many people died on the day when the most new deaths were
# recorded? Save your result as `num_most_new_deaths`

num_most_new_deaths <- national_df %>% 
  filter(new_deaths == max(new_deaths)) %>%  
  pull(deaths) 


# Create a (very basic) plot of new daily cases by passing the 
# `new_cases` column of your `national_df` to the `plot()` function. Save the 
# result in a variable `new_cases_plot`

new_cases_plot <- plot(pull(national_df, new_cases))

# Create a (very basic) plot of new daily deaths by passing the 
# `new_deaths` column of your `national_df` to the `plot()` function. Save the 
# in a variable `new_deaths_plot`

new_deaths_plot <- plot(pull(national_df, new_deaths))

# Reflection #4: What do the plots of new cases and deaths tell you about the
# "waves" of the pandemic? How do the plots look different, and why do you think
# that is?

# the death rate and case rates appear to have a relationship (which makes sense)
# in that cases ascend followed by waves in the death rate. The difference between the 
# two appears to be that cases are tightly grouped while deaths are spread out.  This
# would make sense as the time to death after positive case varies greatly from person
# to person on a variety of variables (age, location, access to healthcare, vaccine status).

###############################################################################
##### PART 3: Grouped Analysis #####
### In this section you will use the `group_by()` function to perform the same
### computation simultaneously across groups of rows.
### Again, your variables will need to  include the specific column or value 
### being asked for (use `pull()`).

# What is the county with the *current* (e.g., on the most recent date)
# highest number of cases in each state? Your answer should be a *vector*
# of "location" (`county_state`) names, stored in the variable
# `highest_case_locations_by_state`

highest_case_locations_by_state <- county_df %>% 
  filter(date == max(date)) %>% 
  group_by(state) %>% 
  filter(cases == max(cases)) %>% 
  pull(county_state)

# What is the county with the *current* (e.g., on the most recent date)
# lowest number of cases in each state? Your answer should be a *vector*
# of "location" (`county_state`) names, stored in the variable
# `lowest_case_locations_by_state`

lowest_case_locations_by_state <- county_df %>% 
  filter(date == max(date)) %>% 
  group_by(state) %>% 
  filter(cases == min(cases)) %>% 
  pull(county_state)

# Reflection #5: What do you notice about the values in`lowest_case_locations_by_state`?
# Consider both the names of the counties as well as how many there are.

# Currently they look exactly the same which is concerning to me.  (did I do this wrong?) 
# They both show 3252 elements within the vector and the Strings that are showing in 
# the R Environment are identical.

# What is the *proportion* of counties in each state that have had zero deaths?
# In other words: in each state, how many counties have had 0 deaths (divided by
# the total number of counties in the state)?
# You should produce a *data frame* with columns `state` (containing the state
# name) and `proportion` (containing the ratio as a decimal), saving that
# data frame in a variable `proportion_no_deaths_df`
# Note: this is a tricky, challenging problem! Take your time, and work through
# it in steps.
proportion_no_deaths_df <- county_df %>%
  filter(date == max(date)) %>% 
  mutate(has_no_deaths = deaths == 0) %>% 
  group_by(state) %>% 
  summarize(total_counties = n(), proportion = sum(has_no_deaths/total_counties)) %>% 
  select(state, proportion)

View(county_per_state)
View(county_df)
View(proportion_no_deaths_df)

# What proportion of counties in Washington state have had zero deaths?
# Use your `proportion_no_deaths` data frame, and save your result in
# `wa_prop_no_deaths`

wa_prop_no_deaths <- proportion_no_deaths_df %>%
  filter(state == "Washington") %>% 
  pull(proportion)


# In the next set of questions you'll do some internal verification of the data
# sets. In particular, you'll check that the total number of cases in the
# state and county data matches with the total at the national level.
#
# Start by creating a data frame called `state_total_cases_df` that contains
# the total number of cases for each day. This data frame will have two columns:
# `date` and `state_total_cases`.

state_total_cases_df <- state_df %>% 
  group_by(date) %>%
  summarize(state_total_cases = sum(cases)) 



# mutate(new_cases = cases - lag(cases, default = first(cases), order_by = date))

View(state_total_cases_df)

# Next create a data frame called `county_total_cases_df` that contains
# the total number of cases for each day. This data frame will have two columns:
# `date` and `county_total_cases`.

county_total_cases_df <- county_df %>% 
  group_by(date) %>%
  summarize(county_total_cases = sum(cases))

View(county_total_cases_df)
# While there are multiple ways to check that these totals are the same,
# you'll do this by **joining** all of the totals (state, county, and national)
# into a single data frame called `total_cases_df`
# This data frame should contain just 4 columns:
#   `date`, `state_total_cases`, `county_total_cases`, `national_cases`
# Tip: first join the county and state totals, then take that resulting data frame
# and join it with the `national_df` data frame.
# You'll also need to select only the columns you want in the end.
# It's fine to do this as multiple code statements using intermediate variables
# (which is also great for checking your work as you go)

county_and_state_joined_df <- county_total_cases_df %>% 
  inner_join(state_total_cases_df, by = "date")

renamed_column_df <- national_df %>% 
  select(-deaths, -new_cases, -new_deaths) %>% 
  rename(national_cases = cases)

total_cases_df <- inner_join(county_and_state_joined_df, renamed_column_df) %>%
  group_by(date) %>%
  select(date, state_total_cases, county_total_cases, national_cases)

View(total_cases_df)

# rm(testing)

# How many rows are there where the state total *does not* equal the national
# number of cases reported? Save your result as `num_state_total_diff`

num_state_total_diff <- total_cases_df %>% 
  filter(state_total_cases != national_cases)

View(num_county_total_diff)

# How many rows are there where the county total *does not* equal the national
# number of cases reported? Save your result as `num_county_total_diff`

num_county_total_diff <- total_cases_df %>% 
  filter(county_total_cases !=  national_cases) 
# nrow()
# Oh no, an inconsistency! Time to try and track down the source...
#
# Take the county-level data and add up the total number of cases in each state on
# each day (e.g., aggregate to the state level). Store this in a data frame
# called `county_to_state_total_cases_df` with 3 columns:
#   `date`, `state`, `county_total`
# To avoid dplyr keeping the results "grouped" in your output, pass an additional
# argument to your summarize() call telling it not to keep the groups:
#   .groups = "drop"

county_to_state_total_cases_df <- county_df %>% 
  group_by(state, date) %>% 
  summarize(county_total = sum(cases), .groups = "drop")

View(total_discrepancy_df)

# Join the `county_to_state_total_cases_df` with the `state_df` data frame
# in order to compare them. Save the result as `joined_state_total_df`
# Note that you will need to match rows by both state AND date to avoid
# duplicating date rows!
# Select only the `state`, `date`, `county_total` and `cases` columns
# (rename `cases` to be `state_cases` for clarity)

joined_state_total_df <- left_join(county_to_state_total_cases_df, state_df, 
                                   by = c("state" = "state", "date" = "date")) %>% 
  select(state, date, county_total, state_cases = "cases")

# Create a variable `total_discrepancy_df` which contains *only* the observations
# from `joined_state_total_df` where the number of state cases and the county 
# totals are different.

total_discrepancy_df <- joined_state_total_df %>% 
  filter(county_total != state_cases)

# Determine which *state* has the *highest absolute difference* between the sum
# of the county cases and the reported state cases.
# Save the result as `state_highest_discrepancy`.
# Hint: consider mutating to add a new column to the discrepancy data frame
# to help you calculate this.

state_highest_discrepancy <- total_discrepancy_df %>%
  mutate(diff = abs(county_total - state_cases)) %>% 
  arrange(desc(diff)) %>% 
  filter(diff == max(diff)) %>% 
  pull(state)


View(king_county_new_daily_cases)

###############################################################################
##### PART 4: Your Own Questions #####
### In this section you will practice asking and answering your own questions of
### the data! 
###
### Come up with two (2) questions you are wondering about for this data. Write
### those questions as comments, and then provide code to calculate the answers.
### Use appropriate code throughout.

#What are the current number of total cases in King County, WA ?  

king_county_new_daily_cases <- county_df %>% 
  filter(date == max(date)) %>% 
  filter(county_state == "King, Washington") %>% 
  pull(cases)

#What are the current number of total cases in Snohomish County, WA ? 

snohomish_county_new_daily_cases <- county_df %>% 
  filter(date == max(date)) %>% 
  filter(county_state == "Snohomish, Washington") %>% 
  pull(cases)


# Reflection #6: What surprised you the most throughout your analysis?

# The most surprising thing honestly is how bad these numbers are throughout the country as we begin to loosen
# restrictions. Being that I work in healthcare research, sadly most of these numbers aren't entirely surprising.