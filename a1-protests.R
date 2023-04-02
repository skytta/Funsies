###############################################################################
### Assignment 1: Protests ###
### Analysis of protest data from CountLove.org (https://countlove.org/)
###
### Below each prompt in the file, write the code necessary/indicated to calculate 
### the answer. Results should be calculate directly from the data. 
### Each result should be stored in a variable with the name indicated 
### (to help us with grading). Don't use backtics in the variable name! 
### It's also a good idea to "print" the result so you can see the answers--don't
### just look at RStudio's environmental variables.
###
### Answer all Reflection questions with a comment in this file.
###
### Note that you are not allowed to use R packages such as `dplyr` in this 
### assignment. The goal is to make sure you can use foundational R syntax, which
### is a necessary skill for future work.

###############################################################################
##### PART 0: Setup #####
### This section loads the data and necessary packages

# Load the `stringr` package for use later (all package loading goes at the top)
# Do not include any `install.package()` calls
library(stringr)

# Use the `read.csv()` function to store the data from
#   https://countlove.org/data/data.csv 
# in a data frame variable called `protests_df`
protests_df <- read.csv("https://countlove.org/data/data.csv")

# Note that because this is "live" data, your results may change slightly depending
# on when you run your analysis!

###############################################################################
##### PART 1: Attendees #####
### In this section you will explore the number of attendees at protests

# For clarity, extract the `Attendees` feature from the `protests_df` data frame
# into a variable called `attendee_counts_vector`

  attendee_counts_vector <- protests_df$Attendees


# What is the highest number of attendees? Save result in `max_attendee_count`
# (hint for this and other calculations: you'll need to _remove_ `NA` values
# use an `na.rm = TRUE` argument)

    max_attendee_count <- max(protests_df$Attendees, na.rm = TRUE)

# What is was the lowest number of attendees? Save result in `min_attendee_count`

    min_attendee_count <- min(protests_df$Attendees[protests_df$Attendees != 0],na.rm = TRUE)

# What is the average (mean) number of attendees? Save result in `mean_attendee_count`
  
    mean_attendee_count <- mean(protests_df$Attendees[protests_df$Attendees != 0],na.rm = TRUE)
           
# What is the median number of attendees? Save result in `median_attendee_count`
  
    median_attendee_count <- median(protests_df$Attendees[protests_df$Attendees != 0],na.rm = TRUE)

# How far apart are the the mean and median number of attendees? Calculate the
# absolute value of the difference and store in a variable `mean_median_diff`

    mean_median_diff <- abs(median_attendee_count - mean_attendee_count)

   
# Reflection #1: What does the difference between the mean and the median counts
# tell you about the *distribution* of the data? You'll want to consider the
# individual numbers as well (which is higher)?
# Feel free to ask for clarification if you're unfamiliar with working with
# distributions.

    #This distribution is right skewed as the values are heavily in the higher range. 
  
#https://stats.stackexchange.com/questions/481409/figuring-out-skewness-from-a-boxplot 

# To help visualization this distribution, use the `boxplot()` function to plot
# the counts of attendees in a chart. Assign this plot to a variable named
# `attendee_count_boxplot` 
# (We'll use more refined plotting methods with more attention to detail later)

  attendee_count_boxplot <- boxplot(attendee_counts_vector)
  
  #https://r-coder.com/boxplot-r/         
  #https://stackoverflow.com/questions/23050928/error-in-plot-new-figure-margins-too-large-scatter-plot
  
# Create a second boxplot of the `log()` (natural logarithm) of the attendee counts.
# You will see a warning in the console, which is expected.
# Store this plot in a variable named `log_attendee_count_boxplot`

  log_attendee_count_boxplot <- boxplot(log(attendee_counts_vector))
  
###############################################################################
##### PART 2: Locations #####
### In this section you will explore where protests occurred

# For clarity, extract the `Location` feature from the `protests_df` data frame
# into a variable called `all_locations_vector`

  all_locations_vector <- protests_df$Location

