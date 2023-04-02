



v1 <- c(1, 2, 3, 4)
v2 <- c(4, 3, 2, 1)

v3 <- v1 + v2 

v4 <- c(1.2, 1.5, 4.7, 3.9)
v5 <- round(v4)

paste(c("The color", "The color", "The color"), c("blue", "red", "green"))

paste(c("The color"), c("blue", "red", "Green"))

v6 <- c(1, 0)

v7 <- v1 + v6

numbers <- c(1,2,3,4,5)
print (numbers)

people <- c("Sarah", "Amit", "Zhang")
people_length <- length(people)
print(people_length)

one_to_seventy <- seq(1, 10)
print(one_to_seventy)

one_to_thirty <- seq(1, 30)
print(one_to_thirty)

odds <- seq(1, 10, 2)
print(odds)

one_to_twenty <- seq(1:70) 
print(one_to_twenty)

v9 <- c(1:5)
result <- v9 + 1
print(result)

v10 <- 1:5
result <- v10 + 4
print(result)

is.vector(18)
is.vector("Hello")
is.vector(TRUE)

x <- 7
print(x)

introduction <- "Hello"
nchar(introduction)

introductions <- c("Hi", "Hello", "Howdy")
nchar(introductions)

colors <- c("Green", "Blue")
locations <- c("sky", "grass")
band <- paste(colors, locations, sep = "")
print(band)

people <- c("Sarah", "Amit", "Zhang")
first_person <- people[1]
print(first_person)

second_person <- people[2]
print(second_person)

last_index <- length(people)
last_person <- people[last_index]

vowels <- c("a", "e", "i", "o", "u")
vowels[10] 
all_but_e <- vowels[-2]
print(all_but_e)


#vector of indices
colors <- c("red", "green", "blue", "yellow", "purple")
indices <- c(1, 3, 4)
extracted <- colors[indices]
print(extracted)

others <- colors[c(2, 5)]
print(others)

colors <- c("red", "green", "blue", "yellow", "purple")
print(colors[2:5])


#vector of logical (boolean) - its only printing the true values - this demonstrats filtering operation
shoe_sizes <- c(5.5, 11, 7, 8, 4)
filter <- c(TRUE, FALSE, FALSE, FALSE, TRUE)
print(shoe_sizes[filter])

shoe_sizes <- c(5.5, 11, 7, 8, 4)
shoe_is_small <- shoe_sizes < 6.5 
small_shoes <- shoe_sizes[shoe_is_small]
print(small_shoes)

#You can even combine the second and third lines of code into a single statement. 
#You can think of the following as saying shoe_sizes where shoe_sizes is less than 6.5:
shoe_sizes[shoe_sizes < 6.5] 

#Modifying Vectors
#establishing our elements 
prices <- c(25, 28, 30)
#renaming our element in index position 1 to 20
prices[1] <- 20
print(prices)

#adding another element to the vector
prices[4] <- 32
print(prices)

#adding another index to the end and then specified the element 
new_index <- length(prices) + 1
prices[new_index] <- 35
print(prices)

#line 1 creates the vector with the elements - then we say pos 2 and 3 change to tablet and pencil
school_supplies <- c("Backpack", "Laptop", "Pen")
school_supplies[ c(2, 3)] <- c("Tablet", "Pencil")
print(school_supplies)

#there is no 6th position so it puts in NA
prices <- c(25, 28, 30)
prices[6] <- 60
print(prices)

#create vector -> add another person Josh so you don't have to know the indices 
people <- c("Sarah", "Amit", "Zhang")
more_people <- c(people, "Josh")
print(more_people)

#create vector -> all elements >10 now become the number 10 so 55, 11 and 27 changes to 10
v11 <- c(1, 5, 55, 1, 3, 11, 4, 27)
v11[v11 > 10] <- 10
print(v11)

#indexing / indices
names <- c("Luke", "Han", "Leia", "Chewey")

names[2]
names[3]

#this means to remove 2 element from names
all_but_han <- names[-2]

indices <- c(1, 4, 2)
names[indices]

ages <- c(50, 24, 67, 18, 93, 45)
is_senior <- ages >= 65
#this line is pulling only the ones that meet that criteria into my variable names seniors
seniors <- ages[is_senior]
#another way to do the same thing
seniors <- ages[ages >=65]

#replacing chewey from names with Lando
names[4] <- "Lando"

#Adding another element to the vector named Yoda
names[5] <- "Yoda"

#when I don't know placement and number of elements, we can add an element by using length function variable + 1
new_index <- length(names) + 1
names[new_index] <- "C3PO"

names <- c(names, c("Chewey", "R2D2"))

one_to_seventy <- seq(1, 70)
print(one_to_seventy)

add100 <- c(as.character(1:100))
Product <- c("Product")

Pleasework <- paste0(product, (seq(1:100)))

#set.seed

