# Hello people, this is my script. 

# With # you let R know that this is not part of the code and is just text.
# Any line of code without # in front, the computer will try to run. 
# Can be useful to insert and remove # in front of code when you are writing and testing your code

### Tell R the directory where we are going to work. Very important and makes your life easier.
setwd("~/ECON172_Spring2019_R/Section_02/")

### To open a stata database, we will need the library haven.
## install.packages("haven") ## just have to do this once, to install
library(haven)
colonials <- read_stata("/../../ECON172_Spring2019_SectionMaterial/Section_02_IntroToR/colonials.dta")

### Can also import .csv file directly
colonials_alt <- read.csv("/../../ECON172_Spring2019_SectionMaterial/Section_02_IntroToR/colonials.csv")
colonials_alt
remove(colonials_alt)
colonials_alt

### Let's take a look on the dataset.
View(colonials) ## one way to do it
colonials ## another way to do it

### Let's take a look the variables in this dataset.
names(colonials) ## just print
colonials_variables <- names(colonials) ## save list for further use
colonials_variables ## take a look at this list

## Summary statistics
meangdp <- mean(colonials$gdppc)
meangdp

summary(colonials$gdppc) #summary statistics
colonials_sumstats <- summary(colonials$gdppc)
colonials_sumstats

##Regression

#Univariate: Regressoin of log gdp per capita on property rights index.

lm(logGDP ~ protection, data=colonials) # display regression results

##Multivariate, lets add absolute latitude.
lm(logGDP ~ protection + lat_abst, data=colonials) # display regression results

#multivarate regression, storing results
reg1 <- lm(logGDP ~ protection + lat_abst, data=colonials) # display regression results

##Now access regresion results by:
summary(reg1) # access complete regression results

## A very basic scatter plot:

# A very basic scatterplot (x=protection, y=logGDP)
plot(colonials$protection,colonials$logGDP)

#A scatterplot with titles
plot(colonials$protection,colonials$logGDP,
     xlab="protection against expropriation", ylab="Log (gdp per capita)")
abline(lm(logGDP ~ protection , data=colonials)) # line of best fit
## Remember that abline adds to the plot the regression line (linear fit line)

## saving the plot
png(file="Plot1.png")
plot(colonials$protection,colonials$logGDP,
     xlab="protection against expropriation", ylab="Log (gdp per capita)")
abline(lm(logGDP ~ protection , data=colonials)) # line of best fit
dev.off()


###TABLES:

## This package is great for making tables in .html, .tex and many other formats.
## install.packages("stargazer") ## only run once to install
library(stargazer)

#We could then run following code:

#Default stargazer table
stargazer(reg1,out="Table 1.html",type="html")

#Stargazer table, customized
stargazer(reg1,out="Table 2.html",type="html",
          title="Table 2: Property rights and Development")
#latex table
stargazer(reg1,out="Table 2.tex",
          title="Table 2: Property rights and Development",align=TRUE,
          omit.stat=c("LL","ser","f","adj.rsq"),no.space=TRUE)

###OPTIONAL: An interesting result: places that used to have a worst disease environment in during colonization, are more likely to have less GDP today. Optional reading of Acemoglu, Johnson and Robinson paper (2001) for more.
plot(colonials$logsettlermortality,colonials$logGDP)