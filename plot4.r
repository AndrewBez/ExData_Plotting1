#download and unzip the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
whole_set <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE, sep = ";",stringsAsFactors = FALSE)
unlink(temp)

#subset the dataset to keep given two days of data only 
two_days_set <- whole_set[whole_set$Date %in% c("1/2/2007","2/2/2007"),]

#prepare the data
timedata_raw <- paste(two_days_set$Date,two_days_set$Time)
timedata <- strptime(timedata_raw, format = "%d/%m/%Y %H:%M:%S")
two_days_set[,c(3:9)] <- as.numeric(unlist(two_days_set[,c(3:9)]))

#set global parameters
par(mfrow=c(2,2))

#draw the plots
plot(timedata,two_days_set$Global_active_power, type = "l",xlab="",ylab = "Global Active Power")
plot(timedata,two_days_set$Voltage, type = "l",xlab="datetime",ylab = "Voltage")
plot(timedata,two_days_set$Sub_metering_1,type = "l", col="black",xlab="",ylab = "Energy sub metering", ylim = c(0,30))
lines(timedata,two_days_set$Sub_metering_2, col="red")
lines(timedata,two_days_set$Sub_metering_3, col="blue")
legend("topright",lty = 1, col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = .6)
plot(timedata,two_days_set$Global_reactive_power, type = "l",xlab="datetime",ylab = "Global Reactive Power")

#output the plot to .png file
dev.copy(device=png,filename="plot4.png")
dev.off()
