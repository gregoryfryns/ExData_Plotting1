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

# Plot graph 2

png(filename="plot2.png")
with(pconsum,plot(DateTime,
                  Global_active_power,
                  type="l",
                  xlab="",
                  ylab="Global Active Power (kilowatts)"))
dev.off()