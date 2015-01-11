# If necessary, get the data file from internet

if (!file.exists("./household_power_consumption.txt")) {
    if (!file.exists("./HHPowerConsumption.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,"./HHPowerConsumption.zip",mode="wb")
    }
    
    unzip("./HHPowerConsumption.zip")
}

# Load data in R (only for 2007-02-01 & 2007-02-02)
pconsum <- read.table("./household_power_consumption.txt",
                      header=FALSE,
                      sep=";",
                      na.strings="?",
                      skip=66637,
                      nrows=2880)

headers <- read.table("./household_power_consumption.txt",
                      header=TRUE,
                      sep=";",
                      nrows=1)
colnames(pconsum) <- colnames(headers)

# Merge date and time columns
Sys.setlocale(category = "LC_TIME", locale = "C")
pconsum <- cbind(DateTime=as.POSIXct(paste(pconsum$Date, pconsum$Time),
                                     format="%d/%m/%Y %H:%M:%S",tz="UTC"),pconsum)
pconsum <- pconsum[-2,-3]

# Plot graph 3
png(filename="plot3.png")
yrange <- range(c(pconsum$Sub_metering_1,
                  pconsum$Sub_metering_2,
                  pconsum$Sub_metering_3))
with(pconsum, plot(DateTime,
                   Sub_metering_1,
                   type="l",
                   xlab="",
                   ylab="Energy sub metering"),
     ylim=yrange)
par(new="T")
with(pconsum, plot(DateTime,
                   Sub_metering_2,
                   type="l",
                   col="red",
                   xlab="",
                   ylab="",
                   ylim=yrange))
par(new="T")
with(pconsum, plot(DateTime,
                   Sub_metering_3,
                   type="l",
                   col="blue",
                   xlab="",
                   ylab="",
                   ylim=yrange))
legend("topright",
       col=c("black","red","blue"),
       lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()