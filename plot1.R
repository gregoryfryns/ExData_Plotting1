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

# Plot graph 1
png(filename="plot1.png")
hist(pconsum$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()