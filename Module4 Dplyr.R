install.packages("dplyr")
library("dplyr")
install.packages("pscl")
library("pscl")
View(presidentialElections)
votes <- select(presidentialElections, year, demVote)
select(presidentialElections, state:year)
select(presidentialElections, -south)
votes_2008 <- filter(presidentialElections, year == 2008)
#break up each condition filter for clarity 
votes_colorado <- filter(presidentialElections, 
                         year == 2008, 
                         state == "Colorado")

most_dem_votes <- filter(votes_2008, demVote == max(demVote))
most_dem_state <- select(most_dem_votes, state)

#Using anoymous variables below
most_dem_state <- select(    # 3. Select name of the state
  filter((                   # 2. Filter down to the highest `demVote`
    filter(                  # 1. Filter down to only 2008 votes
      presidentialElections, # arguments for the Step 1 `filter`
      year == 2008),
    demVote == max(demVote)  # second argument for the Step 2 `filter`
  ),
  state                      # second argument for the Step 3 `select`
  )
  
  
#summary statistics of the data by column
#summary takes in DF to aggregate, values that will be computed)
average_votes <- summarize(
  presidentialElections,
  mean_dem_vote = mean(demVote),
  mean_other_parties = mean(other_parties_vote)
)
#if you want to reference, you need to pull() 

#if first row is datatypes, you can remove that row 
presidents_filtered <-filter(dataframe, name != 'String')

# to remove a column, you can use select 
presidents_filtered <- select(dataframe, -columnname)

presidents_filtered <- mutate(dataframe, column = criteria > 75)

#to sort by column criteria  desc = descending 
presidents_filtered <- arrangement(dataframe, desc(rating))

#to convert data values from character to numeric you can add the as.numeric before 
summaries <- summarize(dataframe, mean_column = mean(as.numeric(column)), median_column = median(as.numeric(column)))

#saving our data
write.csv(newname_dataframe, data/newname.csv, row.names = FALSE)

rename()
#grouping by same variable within vectors = 'tibble' - special dataframe that tracks subsets(groups)
grouped <- group_by(presidentialElections, state)

most_dem_state <- presidentialElections %>% # data frame to start with
  filter(year == 2008) %>% # 1. Filter down to only 2008 votes
  filter(demVote == max(demVote)) %>% # 2. Filter down to the highest `demVote`
  select(state) # 3. Select name of the state

state_voting_summary <- presidentialElections %>%
  group_by(state) %>%
  summarize(
    mean_dem_vote = mean(demVote),
    mean_other_parties = mean(other_parties_vote)
#You can extract values from a tibble using dollar sign or bracket notation, or 
#convert it back into a normal data frame with the as.data.frame() function.    

#data(fun_1(fun_2(fun_3)))
#If you wanted to perform the following: fun_3(fun_2(fun_1(data))) 
#(i.e. apply fun_1, pass the result to fun_2, and pass the result to fun_3)

%>%  #Win+Shft+m