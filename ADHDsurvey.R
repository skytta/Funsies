

install.packages("dplyr")
library("dplyr")
install.packages("corrplot")
install.packages("vcd")
library(corrplot)
install.packages("funModeling")
library(tidyr)
library(funModeling) 
library(Hmisc)
library(ggplot2)
library(vcd)
library(ggplot2)
library(scales)


#Import the data
ADHDsurvey <- read.csv(file ='Socialmed1.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
View(ADHDsurvey)
describe(ADHDsurvey)
summary(ADHDsurvey)

#Clean the data

#Process the data
Dx_self_char <- ADHDsurvey$selfdx
ADHDsurvey$Dx_self_char <- Dx_self_char
ADHDsurvey["Dx_self_char"][ADHDsurvey["Dx_self_char"] == 1] <- "Yes"
ADHDsurvey["Dx_self_char"][ADHDsurvey["Dx_self_char"] == 0] <- "No"

Dx_char <- ADHDsurvey$diagnosis
ADHDsurvey$Dx_char <- Dx_char
ADHDsurvey["Dx_char"][ADHDsurvey["Dx_char"] == 1] <- "Yes"
ADHDsurvey["Dx_char"][ADHDsurvey["Dx_char"] == 0] <- "No"

TTadhd <- ADHDsurvey$ttadhd1
ADHDsurvey$TTadhd <- TTadhd
ADHDsurvey["TTadhd"][ADHDsurvey["TTadhd"] == 1] <- "Yes"
ADHDsurvey["TTadhd"][ADHDsurvey["TTadhd"] == 0] <- "No"

Mostused_char <- ADHDsurvey$mostused
ADHDsurvey$Mostused_char <- Mostused_char

ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 6] <- "NoneListed"
ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 5] <- "TikTok"
ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 4] <- "BeReal"
ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 3] <- "Twitter"
ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 2] <- "Snapchat"
ADHDsurvey["Mostused_char"][ADHDsurvey["Mostused_char"] == 1] <- "Instagram"

NonTT <- ADHDsurvey %>% 
  select(socmed, state, mostused, hours, age)

TTpeeps <- ADHDsurvey %>% 
  filter(TikTok==1) 

TThoursdata <- TTpeeps %>% 
  select(hours, Dx_char) 

TTFYP <- TTpeeps %>% 
  select(ttadhd1, fypsupport) 
describe((TTFYP))


TTwADHD <- ADHDsurvey %>% 
  filter(diagnosis==1) 
View(TTpeeps)


# Aggregate to WA state only respondents 
WATotal <- ADHDsurvey %>% 
  filter(state == 1) 

Rx_total_sum <-sum(!is.na(WATotal$rxreceived))
Dx_total_sum <- sum(!is.na(WATotal$diagnosis))

# count of all survey who responded yes (1) to dx vs no (0)
Dx_totals <- table(WATotal$diagnosis)
Rx_totals <- table(WATotal$rxreceived)

DxProportion <- Dx_totals/Dx_total_sum
barplot(DxProportion)

# Calculate proportions as percentages
DxProportion <- (Dx_totals / Dx_total_sum) * 100

# Add custom y-axis
axis(2, las=1, at = seq(0, max(DxProportion), by = 10), 
     labels = paste0(seq(0, max(DxProportion), by = 10), "%"))

# Add x and y axis labels
mtext("Diagnosis", side = 1, line = 3)
mtext("Percentage of Respondents", side = 2, line = 3)
###############################################
# Social Media Used

# Define colors
my_colors <- c("#69C9D0", "#EE1D52", "#2A6D80", "grey", "#3C8C9B", "black")

# Assuming your data frame is named "social_media_data"
ADHDsurvey %>%
  pivot_longer(cols = c(NoneListed, TikTok, BeReal, Twitter, Snapchat, Instagram),
               names_to = "social_media_company",
               values_to = "response") %>%
  filter(response == 1) %>%
  group_by(social_media_company) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = social_media_company, y = count, fill = social_media_company)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -0.5, size = 4) +  # Increase font size to 4
  scale_fill_manual(values = my_colors) +
  labs(x = "Social Media Prevalence", y = "Count of 'Yes'", fill = "Social Media Company") +
  ggtitle("Social Media Platforms: Count of all use with multiple selected by user")

################################################

# AGE
## Creating a bar plot with values directly on top of the bars

