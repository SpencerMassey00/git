# Mini-Project 5 Validation
# By Spencer Massey


# clear workspace
rm(list = ls())


# load packages
library(tidyverse)
library(magrittr)


# load data
data <- read.csv('C:/Users/Spenc/Downloads/rrData.csv') # data should be 200 obss x 4 variables
data$participant <- factor(data$participant) # make participant variable a factor
table(data$participant) # should be 10 repeats per participant




# LINE PLOT ----
# reshape the data into long format so that there are 4 columns: participant, time, feature (rr or rr_fft), and value
data_long <- gather(data, feature, value, rr:rr_fft, factor_key = TRUE) # data_long should be 400 obs. x 4 variables


# line plot
ggplot(data_long, aes(time, value, color = feature)) +
  geom_line() +
  geom_point() + 
  labs(title = "Figure 1: Line Plot",
       y = "RR (brpm)", x = "Elapsed Time (s)") +
  facet_wrap(~ participant)


# BAR PLOT ----
# find the mean and standard deviation within each participant-feature
summary <- data_long %>% group_by(participant, feature) %>% summarize(mean = mean(value), standard_deviation = sd(value)) # summary should be  40 obs. x 4 variables


# bar plot
ggplot(summary, aes(participant, mean, fill = feature)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Figure 2: Bar Plot",
       y = "RR (brpm)", x = "Participant") +
  geom_errorbar(aes(ymin = mean - standard_deviation, ymax = mean + standard_deviation), position=position_dodge())


  
# SCATTER PLOT ----
# fit linear model to data, y = rr_fft, x = rr)
fit <- lm(data$rr_fft ~ data$rr)


# combine text for equation
eq <- substitute(italic(y) == a + b %.% italic(x)*", "~~italic(r)^2~"="~r2, 
                 list(a = format(unname(coef(fit)[1]), digits = 2),
                      b = format(unname(coef(fit)[2]), digits = 2),
                      r2 = format(summary(fit)$r.squared, digits = 2)))
text <- as.character(as.expression(eq));


# scatter plot
ggplot(data, aes(rr, rr_fft)) +
  labs(title = "Figure 3: Scatter Plot",
       y = "RRFFT (brpm)", x = "RR (brpm)") +
  geom_point(alpha = 0.3) +
  geom_smooth(method = lm) +
  annotate("text", x = 30, y = 30, label = text, parse = TRUE) 



# BLAND-ALTMAN PLOT ----
# caclulate and save the differences between the two measures and the averages of the two measures
data %<>% mutate(difference = rr - rr_fft, average = (rr + rr_fft) / 2)

mean_bias <- mean(data$difference)
lower <- mean_bias - 1.96 * sd(data$difference)
upper <- mean_bias + 1.96 * sd(data$difference)

# Bland-Altman plot
ggplot(data, aes(average, difference)) +
  labs(title = "Figure 4: Bland-Altman Plot",
     y = "Difference between Measures (rr - rr_fft) (brpm)", x = "Average of Measures (brpm)") +
  geom_point(alpha = 0.3) +
  geom_hline(yintercept = mean_bias, color = "green") +
  geom_hline(yintercept = lower, color = "orange", linetype="dashed") +
  geom_hline(yintercept = upper, color = "orange", linetype="dashed") 



# BOX PLOT ----
# box plot
ggplot(data, aes(participant, difference, color = participant)) +
  labs(title = "Figure 5: Box Plot",
       y = "Difference between Measures (rr - rr_fft) (brpm)", x = "Participant") +
  theme(legend.position="none") +
  geom_boxplot()






