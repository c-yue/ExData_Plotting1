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










#learn from others

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp,"household_power_consumption.txt"), 
                    sep=";", 
                    header = T, 
                    na="?", 
                    colClasses = c("character",
                                   'character',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric'))

unlink(temp)
power <- power[which(power$Date == '2/2/2007' | power$Date=='1/2/2007'),]

power$POSIX <-as.POSIXlt.character(paste(power$Date,power$Time),format = "%d/%m/%Y %H:%M:%S")


#plot4
png(filename="plot4.png",width=480, height=480)
par(mfrow=c(2,2))
plot(x=power$POSIX ,y=power$Global_active_power, type = 'l', xlab='',ylab = 'Global Active Power')
plot(x=power$POSIX ,y=power$Voltage, type = 'l', xlab='datetime',ylab = 'Voltage')
plot(x=power$POSIX,y=power$Sub_metering_1, type='l', col = 'black', ylab = 'Energy sub metering', xlab = '')
lines(x=power$POSIX,y=power$Sub_metering_2, col='red')
lines(x=power$POSIX,y=power$Sub_metering_3, col='blue')
legend('topright', legend = c('Sub_metering_1',"Sub_metering_2","Sub_metering_3"), col = c('black','red','blue'), lty = 1, bty = "n")
plot(x=power$POSIX ,y=power$Global_reactive_power, type = 'l', xlab='datetime',ylab = 'Global_reactive_power')
dev.off()