ggplot(ADHDsurvey, aes(x = factor(age, levels = c("17", "18-24", "25-34", "35-44", "45-54", "55+")), fill = factor(age))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("#69C9D0", "#EE1D52", "#2A6D80", "grey", "#3C8C9B", "black"), 
                    labels = c("< 17", "18-24", "25-34", "35-44", "45-54", "55+"),
                    name = "Age") +
  labs(x = NULL,  # Remove x-axis tick marks and values
       y = "Count of Total Survey Completers",
       fill = NULL) +
  ggtitle("Social Media Respondent's Age") +
  theme(plot.background = element_rect(fill = "white"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.5)


# Creating a bar plot with values directly on top of the bars
ggplot(ADHDsurvey, aes(x = factor(age, levels = c("17", "18-24", "25-34", "35-44", "45-54", "55+")), fill = factor(age))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("#69C9D0", "#EE1D52", "#2A6D80", "grey", "#3C8C9B", "black"), 
                    labels = c("< 17", "18-24", "25-34", "35-44", "45-54", "55+"),
                    name = "Age") +
  labs(x = NULL,  # Remove x-axis tick marks and values
       y = "Count of Total Survey Completers",
       fill = NULL) +
  ggtitle("Social Media Respondent's Age") +
  theme(plot.background = element_rect(fill = "white"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.5)

ADHDadults <- ADHDsurvey %>% 
  filter(diagnosis == 1)

ADHDTT <- TTpeeps %>%
  filter(diagnosis == 1) %>%
  filter(age %in% c(3, 4, 5, 6))

ADHDTT

# calculations 
23.8 + 17.9


13+86
86/137

27/64 * 100

15/64 *100

show(ageplot)
#Visualize the data

# Create a formula for quick EDA outputs that takes glimpse() which provides a summary of a dataframe's structure including
# number of rows and columns, variable names and datatypes.
# followed by https://www.rdocumentation.org/packages/funModeling/versions/1.9.4/topics/status status() from package funModeling 
# which provides several summary statistics of each variable, such as the number of missing values, 
# the number of unique values, the type of variable, and the frequency of each value.
# then, freq() calculates the frequency distribution. It provides a table that displays the count or percentage of occurrences 
# of each unique value in a dataset.
# profiling_num() from funModeling package provides a summary of numerical variables in the dataset.
# plot_num() from funModeling package creates histograms and box plots of numerical variables in the dataset
# finally, describe() function is a part of the psych package in R, which is used for descriptive statistics and exploratory 
# factor analysis. It provides summary statistics of a dataset.

basic_eda <- function(data)
{
  glimpse(data)
  print(status(data))
  freq(data) 
  print(profiling_num(data))
  plot_num(data)
  describe(data)
}

basic_eda(ADHDsurvey)
basic_eda(TTpeeps)
##############################

# Plot of Most Used Social Media 
MostUsed <- ggplot(ADHDsurvey, aes(x=Mostused_char, fill=Mostused_char)) + geom_bar()+
  labs(title = "Most Used Social Media", 
       x = "Social Media Platform", 
       y = "Total Count") + scale_fill_discrete(guide="none")

# Plot of Those with Clinical ADHD 
ClinicalADHD<- ggplot(ADHDsurvey, aes(x=Dx_char, fill=Dx_char)) + geom_bar() +
  labs(fill="ADHD dx", title = "Survey Respondents with Clinical ADHD", 
       x = "Do you have a clinical Diagnosis of ADHD?", 
       y = "Total Count")

# Those who would self diagnosis 
SelfADHD<- ggplot(ADHDsurvey, aes(x=Dx_self_char, fill=Dx_self_char)) + geom_bar() +
  labs(fill="Dx_self_char", title = "Self Diagnosis", 
       x = "Would you self-diagnosis with ADHD?", 
       y = "Total Count")

# Tik Tok Users with ADHD Content in FYP
ADHDinFYP <- ggplot(TTpeeps, aes(x=TTadhd, fill=TTadhd)) + geom_bar()+
  labs(title = "Tik Tok Users with ADHD Content in FYP", 
       x = "Hours Spent on Social Media", 
       y = "Count") + 
  scale_fill_discrete(guide="none")

# Tik Tok Users Hours 
TThours <- ggplot(TThoursdata, aes(x=hours, fill= Dx_char)) + geom_bar() +
  scale_x_continuous(breaks = c(0.5,1,1.5,2,3,4,5,6,7,8,9,10), labels=c(0.5,1,1.5,2,3,4,5,6,7,8,9,10)) +
  labs(fill="ADHD Diagnosis", 
       title = "TikTok Users Social Media Hours and ADHD Diagnosis", 
       x = "Hours spent on Social Media", 
       y = "Count of TikTok Users") 

# Tik Tok Users and self-diagnosis 
TTselfdxplot <- ggplot(TTpeeps, aes(x=Dx_self_char, fill= TTadhd)) + geom_bar() +
  labs(fill="ADHD Diagnosis", 
       title = "TikTok Users w/ ADHD in FYP and Self Diagnosis", 
       x = "ADHD content in FYP", 
       y = "Self Diagnosis") 

# Tik Tok Users and clinical-diagnosis 
TTdxplot <- ggplot(TTpeeps, aes(x=Dx_char, fill= TTadhd)) + geom_bar() +
  labs(fill="ADHD Diagnosis", 
       title = "TikTok Users w/ ADHD in FYP and Clinical Diagnosis", 
       x = "ADHD content in FYP", 
       y = "Clinical Diagnosis") 

# plots with descriptions 
show(MostUsed)
show(ClinicalADHD)
show(SelfADHD)
show(ADHDinFYP)
show(TThours)
show(TTselfdxplot)
show(TTdxplot)

# Histogram of all numeric variables
ADHDsurvey %>%
  select_if(is.numeric) %>%
  gather() %>%
  ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +
  geom_histogram()


# Calculate Pearson 
# correlation between avg hours on social media of TT users and clinical diagnosis. 
Hours_TT_Cor <- TTpeeps %>% 
  select(hours, diagnosis) 

TT_ADHD <- cor(Hours_TT_Cor$hours, Hours_TT_Cor$diagnosis, method = "pearson")
correlation

CorrFYP <- cor(ADHDsurvey$ttadhd1, ADHDsurvey$hours, method = "pearson")
correlation

# Aim1: Pearson Correlation between TThours and Diagnosis 
CorrFYP <- cor(ADHDsurvey$ttadhd1, ADHDsurvey$hours, method = "pearson")
correlation

# Aim1: Pearson Correlation between TTinFYP and Diagnosis 
CorrFYP <- cor(ADHDsurvey$ttadhd1, ADHDsurvey$diagnosis, method = "pearson")
correlation

# Fit the model (regression analysis) of hours on social media and clinical diagnosis 
model1 <- lm(hours ~ diagnosis, data = ADHDsurvey)

# Print the summary of the model
summary(model1)

# Fit the model (regression analysis) of ADHD content in FYP and ADHD clinical diagnosis 
model2 <- lm(ttadhd1 ~ diagnosis, data = TTpeeps)

# Print the summary of the model
summary(model2)

# Correlation of Self Diagnosis and ADHD in FYP
CorrFYP <- cor(as.numeric(TTpeeps$ttadhd1), as.numeric(TTpeeps$selfdx), method = "pearson")
correlation

# Fit the model (regression analysis) of ADHD content in FYP and ADHD clinical diagnosis 
model3 <- lm(ttadhd1 ~ selfdx, data = TTpeeps)

# Print the summary of the model
summary(model3)

table(TTpeeps$diagnosis)
levels(TTpeeps$diagnosis)

# Creating a jitter plot
ggplot(TTpeeps, aes(x=ttadhd1, y=diagnosis)) +
  geom_jitter(width = 0.1, height = 0.1) +
  ggtitle("Jitter plot of ttadhd1 and diagnosis")

# Creating a bar plot
ggplot(TTpeeps, aes(x=TTadhd, fill=Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Is there ADHD content in your FYP?", 
       y = "Count", 
       fill = "Do you have a clinical diagnosis of ADHD?") +
  ggtitle("Barplot of ADHD in FYP and diagnosis")

# Creating a bar plot
ggplot(TTpeeps, aes(x=TTadhd, fill=Dx_self_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Is there ADHD content in your FYP?", 
       y = "Count", 
       fill = "Would you self-diagnose with ADHD?") +
  ggtitle("Barplot of ADHD in FYP and self-diagnosis")

# Creating a bar plot
ggplot(ADHDsurvey, aes(x=age, fill=age)) +
  geom_bar(position = "dodge") +
  labs(x = "Hours spent on Social Media", 
       y = "Count of TikTok Users", 
       fill = "Would you self-diagnose with ADHD?") +
  ggtitle("Barplot of ADHD in FYP and self-diagnosis")


#remove na from hours column for viz
TTpeeps$hours <- na.omit(TTpeeps$hours)
TTpeeps$Dx_self_char <- na.omit(TTpeeps$Dx_self_char)

# TikTok Blue color
tiktok_blue <- "#69C9D0"
darker_tiktok_blue <- "#3C8C9B"  # Slightly darker shade of TikTok Blue
darker_tiktok_blue2 <- "#2A6D80"

#  Barplot: 
# TikTok ADHD content in FYP and DX

ggplot(ADHDsurvey, aes(x = factor(Dx_char), fill = Dx_self_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Do you have clinical ADHD diagnosis?", 
       y = "Count of Survey Responders", 
       fill = "ADHD diagnosis") +
  ggtitle(expression(atop(bold(textstyle("Survey Respondents (all)", face.bold = TRUE, col = "black")), 
                          atop(italic("Presence of Dx ADHD vs. Self-Diagnosis (with overlap)"), "")))) +
  theme_minimal() +
  scale_fill_manual(values = c("No" = "#69C9D0", "Yes" = "#EE1D52")) +
  theme(axis.text.x = element_text(size = 12,color = darker_tiktok_blue), 
        axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
        axis.title = element_text(size = 14, face = "bold", color = "black"), 
        plot.title = element_text(size = 16, face = "bold", color = "black")) +
  guides(fill = guide_legend(title = "Would self diagnose", override.aes = list(size = 5))) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)



#  Barplot: 
# TikTok ADHD content in FYP and DX

ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Is there ADHD content in your FYP?", 
       y = "Number of TikTok Users", 
       fill = "Do you have a clinical diagnosis of ADHD?") +
  ggtitle("TikTok users: ADHD content in FYP vs. ADHD Clincial diagnosis") +
  theme_minimal() +
  scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
  theme(axis.text.x = element_text(size = 12), 
        axis.text.y = element_text(size = 12), 
        axis.title = element_text(size = 14, face = "bold"), 
        plot.title = element_text(size = 16, face = "bold")) +
  guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)

#  Barplot: 
# TikTok users:  ADHD content in FYP and Clinical DX 
# DARKER BLUE y axis + DARKER BLUE Large and subscript title + legend title 

ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Is there ADHD content in your FYP?", 
       y = "Number of TikTok Users", 
       fill = "ADHD diagnosis") +
  ggtitle(expression(atop(bold(textstyle("Surveyed TikTok users", face.bold = TRUE, col = darker_tiktok_blue2)), 
                          atop(italic("ADHD content in FYP vs. ADHD Clinical diagnosis"), "")))) +
  theme_minimal() +
  scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
  theme(axis.text.x = element_text(size = 12,color = darker_tiktok_blue), 
        axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
        axis.title = element_text(size = 14, face = "bold"), 
        plot.title = element_text(size = 16, face = "bold", color = "black")) +
  guides(fill = guide_legend(title = "ADHD diagnosis", override.aes = list(size = 5))) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)


