######################
## ECON 172 Section 2
## Introduction to R
######################

## Set the directory where we are going to work.
setwd("~/ECON172_Spring2019_R/Section_02/")

## PART I: Getting Started in R 

## Now we want to open some data.
library(haven) #this library allows you to load datasets in Stata format
#colonials <- read_stata("colonials.dta")
colonials <- read_stata("../../ECON172_Spring2019_SectionMaterial/Section_02_IntroToR/colonials.dta")

## Since we are not using Stata in this class, let's remove what we just 
## loaded from memory and instead import a .csv file with the same data.
remove(colonials)
#colonials <- read.csv("colonials.csv")
colonials <- read.csv("../../ECON172_Spring2019_SectionMaterial/Section_02_IntroToR/colonials.csv")

## Let's take a look on the dataset.
View(colonials) ## view dataframe directly
colonials ## or print first 10 observations

## Let's take a look the variables in this dataset.
names(colonials) ## just print
colonials_variables <- names(colonials) ## store list, assigned "colonials_variables"
colonials_variables ## take a look at this list

## Let's look at some summary statistics.
## Here is the min, 25%-ile, median, mean, 75%-ile, and max for the variable gdppc
summary(colonials$gdppc) ## just print
colonials_sumstats <- summary(colonials$gdppc) ## store summary, "colonials_variables"
colonials_sumstats ## take a look at this summary

## Let's look specifically at mean GDP
mean(colonials$gdppc) ## just print
meangdp <- mean(colonials$gdppc) ## save as a variable, called "meangdp"
meangdp ## take a look at the value stored in of "meangdp"

## PART II: Regression

## Univariate regression of log gdp per capita on property rights index.
lm(logGDP ~ protection, data=colonials) # display regression results

## Multivariate, adding absolute latitude.
lm(logGDP ~ protection + lat_abst, data=colonials) # display regression results

## Multivariate regression, storing results
reg1 <- lm(logGDP ~ protection + lat_abst, data=colonials) # display regression results

## Now access regresion results by:
summary(reg1) # access complete regression results

## PART III: Plotting

## A very basic scatterplot (x=protection, y=logGDP)
plot(colonials$protection,colonials$logGDP)

## A scatterplot with titles
plot(colonials$protection,colonials$logGDP,
     xlab="protection against expropriation", ylab="Log (gdp per capita)")
abline(lm(logGDP ~ protection , data=colonials)) # line of best fit
## Remember that abline adds to the plot the regression line (linear fit line)

## Saving the plot
png(file="Plot1.png")
plot(colonials$protection,colonials$logGDP,
     xlab="protection against expropriation", ylab="Log (gdp per capita)")
abline(lm(logGDP ~ protection , data=colonials)) # line of best fit
dev.off()

## PART IV: Tables

## This package is great for making tables in .html, .tex and many other formats.
## install.packages("stargazer") ## only run once to install
library(stargazer)

## Default stargazer table
stargazer(reg1,out="Table 1.html",type="html")

## Stargazer table, customized
stargazer(reg1,out="Table 2.html",type="html",
          title="Table 2: Property rights and Development")
## Latex table
stargazer(reg1,out="Table 2.tex",
          title="Table 2: Property rights and Development",align=TRUE,
          omit.stat=c("LL","ser","f","adj.rsq"),no.space=TRUE)

## OPTIONAL: An interesting result: places that used to have a worst disease 
## environment in during colonization, are more likely to have less GDP today. 
## Optional reading of Acemoglu, Johnson and Robinson paper (2001) for more.
plot(colonials$logsettlermortality,colonials$logGDP)
