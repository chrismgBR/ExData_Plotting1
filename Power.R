############################################
### Assignment: Exploratory Data Analysis ##
############################################


### Loading the data

library(data.table)

setwd("E:/Desktop/Data Science -  Foundations using R/4-Exploratory Data Analysis/week1/Assignment")


df <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
str(df)
dim(df)
head(df)

table(is.na(df))

df <- df[complete.cases(df),] # do not consider NA values

# Formatting
for (i in 3:9) {
  df[,i] <- as.numeric(df[,i])
}


datetime <- paste(df$Date, df$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
df$datetime <- datetime
str(df)

df$Date <- as.Date(df$Date, "%d/%m/%Y")

dfsub <- df[df$Date >= "2007-02-01" & df$Date <=  "2007-02-02",]


# Making Plots

par(mfrow=c(1,1))

#### Plot 1 ####

hist(dfsub$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.copy(png, filename="Plot1.png")
dev.off()

#### Plot 2 ####

# change weekdays to English
Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_US")



plot(dfsub$datetime, dfsub$Global_active_power,
     type="l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.copy(png, filename="Plot2.png")
dev.off()

#### Plot 3 ####

plot(dfsub$datetime, dfsub$Sub_metering_1, type = "l", xlab="", ylab="")
lines(dfsub$datetime, dfsub$Sub_metering_2, col = "red")
lines(dfsub$datetime, dfsub$Sub_metering_3, col = "blue")
title(xlab="", ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty=1, lwd = 2)
dev.copy(png, filename="Plot3.png")
dev.off()

#### Plot 4 ####

par(mfcol=c(2,2)) # Create a 2 x 2 plotting matrix
par(mar = c(4, 4, 3, 3))

# Plot 4-1

plot(dfsub$datetime, dfsub$Global_active_power,
     type="l", xlab="", ylab = "Global Active Power")


# Plot 4-2

plot(dfsub$datetime, dfsub$Sub_metering_1, type = "l", xlab="", ylab="")
lines(dfsub$datetime, dfsub$Sub_metering_2, col = "red")
lines(dfsub$datetime, dfsub$Sub_metering_3, col = "blue")
title(xlab="", ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty=1, lwd = 2)


# Plot 4-3

plot(dfsub$datetime, dfsub$Voltage,
     type="l", xlab="datetime", ylab = "Voltage")


# Plot 4-4

plot(dfsub$datetime, dfsub$Global_reactive_power,
     type="l", xlab="datetime", ylab = "Global Reactive Power")

dev.copy(png, filename="Plot4.png")
dev.off()