#  Barplot: 
# All Surveyed: Hours vs Clinical ADHD Dx 
# DARKER BLUE y axis + DARKER BLUE Large and subscript title + legend title 

ggplot(ADHDsurvey, aes(x = factor(hours), fill = Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Average daily hours spent on Social Media", 
       y = "Count of Survey Responders", 
       fill = "ADHD diagnosis") +
  ggtitle(expression(atop(bold(textstyle("Survey Respondents (all)", face.bold = TRUE, col = "black")), 
                          atop(italic("Hours on Social Media & ADHD Clinical diagnosis"), "")))) +
  theme_minimal() +
  scale_fill_manual(values = c("No" = "#69C9D0", "Yes" = "#EE1D52")) +
  theme(axis.text.x = element_text(size = 12,color = darker_tiktok_blue), 
        axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
        axis.title = element_text(size = 14, face = "bold", color = "black"), 
        plot.title = element_text(size = 16, face = "bold", color = "black")) +
  guides(fill = guide_legend(title = "ADHD diagnosis", override.aes = list(size = 5))) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)

#  Barplot: 
# All TT Users: Hours vs Clinical ADHD Dx 
# DARKER BLUE y axis + DARKER BLUE Large and subscript title + legend title 

ggplot(TTpeeps, aes(x = factor(hours), fill = Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Average daily hours spent on Social Media", 
       y = "Count of Survey Responders", 
       fill = "ADHD diagnosis") +
  ggtitle(expression(atop(bold(textstyle("Survey Respondents (who use TikTok)", face.bold = TRUE, col = "black")), 
                          atop(italic("Hours on Social Media & ADHD Clinical diagnosis"), "")))) +
  theme_minimal() +
  scale_fill_manual(values = c("No" = "#69C9D0", "Yes" = "#EE1D52")) +
  theme(axis.text.x = element_text(size = 12,color = darker_tiktok_blue), 
        axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
        axis.title = element_text(size = 14, face = "bold", color = "black"), 
        plot.title = element_text(size = 16, face = "bold", color = "black")) +
  guides(fill = guide_legend(title = "ADHD diagnosis", override.aes = list(size = 5))) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)


