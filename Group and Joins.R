sugars_by_mfr <- dataframe %>% 
  group_by(column_name) %>% 
  summarize(N = n(),
    mean_sugars = mean(sugars),
    median_sugars = median(sugars))

nutri_info_by_mfr <- dataframename %>% 
  group_by(column) %>% 
  summarize_at(vars(calories, protein, fat, sodium, column, column2) mean)  #summarize has lots variables, columns, function

group_by(my_data, year, south) %>% 
  summarize(mean = mean(demVote))

group_by(my_data, state) %>% 
  summarize(N = n())

#Joins = 2 disparate groups of data and joining together 

company_info <- read.csv("data/company_info.csv" stringsAsFactors = FALSE)
#load in your data 

simple_join <- cereal_filtered %>% 
    left_join(company_info, by"mfr") %>%   #you're joining on company info  if not pipes left_join(cereal_info)
  
company_info_edited <- company_info %>% 
  filter(mfr != 'A')  #not equal to
  
new_company <- data.frame(mfr = c("?"), company_name = c("Private label", location = "Various"))

company_info_edited <-rbind(company_info_edited, new_company)
#rbind() function allows us to append rows to a data frame
#cbind() 
left_join <- cereal_filtered %>% 
    left_join(company_info_edited, by = "mfr")

#left join keeps everything from the "left side" and matching to the right side

right_joined <- cereal_filtered %>% 
  right_joined(company_info_edited, by = "mfr")  

#right join keeps everything from the "right side" and matching to the left side
right_joined <- cereal_filtered %>% 
  innerjoin_joined(company_info_edited, by = "mfr")   #only keeps matches from both data sets

right_joined <- cereal_filtered %>% 
  full_joined(company_info_edited, by = "mfr")    #keeps everything from both data sets and matche where it can

    