# How many *unique* locations are in the data set? Store the result in `locations_count`

  locations_count <- length(unique(all_locations_vector))

# How many protests occurred in Washington state? Use a function from the `stringr` 
# package to *detect* locations with the letters "WA" Store the result in 
# `wa_protests_count`.
# Note that this is not a perfect approach, and will include some false positives
# (locations that have "WA" in the name, but aren't in Washington state)
  
  # wa_protests_count <- function(wa_protests) {
  #   
  #   # wa_protests <- str_count(wa_protests, pattern = "WA")
  #   # total_wa <- sum(wa_protests)
  #   return(total_wa)
  # }
wa_protests_count <- str_detect(all_locations_vector, "WA")
wa_protests_count <- length(wa_protests_count[wa_protests_count == TRUE])

#wa_protests_count
#wa_protests_count(all_locations_vector)

# What percentage of all protests occurred in Washington State? Store the result
# in `wa_protest_percentage`

  wa_protest_percentage <- round(((wa_protests_count / locations_count) * 100), 0)

# Reflection #2: Does the number of protests in Washington surprise you? 
# Why or why not?

  #This doesn't surprise me as 14% seems appropriate for the activity we know happened over the course of that period which was well publicized.

# Define a function called `count_in_location()`. This function will expect 2 arguments:
#   1) a `location_name` string (e.g., "Seattle, Washington"), and 
#   2) a `locations_vector` of location names
# The function will *return* the number of times the `location_name` occurs in the
# `locations_vector`. Note that you should count partial matches, so "Seattle" 
# will be a match for "Seattle, WA". Hint: use the same technique as you did above!
# Your function must NOT reference `all_locations_vector` directly; only use the argument
# (functions should be "stand alone" and not reference non-argument variables)

  count_in_location <- function(location_name, location_vector ) {
    location_name <- str_detect(location_vector, location_name)
    total <- length(location_name[location_name == TRUE])
        return(total)
  }
  
#count_in_location("Washington", all_locations_vector)
#count_in_location("Seattle, WA", all_locations_vector)
#count_in_location("Boise, ID", all_locations_vector)
#count_in_location("Caldwell, ID", all_locations_vector)
#count_in_location("New York, NY", all_locations_vector)
#count_in_location("Los Angeles, CA", all_locations_vector)

# Use your function to count the number of protests in "Washington, DC". Store the
# result in `dc_count`
# See how clean having a separate function is?

dc_count <- count_in_location("Washington, DC", all_locations_vector)
  
# Use your function to describe the number of protests in "Minneapolis", with format:
#    "There were N protests in Minneapolis." 
# (where N is the number of protests) Note spacing and punctuation!
# Save the result as `minneapolis_summary`

mn_count <- count_in_location("Minneapolis, MN", all_locations_vector)
minneapolis_summary <- paste0("There were ", mn_count, " protests in Minneapolis.")

# Define a variable `all_states` that is a vector of strings, which are the 
# last two characters of the values in the `Location` column.
# Hint: look for another helpful function in the `stringr` package. Remember
# that you can use negative indices!

 #loc_str_totals <- max(nchar(protests_df$Location))
 #loc_str_indices <- length(protests_df$Location)
 #loc_to_string <- print(toString(protests_df$Location, width = NULL))
  all_states <- str_sub(protests_df$Location[1:38097], -2)
    
# Define a variable `unique_states` that are the unique state abbreviations in
# the dataset.

  unique_states <- unique(all_states)
  
  #print(unique_states)

# Define a variable `state_counts` that is a tagged (named) vector of counts for
# each state. Do this by using the `sapply()` function, passing your `unique_states`
# variable, your `count_in_location` function, and the `Location` vector as arguments
#
# Note how amazing this is! sapply() let you call your function on entire vector at once!
# Optional: use the View() function to more easily read the vector
  
 state_counts <- c(sapply(unique_states, count_in_location, protests_df$Location))
  
 View(state_counts)

