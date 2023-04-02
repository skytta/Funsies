# Exercise 3-05: Creating and accessing data frames

# Create a vector called `sports` that has the following values: 'baseball', 'basketball', 'tennis',
# 'golf', 'football', 'running', 'swimming'

sports <- c("baseball", "basketball", "tennis", "golf", "football", "running", "swimming")

# Create a vector called `team_sport` that has the following logical values: TRUE, TRUE, FALSE,
# FALSE, TRUE, FALSE, FALSE

team_sport <- c(TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE)

# Create a vector called `uses_ball` that has the following logical values: TRUE, TRUE, TRUE,
# TRUE, TRUE, FALSE, FALSE

uses_ball <- c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)

# Create a data frame `sports_info` by combining the 3 vectors created above.

sports_info <- data.frame(sports, team_sport, uses_ball)

# Change the column names of the `sports_info` data frame to the following: name, is_team_sport,
# uses_ball

colnames(sports_info) <- c("name", "is_team_sport", "uses_ball")


# Is the sport in the 2nd row a team sport? To answer this, index the appropriate row and column
# and store the result in a variable named `team_sport_2nd_row`

team_sport_2nd_row <-  sports_info[2, 2]




# Create a new data frame called `filtered_sports` that only contains sports that are not team 
# sports but are played with a ball. To do this, use logical indexing. Feel free to use two
# separate filtering steps.
# Instructor Tip: Try to do this one on your own first. Then if you can't figure it out on your own, 
# watch the video in Module 3.6 for a helpful demonstration!

not_team_sports <- sports_info[(sports_info$is_team_sport == FALSE) & (sports_info$uses_ball == TRUE), ]

filtered_sports <- data.frame(not_team_sports)

# Exercise 3-07: Answering questions of data

# Create a vector of 100 products called `products` (i.e. "Product 1", "Product 2", "Product 3"... 
# "Product 100"). To do this efficiently, use the `paste()` function and vector recycling to 
# add a number (as a string) to the end of the word "Product"

products <-  c(paste("Product", seq(1:100)))
#print(products)

# Create a vector of 100 random prices for the products called `prices`. Keep the prices between 5 
# and 15 dollars (inclusive). Round each price to the nearest cent.

prices <- c(round(runif(100, min = 5, max = 15), 2))
#print(prices)

# Create a vector of 100 random price adjustments called `adjustments`. Keep the adjustments between
# a 50% discount to a 50% markup, inclusive (i.e. select numbers between 0.5 and 1.5, inclusive)

adjustments <- c(round(runif(100, min = 0.5, max = 1.5), 2))
#print(adjustments)

# Create a data frame `product_sheet` by combining the 3 vectors created above.

product_sheet <- data.frame(products, prices, adjustments)

# Add a column to `product_sheet` called `adjusted_price` that is the adjusted price for each product
# The adjusted price of the is the price of the product multiplied by the adjustment. Be sure to 
# round the adjusted price to the nearest cent.

product_sheet$adjusted_price <- c(adjustments * prices)
print(product_sheet$adjusted_price)

# Add a column to `product_sheet` called `big_sale` that indicates whether the product received a
# discount of at least 25%.

product_sheet$big_sale <- product_sheet$adjustments < 0.75 
#print(product_sheet$big_sale)
#View(product_sheet)

# What was the adjusted price for "Product 50"? Store it in a variable called `product_50_price`.

product_50_price <- product_sheet[50, 4]

# How many products received a `big_sale` designation? Store the count of the number of products in a 
# variable called `num_of_big_sale_products`.

num_of_big_sale_products <- sum(product_sheet$big_sale == TRUE)

# How many products received a markup? In other words, how many products had a price adjustment that was
# higher than 1.0? Store the count of the number of products in a variable called `num_getting_markup`.

num_getting_markup <- sum(product_sheet$adjustments > 1.0)

# Which product had the lowest starting price (i.e. lowest price prior to adjustments)? Store the name 
# of the product in a variable called `lowest_starting_price`. If there is a tie, choose the first 
# product in the tied set.


min_price <- min(prices)
lowest_starting_price <- product_sheet[product_sheet$prices == min_price, 1]


# Which product had the highest price after adjustments? Store the name of the product in a variable 
# called `highest_adjusted_price`. If there is a tie, choose the first product in the tied set.

high_price <- max(product_sheet$adjusted_price)
highest_adjusted_price <- product_sheet[product_sheet$adjusted_price == high_price, 1]
# Exercise 3-10: Command line
# Write the commands that will complete the following tasks.
# You can test your work in the Terminal.
#
# Note that there are no automated tests for this exercise.


# Print the current working directory.



# List the contents of the current directory.



# Change directory into the `data/` directory.



# Use the `head` command to view the first 10 lines of the 
# `seuss.txt` file found in the `data/` directory.



# Change directory back to the `home/` directory (the one 
# that contains the `data/` folder). 
# DO NOT use an absolute path!



# WITHOUT CHANGING DIRECTORIES, use the `wc` command to 
# count the number of  lines, words, and characters in the
# `seuss.txt` file found in the `data/` directory.

# Exercise 3-13: Data files

# Read in the Building_Permits.csv file in the data/ folder and store it in a data frame named
# `permits`. This file contains building permits from the City of Seattle. See the link below 
# for more info. Be sure set the working directory to the appropriate folder location.
# https://data.seattle.gov/Permitting/Building-Permits/76t5-zqzr

permits <- read.csv('data/Building_Permits.csv', stringsAsFactors = FALSE)

# How many unique values are in the `OriginalCity` column of the dataset? Store the unique values
# in a vector called `unique_cities`. As you can see - there is only one unique city but there are
# multiple variations on how it is stored in the data. (hint: you may want to look into the 
# `unique()` function)

unique_cities <- c(unique(permits$OriginalCity))

# Suppose we only want information on closed permits that have a valid type description. Filter 
# the permits data frame to only include rows where the `StatusCurrent` column is "Issued" and
# the `PermitTypeMapped` is "Building". Store the filtered data frame as `filtered_permits`. It is
# fine to do the filtering across successive steps

View(filtered_permits)
filtered_permits <- permits
#Filter the permits data frame to only include rows where the `StatusCurrent column is "Issued"
filtered_permits <- filtered_permits[filtered_permits$StatusCurrent == "Issued", ]
#PermitTypeMapped`is "Building"
filtered_permits <- filtered_permits[filtered_permits$PermitTypeMapped == "Building", ]


# How many unique values for the `PermitClass` column are in `filtered_permits`? Store the unique 
# values in a vector called `unique_permit_classes`.

unique_permit_classes <- c(unique(filtered_permits$PermitClass))

# We'll work with this filtered dataset in future exercises and look at the values in the
# `PermitClass` column. Store the entire `filtered_permits` data frame as a file named
# 'filtered_building_permits.csv'. Set `row.names` to FALSE when saving.

write.csv(filtered_permits, 'filtered_building_permits.csv', row.names = FALSE)

# Read the filtered_building_permits.csv file that you just saved back in and store the data in a
# data frame named `test_read_write`. Ensure that test_read_write has the same dimensions as your
# `filtered_permits`. If it doesn't, you should check that `row.names` was appropriately set
# in the previous step and re-save.
test_read_write <- read.csv('filtered_building_permits.csv', stringsAsFactors = FALSE)



