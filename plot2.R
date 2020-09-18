library(dplyr)
library(sqldf)

dt <- read.table('household_power_consumption.txt', header = TRUE, sep = ';')
dt <- tbl_df(dt)

dt <- sqldf("select * from dt where Date = '1/2/2007' or Date = '2/2/2007'")

dt$Date <- as.Date(dt$Date, '%d/%m/%Y') 

dt$Time <- paste(dt$Date, dt$Time)
dt$Time <- strptime(dt$Time, '%Y-%m-%d %H:%M:%S')

dt$Global_active_power <- as.numeric(dt$Global_active_power)


#plot2
plot(dt$Time, dt$Global_active_power/500, type = 'l', 
     xlab = '', ylab = 'Grobal Active Power (kilowatts)')