# **********************************************************************************************


#  Unused Barplot: 
# TikTok Users Hours and self DX

ggplot(TTpeeps, aes(x = hours, fill = Dx_self_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Average daily hours spent on Social Media", 
       y = "Number of TikTok Users", 
       fill = "Would you self-diagnose with ADHD?") +
  ggtitle("Would you self diagnose with ADHD?") +
  theme_minimal() +  # Set a minimalistic theme
  scale_fill_manual(values = c("No" = "#3C8C9B", "Yes" = "#EE1D52")) +  # Customize fill colors
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 14, face = "bold"), 
        plot.title = element_text(size = 16, face = "bold")) +
  guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)  # Format y-axis labels with commas


# Unused Barplot: 
# TikTok Users Hours and DX

ggplot(TTpeeps, aes(x = hours, fill = Dx_char)) +
  geom_bar(position = "dodge") +
  labs(x = "Average daily hours spent on Social Media", 
       y = "Number of Survey Respondents", 
       fill = "Do you have clinical diagnosis of ADHD?") +
  ggtitle("TikTok-using Survey Respondents with Clinical Diagnosis of ADHD") +
  theme_minimal() +  # Set a minimalistic theme
  scale_fill_manual(values = c("No" = "#69C9D0", "Yes" = "#EE1D52")) +  # Customize fill colors
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 14, face = "bold"), 
        plot.title = element_text(size = 16, face = "bold")) +
  guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)  # Format y-axis labels with commas

