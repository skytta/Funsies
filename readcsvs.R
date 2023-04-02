df <- read.csv('data/cereal.csv', stringsAsFactors = FALSE, sep = ";")
?read.csv

df_filtered <- df
df_filtered <- df_filtered[-1, ]  #removes that first column from our dataframe 
df_filtered <- df_filtered[ , -3] #removes the 3rd column 

write.csv(df_filtered, 'data/filtered_cereal.csv', row.names = FALSE) #saves the new file 

check <- read.csv('data/filtered_cereal.csv', stringsAsFactors = FALSE) # this is to reset our work 
View(check) 


my_df <- read.csv("my_file.csv", stringsAsFactors = FALSE)
write.csv(my_df, "my_new_file.csv", row.names = FALSE)