source("util.R")

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


obs <- c(6.55,4.39,3.80,3.53,5.84,3.51,3.76,3.61,3.91,4.23)
xm <- mean(obs)
xs <- sd(obs)
ks_obs <- ks.test(obs,"pnorm",xm,xs)$statistic

print(c("observed statistic:", ks_obs))
print(c("ks_std p-value at ks_obs:", p_value(x_std,y_std,ks_obs)))
print(c("ks_mod p-value at ks_obs:", p_value(x_mod,y_mod,ks_obs)))