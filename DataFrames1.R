turle1 <- list(name = "Leo", color = "blue")
turle2 <- list(name = "Ralph", color = "red")
turle3 <- list(name = "Mike", color = "orange")
turle4 <- list(name = "Done", color = "purple")

all_turtles <- list(name = c("Leo", "Ralph", "Mike", "Done"), color = c("blue", "red", "orange", "purple"))
all_turtles$name
all_turtles[["name"]]

turtles_df <- data.frame(name = c("Leo", "Ralph", "Mike", "Done"), color = c("blue", "red", "orange", "purple"))
turtles_df$weapon <- c("katana", "sai", "nunchaku", "bo")
View(turtles_df)                                            

turtles_df$name
turtles_df[["color"]]

turtles_df[2, 1]
turtles_df[2, "color"]
turtles_df[2, ] # leave blank to pull all column data 

turtles_df[2]
testvector <- c("katana", "sai", "nunchaku", "bo")
testvector2 <- c("love", "butts", "tokens", "data")
testvector3 <- c("names", "dates", "wanted", "yikes")
turtles_df[c(2,4), ]

testingdataframes <- data.frame(testvector, testvector2, testvector3)

colnames(testingdataframes)[1] <- "lookielookie"  #changing first column name 

colnames(testingdataframes) <- c("vook", "Yak", "chak")  #re-nameing my columns 

data(mtcars)
head(mtcars)
View(mtcars)

max(mtcars$hp)
min(mtcars$hp)
 
table(mtcars$cyl)

mtcars[mtcars$cyl == 4, ]$hp
max(mtcars[mtcars$cyl == 4, ]$hp)
max(mtcars[mtcars$cyl == 6, ]$hp)
max(mtcars[mtcars$cyl == 8, ]$hp)

min_mpg <- min(mtcars$mpg)
mtcars[mtcars$mpg == min_mpg, ]

mtcars[mtcars$mpg == max(mtcars$mpg), ]
mtcars[mtcars["mpg"] == max(mtcars["mpg"]), ]

