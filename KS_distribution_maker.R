source("util.R")

pdf(NULL)

N <- 10
it <- 10000

ks_stat <- list(
rep(0,it),
rep(0,it),
rep(0,it)
)

names(ks_stat) <- c("Standard KS stat rgen N(0,1)","Modified KS stat rgen N(0,1)","Modified KS stat rgen N(10,3)")

ks_stat[[1]] <- ksTest_std(N,it,0,1)
ks_stat[[2]] <- ksTest_mod(N,it,0,1)
ks_stat[[3]] <- ksTest_mod(N,it,10,3)

tc <- sort(ks_stat[[1]])[it -5*it/100]
print(c("ks_std critical value at 0.05 significance:",tc))

xmax <- max(ks_stat[[1]])

h_ks_mod <- hist(ks_stat[[2]], breaks=seq(0,xmax+0.01,by=0.01))
h_ks_mod_test <- hist(ks_stat[[3]], breaks=seq(0,xmax+0.01,by=0.01))
h_ks_std <- hist(ks_stat[[1]], breaks=seq(0,xmax+0.01,by=0.01))

h_ks_mod$counts = h_ks_mod$counts/sum(h_ks_mod$counts)
h_ks_mod_test$counts = h_ks_mod_test$counts/sum(h_ks_mod_test$counts)
h_ks_std$counts = h_ks_std$counts/sum(h_ks_std$counts)

jpeg("KS_distributions.jpg")

plot(h_ks_mod_test,border="green",xlab="KS statistic",ylab="PDF",main="KS statistic distributions")
plot(h_ks_std,border="blue",add=TRUE)
plot(h_ks_mod,border="red",add=TRUE)

legend(0.5, 0.08, legend=c("KS mod N(0,1)", "KS mod N(10,3)","KS std"),
       col=c("red", "green", "blue"), lty=1:1, cex=0.8)

abline(v=tc,lty=2)

dev.off()


