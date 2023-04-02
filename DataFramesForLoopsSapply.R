# Create a `person` variable storing information about someone
# Code is shown on multiple lines for readability 


#list with tagged elements
person <- list(first_name = "Ada", job = "Programmer", salary = 78000, in_union = TRUE
)

#list with no tagged elements
person_alt <- list("Ada", "Programmer", 78000, TRUE)

#added a list of favorites to the person list (list of lists)
person <- list( first_name = "Ada", job = "Programmer", last_name = "Gomez", salary = 78000, in_union = TRUE,
  favorites = list( music = "jazz", food = "pizza"
  )
)
#ways to access list element by its tag [[]] or $
print(person)
person[["first_name"]]
person[["salary"]]
person$first_name
person$salary

#created a variable and applied the tagged element, then called the new variable as a tag
name_to_use <- "last_name" 
person[[name_to_use]]  
name_to_use <- "first_name"
person[[name_to_use]]  

# you can call the index but its hard to keep track of this
person[[1]]
person[[5]] 

animals <- list("Aardvark", "Baboon", "Camel")
animals[[1]]
animals[[2]]
animals[[3]]


job_post <- list( qualifications = list( experience = "5 years", bachelors_degree = TRUE
  ), responsibilities = c("Team Management", "Data Analysis", "Visualization")
)
#created a variable called job qualifications and stored the tagged elements of job_post list qualifications
job_qualifications <- job_post$qualifications
job_qualifications$experience

job_post$qualifications$experience # "5 years"
job_post$responsibilities[1]

#MODIFYING LISTS
#person age is null as there is no element of this in the existing list
person$age

#assigning a value and then rerunning the above code now pulls the number 40
person$age <- 40
#reassigning new job title
person$job <- "Senior Programmer"
print(person$job)

#increasing the salary element by 15%
person$salary <- person$salary * 1.15 
print(person$salary)

#removing value of first name
person$first_name <- NULL
person$first_name <- "Jenny"

#single brackets pull the list
person["first_name"]

is.list(person["first_name"])
person[["first_name"]]
is.list(person[["first_name"]])
person[ c("first_name", "job", "salary")]

#USING LAPPLY Function 
people <- list("Sarah", "Amit", "Zhang")
#variable <- lapply function( list name, function)
people_upper <- lapply(people, toupper)
print(people_upper)
#variable <- lapply function( list name, paste function, new string name)
dance_party <- lapply(people, paste, "dances!")
print(dance_party)

greet <- function(item) {
  paste("Hello", item) # this last expression will be returned
}

#new function called greetings 
#new function name <- lapply (list, function)
greetings <- lapply(people, greet)
print(greetings)

sapply(people, toupper)


my_list <- list("banana", 2, 2.75)
my_list <- list(name = "banana", qty = 2, price = 2.75)
my_list$name
my_list$sale <- FALSE
#these are the same below
my_list$price
my_list[["price"]]

typeof(my_list["price"])
typeof(my_list[["price"]])

#dividing the tagged value by 2
my_list[["price"]] / 2


my_vec <- c(1, 2)
sort(my_vec)

my_list <- list(n1 = 1, n2 =2)
sqrt(my_list)

lapply(my_list, sqrt)
sqrts <- lapply(my_list, sqrt)

my_vec * 2

multiply <- function(a, b) {
  result <- a * b
  return(result)
}

multiply(2, 5)
lapply(my_list, multiply, 2)
lapply(my_list, multiply, my_vec[2])

names <- c("SEATTLE", "BOISE", "VENTURA")

#Function that lowers the first letter 
reverse_caps <- function(cityname) {
  paste0(tolower(substr(cityname, 1, 1)), substr(cityname, 2, nchar(cityname)))
    }


round_up_to_even <- function(a_number){ 
  # if the remainder when dividing by 2 is not 0, must be an odd number 
  if(a_number %% 2 != 0) { # %% is the modulo function: it gets the remainder 
    return(a_number + 1) # add 1 to make the odd number even 
  } else { 
    return(a_number) # otherwise don't modify 
  }
} 

numbers <- c(8, 6, 7, 5, 3, 0, 9) 
even_numbers <- sapply(numbers, round_up_to_even) 


# Loop through the vec, and FOR EACH number, print it
numbers_vector <- c(1, 2, 3, 4, 5) 
#this is the loop code
for (a_number in numbers_vector) { 
  print(a_number)
}

# Define a vector of numbers 
numbers = c(5.21, 8, 10.8, 3.27, 3.98) 

# A for loop that includes multiple lines of code, including an if statement
for (a_number in numbers) {     
  if (a_number > 5) { 
    print(paste(a_number, "is big")) 
  } else { 
    print(paste(a_number, "is small")) 
  }
}
