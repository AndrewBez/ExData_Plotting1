#download and unzip the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
whole_set <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE, sep = ";",stringsAsFactors = FALSE)
unlink(temp)

#subset the dataset to keep given two days of data only 
two_days_set <- whole_set[whole_set$Date %in% c("2/1/2007","2/2/2007"),]

#prepare the data
timedata_raw <- paste(two_days_set$Date,two_days_set$Time)
timedata <- strptime(timedata_raw, format = "%m/%d/%Y %H:%M:%S")
two_days_set[,c(7:9)] <- as.numeric(unlist(two_days_set[,c(7:9)]))

#plot the graphs and add the legend
plot(timedata,two_days_set$Sub_metering_1,type = "l", col="black",xlab="",ylab = "Energy sub metering", ylim = c(0,30))
lines(timedata,two_days_set$Sub_metering_2, col="red")
lines(timedata,two_days_set$Sub_metering_3, col="blue")
legend("topright",lty = 1, col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#output the plot to .png file
dev.copy(device=png,filename="plot3.png")
dev.off()
