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


##Creates plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(subsettimes$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
