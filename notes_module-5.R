ggplot(data = midwest) + ## The +, adds layers of geometric objects
  geom_point(mapping = aes(percollege,percadultpoverty)) ## declaring x=, y= is optional

##Other Geometries: 
# geom_point() for drawing individual points (e.g., for a scatterplot)
# geom_line() for drawing lines (e.g., for a line chart)
# geom_smooth() for drawing smoothed lines (e.g., for simple trends or approximations)
# geom_col() for drawing columns (e.g., for a bar chart)
# geom_polygon() for drawing arbitrary shapes (e.g., for drawing an area in a coordinate plane)

## same data as bars
ggplot(data = midwest) + 
  geom_col(mapping = aes(x = state, y = poptotal))

## plots plus smooth line
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_smooth(mapping = aes(x = percollege, y = percadultpoverty))


# A plot with both points and a smoothed line, sharing aesthetic mappings
ggplot(data = midwest, mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_point() + # uses the default x and y mappings
  geom_smooth() + # uses the default x and y mappings
  geom_point(mapping = aes(y = percchildbelowpovert)) # uses own y mapping

##COLOR
# Change the color of each point based on the state it is in
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)#, alpha = .3)
  )

# Set a consistent color ("red") for all points -- not driven by data
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty),
    color = "red",
    alpha = .2
  )

##Store plot in a var
plot1 <- ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)#, alpha = .3)
  )

#display it using show
show(plot1)

#update axis labels: 
plot1 <- plot1 + xlab("percent in poverty") + ylab("percent with college degrees")
plot1


###Advanced junk

#Stacked Bars: 

# A bar chart of the total population of each state
# The `state` is mapped to the x-axis, and the `poptotal` is mapped
# to the y-axis
ggplot(data = midwest) +
  geom_col(mapping = aes(x = state, y = poptotal))

# A hexagonal aggregation that counts the co-occurrence of college
# education rate and percentage of adult poverty
ggplot(data = midwest) +
  geom_hex(mapping = aes(x = percollege, y = percadultpoverty))


# A plot with both points and a smoothed line
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_smooth(mapping = aes(x = percollege, y = percadultpoverty))

# A plot with both points and a smoothed line, sharing aesthetic mappings
ggplot(data = midwest, mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_point() + # uses the default x and y mappings
  geom_smooth() + # uses the default x and y mappings
  geom_point(mapping = aes(y = percchildbelowpovert)) # uses own y mapping

# Change the color of each point based on the state it is in
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)
  )

# Set a consistent color ("red") for all points -- not driven by data
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty),
    color = "red",
    alpha = .3
  )




# Load the `dplyr` and `tidyr` libraries for data manipulation
library("dplyr")
library("tidyr")

# Wrangle the data using `tidyr` and `dplyr` -- a common step!
# Select the columns for racial population totals, then
# `gather()` those column values into `race` and `population` columns
state_race_long <- midwest %>%
  select(state, popwhite, popblack, popamerindian, popasian, popother) %>%
  gather(key = race, value = population, -state) # all columns except `state`

View(state_race_long) # 3 cols and lots of repeat: State(county obs), Race, Pop

# Create a stacked bar chart of the number of people in each state
# Fill the bars using different colors to show racial composition
ggplot(state_race_long) +
  geom_col(mapping = aes(x = state, y = population, fill = race))
#The example above is "count". 

# Could also use position to "fill" to 100%, could also "dodge" to do side-by-side bars

# Create a percentage (filled) column of the population (by race) in each state
ggplot(state_race_long) +
  geom_col(
    mapping = aes(x = state, y = population, fill = race), position = "fill"
  )

# Create a grouped (dodged) column of the number of people (by race) in each state
ggplot(state_race_long) +
  geom_col(
    mapping = aes(x = state, y = population, fill = race), position = "dodge"
  )


##Without declaring any scales 
# Plot the `midwest` data set, with college education rate on the x-axis and
# percentage of adult poverty on the y-axis. Color by state.
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty, color = state))

