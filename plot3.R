

# read the dataset
df <- read.csv("household_power_consumption.txt",
               sep = ";",
               stringsAsFactors = F,
               na.strings = "?")

# subset the dataset by extraction data for two days only
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]

# transform the Date and Time variables into one variable of the type "POSIXt"
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
df$Date <- df$Time <- NULL

#convert the other variables from character to numeric
for (i in 1:6) {
    df[,i] <- as.numeric(df[,i])
}

# graph #3
png("plot3.png")
with(df, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = ""))
with(df, lines(DateTime, Sub_metering_1))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
title(ylab = "Energy sub metering")
dev.off()
