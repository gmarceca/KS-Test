source("util.R")

pdf(NULL)

N <- 10
it <- 10000

ks_stat <- list(
rep(0,it),
rep(0,it)
)

names(ks_stat) <- c("Standard KS stat","Modified KS stat")

ks_stat[[1]] <- ksTest_std(N,it,0,1)
ks_stat[[2]] <- ksTest_mod(N,it,0,1)

tc_std <- sort(ks_stat[[1]])[it -5*it/100]
print(c("ks_std critical value at 0.05 significance:",tc_std))

tc_mod <- sort(ks_stat[[2]])[it -5*it/100]
print(c("ks_mod critical value at 0.05 significance:",tc_mod))

xmax <- max(ks_stat[[1]])

h_ks_mod <- hist(ks_stat[[2]], breaks=seq(0,xmax+0.01,by=0.01))
h_ks_std <- hist(ks_stat[[1]], breaks=seq(0,xmax+0.01,by=0.01))

h_ks_mod$counts = h_ks_mod$counts/sum(h_ks_mod$counts)
h_ks_std$counts = h_ks_std$counts/sum(h_ks_std$counts)

x_std <- ecdf(ks_stat[[1]])[[1]]
y_std <- ecdf(ks_stat[[1]])[[2]]

x_mod <- ecdf(ks_stat[[2]])[[1]]
y_mod <- ecdf(ks_stat[[2]])[[2]]

eval <- ks_stat[[1]]

h_pval <- hist(p_value(x_std,y_std,eval))
h_pval$counts = h_pval$counts/sum(h_pval$counts*0.1)


jpeg("pvalue_distribution.jpg")

plot(h_pval,border="red")

dev.off()


