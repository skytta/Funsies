# Exercise 2-02: Vector operations

# Define a variable `colors` that is a vector containing the following strings: "orange", 
# "violet", "green" (in that order).

colors <- c("orange", "violet", "green")

# Define a variable `primary_colors` that is a vector containing the following strings: 
# "red", "blue", "yellow" (in that order).

primary_colors <- c("red", "blue", "yellow")


# Define a variable `all_colors` that is vector that contains all values in `primary_colors`
# first followed by all values in `colors`. Use the `append()` function. Note that the order
# matters here.

all_colors <- append(primary_colors, colors, 3)


# Define a variable `ones_and_twos` that is a vector consisting of the following six 
# values: 1, 2, 1, 2, 1, 2.

ones_and_twos <- c(1, 2, 1, 2, 1, 2)


# Also define a variable `by_two` that is a vector consisting of the following six values:
# 2, 4, 6, 8, 10, 12. Use the `seq()` function to create the vector.

by_two <- seq(2, 12, 2)

# Define a variable `sums` that is the sum of the `ones_and_twos` and `by_two` vectors.

sums <- ones_and_twos + by_two

# Now, define a variable `ones_twos_short` that is a vector with following two values: 1, 2. 

ones_twos_short <- c(1, 2)

# Define a variable `sums_2` that is the sum of the `ones_twos_short` and `by_two` vectors.

sums_2 <- ones_twos_short + by_two

# Are `sums` and `sums_2` equal? Compare the two vectors using the == operation and store
# the result in `are_equal`. You should have a vector that contains element-wise comparisons.

are_equal <- sums == sums_2

# Exercise 2-05: Vector indexing and filtering

# Define a variable `phone_number` that is a vector containing the following numbers (in the
# same order): 8, 6, 7, 5, 3, 0, 9.

phone_number <- c(8, 6, 7, 5, 3, 0, 9)

# Change the 5 in the `phone_numbers` vector to a 4.

phone_number[4] <- 4

# Define a `prefix` vector that contains the first three numbers of the `phone_number` variable.

prefix <- phone_number[1:3]

# Define a `ending` vector that contains the last four numbers of the `phone_number` variable.

ending <- phone_number[4:7]

# Print the `phone_number` variable such that the digits are of the form "XXX-XXXX". Use the
# `prefix` and `ending` variables to do this. You will need to use the `paste()` function's
# `collapse` argument to be an empty string ("") so that there are no spaces between the vector
# values when you paste them together.

print(paste(c(prefix, "-", ending), collapse = ""))

# Define a `phone_number_2` vector that contains the same digits as `phone_number` except the
# 0. It should contain 6 digits. Hint: you can use negative indices to remove elements.

phone_number_2 <- phone_number[-6]

# Add a 2 digit to the `phone_number_2` vector in the sixth position. All subsequent digits
# should shift down one position. To do this, first store the first 5 elements of
# `phone_number_2` in a vector called `first_half` and the remaining elements in a vector
# called `second_half`. Then use the `append()` function to concatenate `first_half` to a vector
# containing the number 2. Then use the `append()` function to concatenate the result to the
# `second_half`. Store the result as `phone_number_2`. Note that there are alternate ways to 
# do this using libraries/functions but for this exercise, follow the process above.

first_half <- c(phone_number_2[1:5])
second_half <- c(phone_number_2[6])
new_vector <-c(2)
added_2_variable <- append(first_half, new_vector, after = 5)
phone_number_2 <- append(added_2_variable, second_half, after = 6)

# Define a function `get_middle_value` that takes a single vector as an argument. The 
# function should return which value is in the "middle position" of the vector. So if there are 
# 5 values in the vector, the function should return the value at index 3 (the 3rd value). If 
# there are an even number of elements, the function should "round down" to the middle value 
# (so for a vector of 4 elements, return the value at index 2). Be sure to test your the function 
# by calling it on both even and odd-length vectors

