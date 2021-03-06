This code was developed in order to pass the final exam on the subject
"Statistical Methods for Experimental Physics" within the PhD programme, dictated at Universidad de Buenos Aires in the first semester of 2017.



General statement:

Given n=10 measurements of a certain magnitude, determine if the process of measurement is consistent with Gaussian errors with unknown mu and sigma parameters.



General remarks:



- mu and sigma can be estimated as:

![](https://latex.codecogs.com/gif.latex?%5Cmu_%7Best%7D%20%3D%20%5Cfrac%7B1%7D%7B10%7D%5Csum_%7Bi%7D%7Bx_%7Bi%7D%7D)

![](https://latex.codecogs.com/gif.latex?%5Csigma_%7Best%7D%5E%7B2%7D%20%3D%20%5Cfrac%7B1%7D%7B9%7D%5Csum_%7Bi%7D%28x_%7Bi%7D-%5Cmu_%7Best%7D%29%5E2)


- The chi-squared test is not possible to apply since the statistics is not enough for the Poisson -> Gauss approximation 

- The Kolmogorov-Smirnov test (KS-test), which is valid for a low statistical sample, is not possible since the hypothesis depends on the data (mu and sigma are estimated)

- The proposed solution consists in measuring a Tk' statistic for a "modified" KS-test (instead of using the theoretical distribution which is only valid when the hypothesis doesn't depend on the data). 



Problem statements:


1) Generate computationally the Tk' distribution. Make a normalized histogram of Tk' and plot it. Also, get the critical value c : Tk' > c for a significance of alpha = 0.05.

This problem was addressed in this code:
KS_distribution_maker.R


2) Generate random numbers from a N(0,1) and compute the p-values p and p' from the "standard" and the "modified" KS-test.

This problem was addressed in this code:
pvalue_distribution_maker.R


3) Given the following data: 6.55 4.39 3.80 3.53 5.84 3.51 3.76 3.61 3.91 4.23
Compute the p-value using the standard and the modified KS-test. What can you say about the data gaussianity?

This problem was addressed in this code:
pvalue_observable_computing.R


4) Now suppose that the data comes from a t-Student distribution with 15 degrees of freedom. Study the discrimination power of the test as a function of the size of the sample n.

This problem was addressed in this code:
KS_test_power.R
