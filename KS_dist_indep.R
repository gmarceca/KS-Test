pdf(NULL)

vec_ks_norm <- rep(0,1000)
vec_ks_unif <- rep(0,1000)

M_norm <-matrix(rnorm(10000),nrow=10)
M_unif <-matrix(runif(10000),nrow=10)

for(i in 1:1000) vec_ks_norm[i] <- ks.test(M_norm[,i],"pnorm")$statistic
for(i in 1:1000) vec_ks_unif[i] <- ks.test(M_unif[,i],"punif")$statistic

h_norm <- hist(vec_ks_norm, breaks=seq(0,0.7,by=0.01))
h_unif <- hist(vec_ks_unif, breaks=seq(0,0.7,by=0.01))

jpeg("myplot.jpg")

plot(h_norm,border="red")
plot(h_unif,border="blue",add=TRUE)

dev.off()