get_middle_value <- function(vector_arg) {
  middle_value <- (length(vector_arg) / 2)
  if((middle_value %% 2) == 0) {
    return(middle_value)
  } else {
    rounded_middle <- ceiling(middle_value)
    return(rounded_middle)
  }
}

# Define a variable `middle_digit` that is the middle digit from your `phone_number` variable.
# Use your `get_middle_value` function to find the middle digit.

middle_digit <- get_middle_value(phone_number)

# Filter the digits in `phone_number_2` so that only values greater than 4 are kept. To do this,
# first create a vector called `greater_than_4` that contains 7 logical values corresponding to
# whether each digit in `phone_number_2` is (strictly) greater than 4. Leverage vector operations 
# to do this (i.e. use a single comparison operator on `phone_number_2`). Then use the 
# `greater_than_4` vector to index `phone_number_2`. Store the filtered values in a vector called 
# `filtered_digits`. See Chapter 7.4 of the course textbook for more information on this process.

greater_than_4 <- c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE)
filtered_digits <- c(phone_number_2)[greater_than_4]

# Exercise 2-08: Creating and accessing lists

# Define a variable `rectangle` that is a list containing the following elements: `width` with a
# value of 100, `height` with a value of 50, `x` with a value of 25, and `y` with a value of 40.

rectangle <- list(width = 100, height = 50, x = 25, y = 40)


# Access the `width` element of the `rectangle` variable and print it out

print(rectangle$width)

# Access the `rectangle` variable's `width` and `height` values and use them to calculate the 
# area as height * width. Store the result in a variable named `area`.

area <- rectangle$height * rectangle$width

# Access the x- and y- coordinates of the `rectangle` variable, which correspond to its location
# on an X-Y plane. Print out the coordinates in the format: "X, Y".

print(paste0(rectangle$x, ", ", rectangle$y))

# Modify the values of the `rectangle` variable, increasing its x-coordinate by 20 and decreasing 
# its y-coordinate by 10.

rectangle$x <- rectangle$x + 20
rectangle$y <- rectangle$y -10

# Define a variable `circle` that is a list containing the following elements: `radius` with a
# value of 35, `x` with a value of 60, and `y` with a value of 80.

circle <- list(radius = 35, x = 60, y = 80)


# Define a variable `x_distance` which is the `circle` variable's x-coordinate minus the 
# `rectangle` variable's x-coordinate. 

x_distance <- (circle$x) - (rectangle$x)

# Define a function `get_area` that takes in a list representing a shape that is either 
# a circle or a rectangle like you defined above. The function should calculate and return the 
# area of that shape. You will need to use an if statement to determine whether the shape is a 
# rectangle or a circle (for example, if it has a radius value that is not NULL, then it would 
# be a circle). Calculate rectangle area as height * width and circle area as `pi` * (radius)^2. 
# (`pi` is a built-in global variable). Round the output to the nearest whole number. Test your
# function using your `circle` and `rectangle` variables.

# function that takes in list argument 

get_area <- function(shape_list) {
  if(is.null(shape_list$radius)) {
    calc_area <- shape_list$height * shape_list$width
    return(calc_area)
  } else {
    circle_area <- round(pi * (shape_list$radius)^2)
    return(circle_area)
  }
}


# Exercise 2-10: Iteration: lapply

# Create a variable `names` that is a vector containing the names of any three cities.

names <- c("Seattle", "Boise", "Ventura")
#class(names)

# Create a variable `upper_case_names` that is a vector with the cities from `names` all in upper
# case. Use the `sapply()` function along with the `toupper()` function to create the vector.

upper_case_names <- sapply(names, toupper)

# Create a variable `lower_case_names` that is a vector with the cities from `names` all in lower
# case. Use the `sapply()` function along with the `tolower()` function to create the vector.

lower_case_names <- sapply(names, tolower)

