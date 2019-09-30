#download and unzip the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
whole_set <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE, sep = ";",stringsAsFactors = FALSE)
unlink(temp)

#subset the dataset to keep given two days of data only 
two_days_set <- whole_set[whole_set$Date %in% c("1/2/2007","2/2/2007"),]

#prepare the vector to plot
data_to_plot <- as.numeric(two_days_set$Global_active_power[!two_days_set$Global_active_power=="?"])

#plot the histogram
hist(data_to_plot, col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

#output the plot to .png file
dev.copy(device=png,filename="plot1.png")
dev.off()
