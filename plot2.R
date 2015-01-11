

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

# graph #2
png("plot2.png")
with(df, plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = ""))
with(df, lines(DateTime, Global_active_power))
title(ylab = "Global Active Power (kilowatts)")
dev.off()
