---
layout: post
title: "Homework 2 for Data Analysis."
date:   2019-03-23 23:59:59
categories: Moments
---

# The Bootstrap Estimate for Standard Error

Author: Zihan Zhang

----
## Abstract

Bootstrap is a simple method used to estimate the standard error of an unknown population with only a sample. In this note, I would like to write an brief introduction about the Bootstrap as well as its realization with some other softwares except for R.

----
### Nonparametric Bootstrap
Bootstrap, firstly introduced in 1979, provides a relatively simple way to calculate the standard error of the estimator just based on the sample we known. Actually, Bootstrap that we have discussed in class is the non-parametric one, which means it does not be involved in any theoretical derivations. It enjoys the advantages of being being able to finish the whole process by  computers themselves. 
Bootstrap, firstly introduced in 1979, provides a relatively simple way to calculate the standard error of the estimator just based on the sample we known. Actually, Bootstrap that we have discussed in class is the non-parametric one, which means it does not be involved in any theoretical derivations. It enjoys the advantages of being being able to finish the whole process by  computers themselves. 

Suppose we have an underlying population $$F$$ with a coefficient $$\theta$$ describing its feature and both of them are unknown. Also, we have a sample $$\mathbf{x} = (x_1,x_2,...,x_n)$$ comprising some individuals ($$x_i$$) generated from $$F$$. In statistics, we are able to estimate $$\theta$$ with the estimator $$\hat{\theta}=s(\mathbf{x})$$ through some derivations. The Bootstrap was introduced to measure the accuracy of $$\hat{\theta}$$.

From the known sample, we are able to generate the Bootstrap sample, which is defined to be a random sample of size n with replacement from the known sample $$\mathbf{x}$$. It could be donated as $$\mathbf{x}^*=(x_1^*,x_2^*,...,x_n^*)$$, where the star notation manifest the $$\mathbf{x^*}$$ is not the actual set of $$\mathbf{x}$$, but rather a randomized and replaced version of initial sample $$\mathbf{x}$$.

Next, we would like to evaluate the Bootstrap replication corresponding to each Bootstrap sample and calculate the $$\hat{\theta(i)}=s(\mathbf{x}^{*i})$$ for each Bootstrap sample. Having those done, we are able to estimate the stand error by the sample standard deviation of N replications. The equation is as follows.

$$
\begin{align}
\widehat{SE_N}= \sqrt{\frac{\sum_{i=1}^N  [\widehat{\theta^*(i)}-\widehat{ \theta^*(\bullet)})]^2}{N-1}}
\end{align}
$$

where $$\theta^*(\bullet)=\frac{1}{N} \sum_{i=1}^N \theta^*(i)$$. 
----
