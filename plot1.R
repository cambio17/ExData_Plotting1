

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

# plot the graph #1
png("plot1.png")
hist(df$Global_active_power, col = "red", main = "", xlab = "")
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()