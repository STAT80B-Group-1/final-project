# data set of homelessness ct in CA
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

fac <- factor(unsheltered_data$unsheltered_homeless_2008)
fac2 <- factor(unsheltered_data$county)

f1<-as.numeric(fac)
f2<-as.numeric(fac2)

plot(f2, f1, main = "Total unsheltered homeless in 2008 by California County", xlab = "Total unsheltered homeless, 2008", ylab = "county", col = as.numeric(fac2))