# plotting two images representing "in GRB" and "out of GRB" schemas
setwd("~/Documents/snpsInGrbs/individualGwas/scz/shinyApps/image/")


#GRBout
png("GRBout.png", width=500, height=250)
image(x=as.matrix(0:1), y=as.matrix(0:1), col=c("red3", "white"),
      xlab="", ylab="", axes=FALSE)
for (i in 0:2) { 
  abline(h=i,col="black") 
}
for (i in 0:2) { 
  abline(v=i-0.5,col="black") 
} 
axis(3, at=0.5, labels="Locus not in GRB", tick=FALSE, font=2, cex.axis=1.5) 
dev.off()

#GRBin
png("GRBin.png", width=500, height=250)
image(x=as.matrix(0:1), y=as.matrix(0:1), z=as.matrix(0:1), col=c("white", "forestgreen"),
      xlab="", ylab="", axes=FALSE)
for (i in 0:2) { 
  abline(h=i,col="black") 
}
for (i in 0:2) { 
  abline(v=i-0.5,col="black") 
} 
axis(3, at=0.5, labels="Locus in GRB", tick=FALSE, font=2, cex.axis=1.5) 
dev.off()
