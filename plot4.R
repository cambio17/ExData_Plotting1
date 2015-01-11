
# It is required that the "household_power_consumption.txt" file
# is present in the working directory

# read the dataset
df <- read.csv("household_power_consumption.txt",
               sep = ";",
               stringsAsFactors = F,
               na.strings = "?")

# subset the dataset by extraction the data for two days only
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]

# transform the Date and Time variables into one variable of the type "POSIXt"
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
df$Date <- df$Time <- NULL

#convert the other variables from character to numeric
for (i in 1:6) {
    df[,i] <- as.numeric(df[,i])
}

# plot the graph #4
png("plot4.png")
par(mfrow=c(2,2))
with(df, {
    
    # graph #4.1
    plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "")
    lines(DateTime, Global_active_power)
    title(ylab = "Global Active Power")

    # graph #4.2
    plot(DateTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
    lines(DateTime, Voltage)
    
    # graph #4.3
    with(df, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = ""))
    with(df, lines(DateTime, Sub_metering_1))
    with(df, lines(DateTime, Sub_metering_2, col = "red"))
    with(df, lines(DateTime, Sub_metering_3, col = "blue"))
    legend("topright",
           bty = "n",
           cex = 0.9,
           lty = c(1,1,1),
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    title(ylab = "Energy sub metering")
    
    # graph #4.4
    plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime")
    lines(DateTime, Global_reactive_power)

})
dev.off()
