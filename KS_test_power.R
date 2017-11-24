source("util.R")

pdf(NULL)

N <- c(10,100,1000,10000)
it <- 10000

ks_mod <- list(
rep(0,it),
rep(0,it),
rep(0,it),
rep(0,it)
)

ks_t <- list(
rep(0,it),
rep(0,it),
rep(0,it),
rep(0,it)
)


for(i in 1:length(N)) {

	ks_mod[[i]] <- ksTest_mod(N[i],it,0,1)
	
	ks_t[[i]] <- ksTest_rt(N[i],it,15)
	
	}

xmax1 <- max(ks_mod[[1]])
xmax2 <- max(ks_mod[[2]])
xmax3 <- max(ks_mod[[3]])
xmax4 <- max(ks_mod[[4]])

xmax1_t <- max(ks_t[[1]])
xmax2_t <- max(ks_t[[2]])
xmax3_t <- max(ks_t[[3]])
xmax4_t <- max(ks_t[[4]])

print(xmax4)

h_list <- list(
hist(ks_mod[[1]], breaks=seq(0,xmax1+0.005,by=0.005)),
hist(ks_mod[[2]], breaks=seq(0,xmax2+0.001,by=0.001)),
hist(ks_mod[[3]], breaks=seq(0,xmax3+0.001,by=0.001)),
hist(ks_mod[[4]], breaks=seq(0,xmax4+0.001,by=0.001))
)

ht_list <- list(
hist(ks_t[[1]], breaks=seq(0,xmax1_t+0.005,by=0.005)),
hist(ks_t[[2]], breaks=seq(0,xmax2_t+0.001,by=0.001)),
hist(ks_t[[3]], breaks=seq(0,xmax3_t+0.001,by=0.001)),
hist(ks_t[[4]], breaks=seq(0,xmax4_t+0.001,by=0.001))
)


for(i in 1:length(N)) {
	h_list[[i]]$counts = h_list[[i]]$counts/sum(h_list[[i]]$counts*0.01)
	ht_list[[i]]$counts = ht_list[[i]]$counts/sum(ht_list[[i]]$counts*0.01)
	}

x_H0 <- ecdf(ks_mod[[1]])[[1]]
y_H0 <- ecdf(ks_mod[[1]])[[2]]

x_H1 <- ecdf(ks_t[[1]])[[1]]
y_H1 <- ecdf(ks_t[[1]])[[2]]


print(c("The tc for alpha=0.05 is:", tc(x_H0,y_H0,0.05),"And the power:",p_value(x_H1,y_H1,tc(x_H0,y_H0,0.05))))


p <- seq(0,1,0.001)
x <- rep(0,length(p))
y <- rep(0,length(p))

for (i in 1:length(p)) {
	
	y[i] <- p_value(x_H1,y_H1,tc(x_H0,y_H0,p[i]))
	x[i] <- p[i]
	
	}

jpeg("KS_power_vs_alpha.jpg")

plot(x,y,xlab="significance",ylab="power",col="blue")

jpeg("KS_dist_ndep.jpg")

plot(h_list[[4]],border="red",xlim=c(0,0.5))
plot(h_list[[2]],border="orange",xlim=c(0,0.5),add=TRUE)
plot(h_list[[3]],border="green",xlim=c(0,0.5),add=TRUE)
plot(h_list[[1]],border="blue",xlim=c(0,0.5),add=TRUE)

jpeg("KS_power.jpg")

plot(ht_list[[3]],border="orange",xlim=c(0,0.1))
plot(h_list[[3]],border="blue",xlim=c(0,0.1),add=TRUE)

dev.off()