### Plot the `midwest` data set, with college education rate and
# percentage of adult poverty. Explicitly set the scales.
ggplot(data = midwest) +
  geom_point(mapping = aes(x = percollege, y = percadultpoverty, color = state)) +
  scale_x_continuous() + # explicitly set a continuous scale for the x-axis
  scale_y_continuous() + # explicitly set a continuous scale for the y-axis
  scale_color_discrete() # explicitly set a discrete scale for the color aesthetic

##Same result ^^^

##Another option
##Want to build two charts with the same (comparable) scales/colors

# Create a better label for the `inmetro` column
##if_else, very cool!
labeled <- midwest %>%
  mutate(location = if_else(inmetro == 0, "Rural", "Urban"))

# Subset data by state
wisconsin_data <- labeled %>% filter(state == "WI")
michigan_data <- labeled %>% filter(state == "MI")


# Define continuous scales based on the entire data set:
# range() produces a (min, max) vector to use as the limits
x_scale <- scale_x_continuous(limits = range(labeled$percollege))
y_scale <- scale_y_continuous(limits = range(labeled$percadultpoverty))

# Define a discrete color scale using the unique set of locations (urban/rural)
color_scale <- scale_color_discrete(limits = unique(labeled$location))

# Plot the Wisconsin data, explicitly setting the scales
ggplot(data = wisconsin_data) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location)
  ) +
  x_scale +
  y_scale +
  color_scale

# Plot the Michigan data using the same scales
ggplot(data = michigan_data) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location)
  ) +
  x_scale +
  y_scale +
  color_scale

###############
#Color Scales -- palette()
#for instance, use set3

# Change the color of each point based on the state it is in
ggplot(data = midwest) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = state)
  ) +
  scale_color_brewer(palette = "Set3") # use the "Set3" color palette

##Or...you can define your own!

#############
##Coordinate (x,y) systems

#For example: Flip the x, y axes for a bar chart
#Also, update the sorting using factor
#Get a top 10 list of counties and draw as a desc order bars

# Create a horizontal bar chart of the most populous counties
# Thoughtful use of `tidyr` and `dplyr` is required for wrangling

# Filter down to top 10 most populous counties
top_10 <- midwest %>%
  top_n(10, wt = poptotal) %>%
  unite(county_state, county, state, sep = ", ") %>% # combine state + county
  arrange(poptotal) %>% # sort the data by population
  mutate(location = factor(county_state, county_state)) # set the row order

# Render a horizontal bar chart of population
ggplot(top_10) +
  geom_col(mapping = aes(x = location, y = poptotal)) +
  coord_flip() # switch the orientation of the x- and y-axes

## FACETS: or "subplots"
# Create a better label for the `inmetro` column
labeled <- midwest %>%
  mutate(location = if_else(inmetro == 0, "Rural", "Urban"))

# Create the same chart as Figure 16.9, faceted by state
ggplot(data = labeled) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location),
    alpha = .6
  ) +
  facet_wrap(~state) # pass the `state` column as a *fomula* to `facet_wrap()

###########
#LABELS AND ANNOTATION
# Adding better labels to the plot in Figure 16.10
ggplot(data = labeled) +
  geom_point(
    mapping = aes(x = percollege, y = percadultpoverty, color = location),
    alpha = .6
  ) +
  
  # Add title and axis labels
  labs(
    title = "Percent College Educated versus Poverty Rates", # plot title
    x = "Percentage of College Educated Adults", # x-axis label
    y = "Percentage of Adults Living in Poverty", # y-axis label
    color = "Urbanity" # legend label for the "color" property
  )

#geom_label_repel
# Load the `ggrepel` package: functions that prevent labels from overlapping
library(ggrepel)

# Find the highest level of poverty in each state
most_poverty <- midwest %>%
  group_by(state) %>% # group by state
  top_n(1, wt = percadultpoverty) %>% # select the highest poverty county
  unite(county_state, county, state, sep = ", ") # for clear labeling