# Unused barplot
# Barplot: All Respondents Hours and Diagnosis 
ggplot(ADHDsurvey, aes(x = hours, fill = Dx_char)) +
  geom_bar(position = "dodge", width = 0.3) +
  labs(x = "Average daily hours spent on Social Media", 
       y = "Number of Survey Respondents", 
       fill = "Do you have clinical diagnosis of ADHD?") +
  ggtitle("Survey Respondents with Clinical Diagnosis of ADHD") +
  theme_minimal() +  # Set a minimalistic theme
  scale_fill_manual(values = c("No" = "#69C9D0", "Yes" = "#EE1D52")) +  # Customize fill colors
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 14, face = "bold"), 
        plot.title = element_text(size = 16, face = "bold")) +
  guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
  coord_cartesian(clip = "off") +
  scale_y_continuous(labels = comma)  # Format y-axis labels with commas

#  Barplot: 
# TikTok ADHD content in FYP and DX + BLUE Title 

# ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
#   geom_bar(position = "dodge") +
#   labs(x = "Is there ADHD content in your FYP?", 
#        y = "Number of TikTok Users", 
#        fill = "Do you have a clinical diagnosis of ADHD?") +
#   ggtitle("TikTok users: ADHD content in FYP vs. ADHD Clinical diagnosis") +
#   theme_minimal() +
#   scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
#   theme(axis.text.x = element_text(size = 12), 
#         axis.text.y = element_text(size = 12), 
#         axis.title = element_text(size = 14, face = "bold"), 
#         plot.title = element_text(size = 16, face = "bold", color = tiktok_blue)) +
#   guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
#   geom_text(stat = "count", aes(label = after_stat(count)), 
#             position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
#   coord_cartesian(clip = "off") +
#   scale_y_continuous(labels = comma)

