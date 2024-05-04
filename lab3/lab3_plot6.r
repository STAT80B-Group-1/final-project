# data set of homelessness ct in CA
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

fac <- factor(unsheltered_data$Total.Homeless..2007)
fac2 <- factor(unsheltered_data$county)

f1<-as.numeric(fac)
f2<-as.numeric(fac2)

plot(f1, f2, main = "Total homeless in 2007 by California County", xlab = "County", ylab = "Total homeless, 2007")