# Create a function called `reverse_caps` which takes in a single string as an argument and returns
# the string with the first letter lower case and the remaining letters upper case. For example, if
# the string 'Miami' was passed to the function, it would return 'mIAMI'. If the argument is only
# one character long, it should return the character in lower case. You may want to look into the 
# `substring()` function. Be sure to test your function with different strings to ensure it works as
# expected.

reverse_caps <- function(wordyword) {
  paste0(tolower(substr(wordyword, 1, 1)), toupper(substr(wordyword, 2, nchar(wordyword))))
}

#test <- reverse_caps("Jenny")  
#class(test)

# Create a variable `reverse_caps_names` that is a vector with the cities from `names` after having
# been passed through your `reverse_caps` function. Use the `sapply` function

reverse_caps_names <- sapply(names, reverse_caps)
#class(reverse_caps_names)
#print(reverse_caps_names)

# Create a variable `reverse_caps_names_list` that is a list with the cities from `names` after having
# been passed through your `reverse_caps` function. Use the appropriate `*apply` function to return a list

reverse_caps_names_list <- lapply(names, reverse_caps)

# Exercise 2-13: For loops

# In the previous exercise, you created a vector of city names and then converted the names to 
# all be upper case and then all be lower case. Here we will repeat some of that using for loops. 
# Start by defining a vector called `names` that has the names of any three cities.

names <-c("Shoreline", "Tacoma", "Edmonds")

# We will now be taking each of the cities in `names`` and converting them to be upper case. To do 
# this, create an empty vector named `upper_case_names` (i.e. assign `it`upper_case_names` to `c()`)

upper_case_names <- c()

# Now, create a vector of indices that contains the numeric index of each value in `names`. In other
# words, have this vector start from 1 and continue to the length of the `names` vector. Name this
# vector `indices`. Do not code this vector by hand but instead use either the `seq()` or 
# `seq_along()` functions.

indices <- seq_along(names)

# Now, instead of using *apply functions, use a for loop to convert each name in `names` to be upper
# case. Store the result in the corresponding index of `upper_case_names`. One way in which to do 
# this is to have an iterator (i) go through your `indices` vector 
# (e.g. `for (i in indices)`) and then modify values of `names[i]` and store them in 
# `upper_case_names[i]`

for (i in indices) {
  upper_case_names[i] <- toupper(names[i])
  print(upper_case_names)
}

upper_case_names
# You probably noticed how using a for loop was much less efficient than using a *apply function. In 
# fact, you'll rarely encounter situations where a for loop is an optimal programming strategy in R 
# - typically, vectorized operations and *apply functions are faster to write, computationally 
# optimized, and easier to read/understand.

# However, there are still some instances where using a for loop tends to work well. Some examples 
# include when we want to index multiple elements at a time, rely on previous values of a vector, or 
# index in some non-sequential way. To demonstrate this, let's  of this is calculating a cumulative 
# sum across a vector.

# Create a vector named `numbers` that contains whole numbers from 10 to 1, counting backwards (i.e.
# the vector should contain 10, 9, 8, 7... 1). You can use the `seq()` function to do this (just
# reverse the order of what you would use when counting up!).

numbers <- c(seq(10, 1))

# Now, create a variable named `sums` that is an empty vector (i.e. assign sums` to `c()`). We will
# use this vector to store the cumulative sum calculations across `numbers`.

sums <- c()

# Now, use a for loop to iterate through `numbers` and, for each value, add the value to the previous 
# value of `sums` and store it in the next index. For example, the first value of `sums` should be 10, 
# the second value should be 19 (10 + 9), the third value should be 27 (10 + 9 + 8), and so on (hint: 
# it may be useful to have a running total stored in a variable which is updated and stored in the 
# appropriate index of `sums` at each iteration)

running_total <- 0
for(i in numbers) {
  #print(i) #10, 9, 8 
  #print(numbers[i])
  sums[numbers[i]] <- i + running_total
  running_total <- sums[numbers[i]]
}

sums

