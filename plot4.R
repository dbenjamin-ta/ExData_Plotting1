library(dplyr)
library(lubridate)

#set working directory to your working directory
setwd("C:/Work/R-Course/EDA")

#read in file
data.file <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# read in date as date value
data.file<- mutate(data.file, Date = as.Date(Date,  "%d/%m/%Y" ))

# filter out all the non-relevant dates
data.file <- filter(data.file, Date >= "2007-02-01", Date <= "2007-02-02")

# Convert factors to numeric for all the relevant variables & Create a combined ate and time variable
data.file<-mutate(data.file, Global_active_power=as.numeric(as.character(Global_active_power)),
                  Global_reactive_power=as.numeric(as.character(Global_reactive_power)),
                  Sub_metering_1=as.numeric(as.character(Sub_metering_1)),
                  Sub_metering_2=as.numeric(as.character(Sub_metering_2)),
                  Sub_metering_3=as.numeric(as.character(Sub_metering_3)),
                  Voltage=as.numeric(as.character(Voltage))
                  )
data.file<-mutate(data.file, date_time=as.POSIXct(strptime(paste(Date,Time, sep=" " ),"%Y-%m-%d %H:%M:%S", tz="EST")))

#write plot1 to png device

png(file = "plot4.png")

par(mfrow=c(2,2))

#first plot
with(data.file,plot(date_time, Global_active_power, type="l",
                    ylab="Global Active Power (kilowatts)",xlab=""))

#second plot
plot(data.file$date_time,data.file$Voltage, type="l",xlab="datetime",ylab="Voltage")

#third plot

with(data.file,plot(date_time, Sub_metering_1, type="l", col="black",
                    ylab="Energy sub metering",xlab=""))
lines(data.file$date_time, data.file$Sub_metering_2, type="l", col="red")
lines(data.file$date_time, data.file$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), col = c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#fourth plot

plot(data.file$date_time,data.file$Global_reactive_power, type="l",xlab="datetime",ylab="Voltage")


dev.off()


