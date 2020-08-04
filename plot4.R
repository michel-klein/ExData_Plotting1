##Read the .txt file
alldata <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

##Transform the dates
alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")

##Create the subset with the desired dates
initialdate <- unclass(as.Date("2007-02-01", "%Y-%m-%d"))
finaldate <- unclass(as.Date("2007-02-02", "%Y-%m-%d"))
subsetdate <- subset(alldata, unclass(alldata$Date) %in% initialdate:finaldate)
subsetdate <- subsetdate[complete.cases(subsetdate),]

##Transform the times and add to the subset
dateTime <- paste(subsetdate$Date, subsetdate$Time)
dateTime <- as.POSIXct(dateTime)
subsettimes <- cbind(dateTime, subsetdate)


##Creates plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(subsettimes$dateTime, subsettimes$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(subsettimes$dateTime, subsettimes$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(subsettimes$dateTime, subsettimes$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(subsettimes$dateTime, subsettimes$Sub_metering_2, col = "red")
lines(subsettimes$dateTime, subsettimes$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(subsettimes$dateTime, subsettimes$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

