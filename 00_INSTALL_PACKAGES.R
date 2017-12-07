#Following 2 URL required for devtools package to run
#Install R tools for Windows from https://cran.r-project.org/bin/windows/Rtools/Rtools33.exe
#Install latest version of R 3.4.3 from https://cran.r-project.org/bin/windows/base/R-3.4.3-win.exe and uninstall the old version 

#Note: Some packages may not run if compatibility issues exist. This depends on R software configuration.

# Installing Twitter R package
install.packages("twitteR")
install.packages("curl")
install.packages("base64inc")
install.packages("RCurl")
install.packages("openssl")
devtools::install_github("jrowen/twitteR", ref = "oauth_httr_1_0")
install.packages("NLP")
install.packages("openNLP") 
install.packages("openNLPdata")
install.packages("qdap")
install.packages("loadNamespace")
install.packages("lazyeval")
install.packages("tagPOS")
install.packages("stringr")  
install.packages("rtimes")
install.packages("devtools")
devtools::install_github("ropengov/rtimes") 
install.packages("ROAuth")
install.packages("reshape2")
install.packages("plyr")
install.packages("stringr")
install.packages("plotrix")
install.packages("RWeka") 
install.packages("qdap")
install.packages("rJava")
install.packages("tm")
install.packages("slam")
install.packages("gridExtra")
install.packages("grid")
install_version("tm", version = "0.7-2")
install.packages("slam", version = "0.1.37")
install.packages("openNLPmodels.en",
                 repos = "http://datacube.wu.ac.at/",
                 type = "source")
install.packages("forecast",
                 repos = c("http://rstudio.org/_packages",
                           "http://cran.rstudio.com"))


library('twitteR')
library('curl')
library("base64inc")
library("RCurl")
library("openssl")
library(rJava)
library(tm)
library(NLP)
library(openNLP)
library(magrittr)
library(qdap)
require("NLP")        
library(stringr)
library("rtimes")
library(ROAuth)
library(twitteR)
library(reshape2)
library(plyr)
library(stringr)
library(plotrix)
library(gridExtra)
library(grid)