# You can create a tabular representation of this data by using the `table()`
# function, passing in the `all_states` variable. Save the result in `state_table`
# Optional: use the View() function to more easily read the table

 state_table <- table(all_states)
 View(state_table)
 
# Reflection #3: Looking at your state counts, what data quality issues do you 
# notice? What would you have to do to "fix" these issues (you do not need to
# actually make any changes!)

 #There's a lot of repetition of individual states due to case (CO vs. co) as well as 
 #questionable states values such as "te" which I don't believe is an actual state

# What was the maximum number of protests in a single state? Save your result
# in `max_state_count`

 max_state_count <- sort(state_table, decreasing = TRUE)[1]

###############################################################################
##### PART 3: Dates #####
### In this section you will explore *when* protests occurred

# For clarity, extract the `Date` feature from the `protests_df` data frame
# into a variable called `protest_dates_string_vector`
 
protests_dates_string_vector <- protests_df$Date

# Define a variable `protest_dates` that is the values of `protests_dates_string_vector`
# but as `Date`-types (not strings!). You can convert the strings into `Date` values 
# using the `as.Date()` function (luckily, the strings are formatted for easy conversion).
# - Note that you can check the "type" of a variable by using the `class()` function. 
#   For example `class(protest_dates)` should produce `"Date"`.

 protest_dates <- as.Date(protests_dates_string_vector) 

# What is the most recent date in the dataset? Save this value as `most_recent_date`
# Hint: the `max()` function works just fine with Date types!

 most_recent_date <- max(protest_dates)

# What is the earliest date in the dataset? Save this value as `earliest_date`

 earliest_date <- min(protest_dates)

# What is the length of the time span of the dataset? That is, how much time
# is there between the earliest and latest protest? Save this value as `time_span`
# Hint: If you subtract `Date` types, you'll get a `difftime` ("time difference") type;
# this value will appear blank in RStudio's Environment variables list, but you can
# print it out to see it's value.
 
 time_span <- print(most_recent_date - earliest_date)
 

# Define a vector `dates_in_2020` containing protest dates that are in 2020.
# Use vector filtering. Hint: filter for dates that are after Jan 1

 dates_in_2020 <- protest_dates[protest_dates >= "2020-01-01" & protest_dates < "2021-01-01"]

# Define a vector `dates_in_2019` containing protest dates that are in 2019.
# Use vector filtering. Hint: you can use the & operator to have multiple 
# filter conditions!

 dates_in_2019 <- protest_dates[protest_dates >= "2019-01-01" & protest_dates < "2020-01-01"]

# By what ratio did the number of protests in 2020 change from the number in 2019?
# Save the result in `ratio_dates_2020_to_2019`

 ratio_dates_2020_to_2019 <- paste0(length(dates_in_2019), ":", length(dates_in_2020))
 
 #(length(dates_in_2020) /length(dates_in_2019))
 
# Reflection #4: Does the change in the number of protests from 2019 to 2020
# surprise you? Why or why not?

#This doesn't surprise me because George Floyd was killed in 2020 and the pandemic 
#also began in Jan of 2020 there's groups of people who protested both of these events. 
# Also we had a very contentious election cycle.
 

 # Define a function called `describe_protests_on_date()`. This function will
# expect 2 arguments:
#   1) a date in time (as a `Date` type), and
#   2) a vector of Date values (like your `protest_dates` vector)
# The function will return a string with the format:
#   "There were N protests on DATE."
# where N is the number of protests, and DATE is the date provided.
# Your function must NOT reference your `protest_dates` variarble directly!

 describe_protests_on_date <- function(Date, DateVector) {
   protestsondate <- DateVector == Date
   count <- length(protestsondate[protestsondate] == TRUE)
    Protests_on_date <- paste0("There were ", count, " protests on ", Date)
    return(Protests_on_date)
  }
