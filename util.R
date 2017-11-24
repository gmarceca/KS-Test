ksTest_mod <-function(n,it,mu,sigma)
{
	ks <- rep(0,it)
	for(k in 1:it) {
		x <- rnorm(n,mu,sigma)
		mean <- mean(x)
	    sd <- sd(x)
	    ks[k] <- ks.test(x,"pnorm",mean,sd)$statistic
	}	
 	return(ks)
}

ksTest_std <-function(n,it,mu,sigma)
{
	ks <- rep(0,it)
	for(k in 1:it) {
		x <- rnorm(n,mu,sigma)
	    ks[k] <- ks.test(x,"pnorm")$statistic
	}	
 	return(ks)
}

ksTest_rt <-function(n,it,dof)
{
	ks <- rep(0,it)
	for(k in 1:it) {
		x <- rt(n,dof)
		mu <- mean(x)
	    sd <- sd(x)
	    ks[k] <- ks.test(x,"pnorm",mu,sd)$statistic
	}	
 	return(ks)
}

ecdf <-function(v)
{
	x <- sort(v)
	steps <- 1/length(v)
	y <- seq(0,1,by=steps)
	x[length(x)+1] <- 1

	l <- list(
	x,
	y)
	return(l)
}

p_value <- function(x,y,v)
{
	interp_func <- approxfun(x,y)
	1-interp_func(v)
}

tc <- function(x,y,v)
{
1 - p_value(y,x,1-v)
}