#  Barplot: 
# TikTok ADHD content in FYP and DX + BLUE y axis

# ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
#   geom_bar(position = "dodge") +
#   labs(x = "Is there ADHD content in your FYP?", 
#        y = "Number of TikTok Users", 
#        fill = "Do you have a clinical diagnosis of ADHD?") +
#   ggtitle("TikTok users: ADHD content in FYP vs. ADHD Clinical diagnosis") +
#   theme_minimal() +
#   scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
#   theme(axis.text.x = element_text(size = 12), 
#         axis.text.y = element_text(size = 12, color = tiktok_blue), 
#         axis.title = element_text(size = 14, face = "bold"), 
#         plot.title = element_text(size = 16, face = "bold")) +
#   guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
#   geom_text(stat = "count", aes(label = after_stat(count)), 
#             position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
#   coord_cartesian(clip = "off") +
#   scale_y_continuous(labels = comma)

#  Barplot: 
# TikTok ADHD content in FYP and DX + DARKER BLUE y axis 
# 
# ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
#   geom_bar(position = "dodge") +
#   labs(x = "Is there ADHD content in your FYP?", 
#        y = "Number of TikTok Users", 
#        fill = "Do you have a clinical diagnosis of ADHD?") +
#   ggtitle("Surveyed TikTok users: ADHD content in FYP vs. ADHD Clinical diagnosis") +
#   theme_minimal() +
#   scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
#   theme(axis.text.x = element_text(size = 12), 
#         axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
#         axis.title = element_text(size = 14, face = "bold"), 
#         plot.title = element_text(size = 16, face = "bold")) +
#   guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
#   geom_text(stat = "count", aes(label = after_stat(count)), 
#             position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
#   coord_cartesian(clip = "off") +
#   scale_y_continuous(labels = comma)


#  Barplot: 
# TikTok ADHD content in FYP and DX + DARKER BLUE y axis + Large and subscript title

# ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
#   geom_bar(position = "dodge") +
#   labs(x = "Is there ADHD content in your FYP?", 
#        y = "Number of TikTok Users", 
#        fill = "Do you have a clinical diagnosis of ADHD?") +
#   ggtitle(expression(atop(bold("Surveyed TikTok users"), atop(italic("ADHD content in FYP vs. ADHD Clinical diagnosis"), "")))) +
#   theme_minimal() +
#   scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
#   theme(axis.text.x = element_text(size = 12), 
#         axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
#         axis.title = element_text(size = 14, face = "bold"), 
#         plot.title = element_text(size = 16, face = "bold", color = c("black", tiktok_blue))) +
#   guides(fill = guide_legend(title = NULL, override.aes = list(size = 5))) +
#   geom_text(stat = "count", aes(label = after_stat(count)), 
#             position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
#   coord_cartesian(clip = "off") +
#   scale_y_continuous(labels = comma)


#  Barplot: 
# TikTok ADHD content in FYP and DX + DARKER BLUE y axis + Large and subscript title + legend title 
# 
# ggplot(TTpeeps, aes(x = factor(TTadhd), fill = Dx_char)) +
#   geom_bar(position = "dodge") +
#   labs(x = "Is there ADHD content in your FYP?", 
#        y = "Number of TikTok Users", 
#        fill = "ADHD diagnosis") +  # Update the fill legend title
#   ggtitle(expression(atop(bold("Surveyed TikTok users"), atop(italic("ADHD content in FYP vs. ADHD Clinical diagnosis"), "")))) +
#   theme_minimal() +
#   scale_fill_manual(values = c("No" = "#010101", "Yes" = "#EE1D52")) +
#   theme(axis.text.x = element_text(size = 12), 
#         axis.text.y = element_text(size = 12, color = darker_tiktok_blue), 
#         axis.title = element_text(size = 14, face = "bold"), 
#         plot.title = element_text(size = 16, face = "bold", color = c("black", tiktok_blue))) +
#   guides(fill = guide_legend(title = "ADHD diagnosis", override.aes = list(size = 5))) +  # Update the legend title
#   geom_text(stat = "count", aes(label = after_stat(count)), 
#             position = position_dodge(width = 0.9), vjust = -0.5, size = 4, color = "black") +
#   coord_cartesian(clip = "off") +
#   scale_y_continuous(labels = comma)