#sampledate <- as.Date("2020-07-01")
#describe_protests_on_date(sampledate, protests_dates_string_vector)

# Using your function, how many protests were there on May 24th, 2020? Save 
# your result as `num_protests_may_24`

describe_protests_on_date("2020-05-24", protests_dates_string_vector)

# Using your function, how many protests were there on May 31th, 2020 (1 week 
# later)? Save your result as `num_protests_may_31`

num_protests_may_31 <- describe_protests_on_date("2020-05-31", protests_dates_string_vector)

# For more on this timeline, see: 
# https://www.nytimes.com/article/george-floyd-protests-timeline.html


# How many protests occurred during each month of 2020? Save your result as
# `protest_counts_by_month`
# Hint: You can use the `months()` function to extract the "month" from each
# date in your `protests_dates`. Then you can use the `table()` function to
# count those occurrences.

 protest_counts_by_month <- print(table(months(dates_in_2020)))

# As an example, calculate the *difference* in the number of protests between
# July 2020 and July 2019. Store your result in `change_july_count`
# You will probably want to do this in multiple steps (making intermediate
# variables as necessary).

 
 July_2020 <- length(protest_dates[protest_dates >= "2020-07-01" & protest_dates < "2020-08-01"])
 July_2019 <- length(protest_dates[protest_dates >= "2019-07-01" & protest_dates < "2019-08-01"])
 
change_july_count <- July_2020 - July_2019


# Reflection #5: For this reflection, do some outside research. Find at least 
# *two (2) specific policies* that have been changed as a result of protests 
# in 2020. These may be at the city, state, or University level. Provide a basic
# summary of the policy change, as well as a link to your source.

#In June of 2020, USA today reported that 11 states had placed a ban on police use of chokeholds
#as well as another 5 states banning the use of neck restraint.
#https://www.usatoday.com/in-depth/news/2020/06/18/2020-protests-impact-city-and-state-changes-policing/5337751002/ 

###############################################################################
##### PART 4: Protest Purposes #####
### In this section you will explore *why* protests occurred

# For convenience, extract the `Event..legacy..see.tags.` column from your
# `protests_df` data frame into a variable called `purposes_vector`
purposes_vector <- protests_df$Event..legacy..see.tags.

# How many different (unique) purposes are included in the dataset? Save your
# result as `purposes_count`

purposes_count <- unique(purposes_vector)

# That's quite a few.
# If you `View()` the `purposes` vector, you can notice that many purposes are
# listed with a common format:
 
View(purposes_vector)

#    SOME_PURPOSE (ADDITIONAL_DETAIL)
# Create a variable `high_level_purposes` that is a vector of all of the purpose
# text *before the first parenthesis* (not including spaces). For example, from 
#    "Civil Rights (Black Women's March)"
# You would extract
#    "Civil Rights"

# There are lots of approaches to doing this; try looking at the course text,
# exercises, and `stringr` library for some potentially useful functions.
# One suggestion: remove (replace) everything from the first parenthesis on
# To "find" a parenthesis you may need to use a regular expression "\\("
# This may take a bit of trial and error and searching. Be patient with yourself!

#high_level_purposes <- gsub("\\(.*", "", purposes_vector)
high_level_purposes <- gsub(" \\(.*", "", purposes_vector)

# How many unique "high level" purposes did you identified? Store your result
# in a variable `high_level_purpose_count`

high_level_purpose_count <- length(unique(high_level_purposes))
                                

# Create a frequency count table that counts number of protests for each high 
# level purpose. Save this table as `high_level_purpose table`

high_level_purpose <- table(high_level_purposes)
View(high_level_purpose)

# Reflection #6: Inspect (e.g., `View()`) the `high_level_purpose_table` What 
# does this tell you about the current climate in the U.S.?

#The table suggests that racial injustice and civil rights need serious
#attention in the U.S. People are clearly angry and want real substantial
#change. People are willing to get out and protest to attain this change.