#View(most_poverty)

# Store the subtitle in a variable for cleaner graphing code
subtitle <- "(the county with the highest level of poverty
  in each state is labeled)"


# Plot the data with labels
ggplot(data = labeled, mapping = aes(x = percollege, y = percadultpoverty)) +
  
  # add the point geometry
  geom_point(mapping = aes(color = location), alpha = .6) +
  # add the label geometry
  geom_label_repel(
    data = most_poverty, # uses its own specified data set
    mapping = aes(label = county_state),
    alpha = 0.8
  ) +
  
  # set the scale for the axis
  scale_x_continuous(limits = c(0, 55)) +
  
  # add title and axis labels
  labs(
    title = "Percent College Educated versus Poverty Rates", # plot title
    subtitle = subtitle, # subtitle
    x = "Percentage of College Educated Adults", # x-axis label
    y = "Percentage of Adults Living in Poverty", # y-axis label
    color = "Urbanity" # legend label for the "color" property
  )

top_10_c02_plot <- ggplot(data = top_10_co2_countries) + 
  geom_col(mapping = aes(x = iso3c, y = EN.ATM.CO2E.KT)) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Top 10 Countries by CO2 Emissions", 
    x = "Country (iso3)", 
    y = "CO2 emissions (kt)", # y-axis label
  ) 

us_wealth_plot <-  ggplot(data = us_income_years) +
  geom_smooth(mapping = aes(x = date, y = percentage, color = category)) +
  geom_point(mapping = aes(x = date, y = percentage, color = category)) +
  scale_color_discrete(labels = c(wealth_top_10 = "Top 10% of Pop.", wealth_bottom_40 = "Bottom 40% of Pop.")) +
  labs(
    title = "US Wealth (In)Equality Over Time", 
    x = "Year",
    y = "Percentage of income held"
  )
state_shape <- map_data("state")

# Create a blank map of U.S. states
ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    color = "white", # show state outlines
    size = .1        # thinly stroked
  ) +
  coord_map() # use a map-based coordinate system
# Load evictions data
evictions <- read.csv("data/states.csv", stringsAsFactors = FALSE) %>%
  filter(year == 2016) %>% # keep only 2016 data
  mutate(state = tolower(state)) # replace with lowercase for joining

# Join eviction data to the U.S. shapefile
state_shape <- map_data("state") %>% # load state shapefile
  rename(state = region) %>% # rename for joining
  left_join(evictions, by="state") # join eviction data

#Define a minimalist theme for maps
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
    
# Draw the map setting the `fill` of each state using its eviction rate
ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = eviction.rate),
    
    color = "white", # show state outlines
    size = .1        # thinly stroked
  ) +
  coord_map() + # use a map-based coordinate system
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Eviction Rate") +
  blank_theme # variable containing map styles (defined in next code snippet)

ggplot(data = health_costs, mapping = aes(reorder(x = iso3c, amount), y = amount, color = indicatorID)) +
  geom_linerange(data = total_health_costs, mapping = aes(ymin = 0, ymax = amount), show.legend = FALSE) +
  geom_point(mapping = aes(x = iso3c, y = amount, shape = indicatorID, color = indicatorID)) +
  scale_color_brewer(palette = "Dark2", direction = -1) +
  labs(title = "Health Care Expenditures (per capita)",
       x = "Country",
       y = "Current US$",
       color = "Type",
       shape = "Type") +
  theme(axis.text.x = element_text(size = 5, angle = 90), legend.position = c(.2, .8))

fancy_scientific <- function(l) {
  # turn in to character string in scientific notation
  l <- format(l, scientific = TRUE)
  # quote the part before the exponent to keep all the digits
  l <- gsub("^(.*)e", "'\\1'e", l)
  # turn the 'e+' into plotmath format
  l <- gsub("e", "%*%10^", l)
  # return this as an expression
  parse(text=l)
}

scale_y_continuous(labels=function(n){format(n, scientific = FALSE)})+
  