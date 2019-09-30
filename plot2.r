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
two_days_set$Global_active_power <- as.numeric(two_days_set$Global_active_power)

#plot the graph
plot(timedata,two_days_set$Global_active_power, type = "l",xlab="",ylab = "Global Active Power(kilowatts)")

#output the plot to .png file
dev.copy(device=png,filename="plot2.png")
dev.off()
