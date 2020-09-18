library(dplyr)
library(sqldf)

dt <- read.table('household_power_consumption.txt', header = TRUE, sep = ';')
dt <- tbl_df(dt)

dt <- sqldf("select * from dt where Date = '1/2/2007' or Date = '2/2/2007'")

dt$Date <- as.Date(dt$Date, '%d/%m/%Y') 

dt$Time <- paste(dt$Date, dt$Time)
dt$Time <- strptime(dt$Time, '%Y-%m-%d %H:%M:%S')

dt$Global_active_power <- as.numeric(dt$Global_active_power)



#plot1
hist(dt$Global_active_power/500, freq = TRUE, main = 'Global Active Power'
     ,xlab = 'Global Active Power (kilowatts)'
     ,col = 'red')


#plot2
plot(dt$Time, dt$Global_active_power/500, type = 'l', 
     xlab = '', ylab = 'Grobal Active Power (kilowatts)')


#plot3

plot(dt$Time, dt$Sub_metering_1, type = 'l', 
     xlab = '', ylab = 'Energy sub metering')
lines(dt$Time, dt$Sub_metering_2,col = 'red')
lines(dt$Time, dt$Sub_metering_3,col = 'blue')

legend("topright", inset=.05
       ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1, col=c("black","red", "blue")
       ,cex = 0.5, text.font = 0)



#plot4

par(mfrow=c(2,2))


plot(dt$Time, dt$Global_active_power/500, type = 'l', cex.axis = 0.8,cex.lab = 0.8,
     xlab = '', ylab = 'Grobal Active Power')


plot(dt$Time, dt$Voltage, type = 'l', 
     xlab = 'datetime', cex.axis = 0.8,cex.lab = 0.8,
     ylab = 'Voltage')


plot(dt$Time, dt$Sub_metering_1, type = 'l', 
     xlab = '', ylab = 'Energy sub metering', cex.axis = 0.8,cex.lab = 0.8)
lines(dt$Time, dt$Sub_metering_2,col = 'red')
lines(dt$Time, dt$Sub_metering_3,col = 'blue')

legend("topright", inset=.05
       ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1, col=c("black","red", "blue")
       ,cex = 0.5, text.font = 0)


plot(dt$Time, dt$Global_reactive_power, type = 'l', cex.axis = 0.8,cex.lab = 0.8,
     xlab = '', ylab = 'Grobal reactive power')



