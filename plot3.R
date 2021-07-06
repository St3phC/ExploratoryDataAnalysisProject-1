library("data.table")
#Read data then subset for specified date(s)
hhpower <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
hhpower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
# POSIXct date filtered/graphed by time of day
hhpower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# filtered dates 2007-02-01 & 2007-02-02
hhpower <- hhpower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
png("plot3.png", width=480, height=480)
##plot 3
plot(hhpower[,dateTime], hhpower[,Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(hhpower[,dateTime], hhpower[,Sub_metering_2], col="red")
lines(hhpower[,dateTime], hhpower[,Sub_metering_3], col="blue")
legend("top right"
       , col = c("black", "red", "blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()