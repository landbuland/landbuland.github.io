---
layout: post
title: "Random Utility Framework and Generalized Linear Models"
date:   2019-11-27 23:59:59
categories: Data_Analysis
---

# A Note on Random Utility Framework and Generalized Linear Models

## 1. Random Utility Framework, Logit and Probit

Suppose "i" individuals face to "J" choices

The Utility for individual i with choice j is $$U_{ij}$$

The choice if individual "i" is $$y_i:\arg \max_{j}\{U_{ij}\}$$

Characteristics: $$x_{ij}$$ 
$$
U_{ij}=f_j(x_{ij})+e_{ij}
$$

where,

$$
x_i = s_i +z_{ij}
\\
 e_i \sim^{i . i . d} \mathcal{F}_{e}(.)
$$

不同的$$f(x_{ij})$$ 和 $$e_{ij}$$ 设计可以推出不同的discrete choice model。

怎么推的？$$\rightarrow$$ Conditional choice probability


$$
\begin{aligned} \operatorname{Pr}\left(y_{i}=j | x_{i}\right) &=\operatorname{Pr}\left(U_{i j}>U_{i \ell} \ \ \forall \ell \neq j | x_{i}\right) \\ &=\operatorname{Pr}\left(f_{j}\left(x_{i}\right)+e_{i j}>f_{\ell}\left(x_{i}\right)+e_{i \ell} \forall \ell \neq j | x_{i}\right) \\ &=\int \mathcal{I}\left(e_{i \ell}-e_{i j}<f_{j}\left(x_{i}\right)-f_{\ell}\left(x_{i}\right) \forall \ell \neq j\right) d \mathcal{F}_{e}\left(e_{i}\right) \end{aligned}
$$


In `Probit model`, $$e_i$$ are no longer allowed to be i.i.d.

For binary  discrete choice problems, $$
y \in\{A, B\}$$




$$
\begin{array}{l}{U_{i A}=x_{i A}^{\prime} \beta_{A}+e_{i A}} \\ {U_{i B}=x_{i B}^{\prime} \beta_{B}+e_{i B}}\end{array}
$$


对 $$e_i$$ 有如下设定 


$$
e_{i}=\left[\begin{array}{c}{e_{i A}} \\ {e_{i B}}\end{array}\right] \sim \mathcal{N}\left(0,\left[\begin{array}{cc}{\sigma_{A}^{2}} & {\sigma_{A B}} \\ {\cdot} & {\sigma_{B}^{2}}\end{array}\right]\right)
$$


In `multinomial logit model`, we assume that  


$$
\begin{array}{c}{U_{i j}=x_{i j}^{\prime} \beta_{j}+e_{i j}} \\ {e_{i j} \sim^{i . i . d .} \text { Gumbel }(0, \sigma)}\end{array}
$$


怎么从Gumbel distribution 推出 Multinomial Logistic Model？$$\downarrow$$

## 2. Extreme Value Distribution and Logit model

Gumbel Distribution = Extreme Value Distribution.

它对 $$e$$ 的分布有如下的 Cumulative Distribution Function:
$$
\mathcal{F}(e ; \mu, \sigma)=\exp \left\{-\exp \left(-\frac{e-\mu}{\sigma}\right)\right\}
$$
$$ \mu$$ : Location parameter (Like mean in Gaussian)

$$\sigma$$ : scale parameter (Like Standard error in Gaussian)

For $$ e \sim \text { Gumbel }(\mu, \sigma) $$
$$
\begin{aligned} E(e) &=\mu+\sigma \gamma_{e} \\ \operatorname{Var}(e) &=\frac{\pi^{2}}{6} \sigma^{2} \end{aligned}
$$
where $$\gamma_e \approx 0.577 $$ is the Euler constant. (Proof...)



Normal (0,1) V.S. Gumbel (0,1)

![NVSG](https://tva1.sinaimg.cn/large/006y8mN6ly1g9ce612x9ej30kr08raei.jpg)



Let $$
e_{1}, e_{2} \sim \text { Gumbel }(0,\sigma)
$$ , and $$\Delta e=e_{2}-e_{1}$$

The CDF of $$\Delta e$$ is :



$$
\mathcal{F}(\Delta e)=\frac{\exp (\Delta e)}{1+\exp (\Delta e)}
$$


(Proof...) 



这个式子的意义在于，假设e属于Gumbel 分布和其属于正态分布的差别不大。

对`Logistic model:`


$$
\begin{array}{c}{U_{i j}=x_{i j}^{\prime} \beta_{j}+e_{i j}} \\ {e_{i j} \sim^{i . i . d .} \text { Gumbel }(0, \sigma)}\end{array}
$$


Normalize $$e$$ for identification


$$
e_{i j} \sim^{i . i . d .} \text { Gumbel }(0,1)
$$


Let $$x_{i}=\left\{x_{i j}\right\}_{j=1}^{J} \text { and } V_{i j}=x_{i j}^{\prime} \beta_{j}$$


$$
\begin{aligned} \operatorname{Pr}\left(y_{i}=j | x_{i}\right) &=\operatorname{Pr}\left(V_{i j}+e_{i j}>V_{i \ell}+e_{i \ell} \forall \ell \neq j | x_{i}\right) \\ &=\operatorname{Pr}\left(e_{i \ell}<V_{i j}-V_{i \ell}+e_{i j} \forall \ell \neq j | x_{i}\right) \\ &=\int\left[\prod_{\ell \neq j} e^{-\left(v_{i j}-V_{i \ell}+e_{j}\right)}\right] e^{-e_{i j}} e^{-e^{-e_{i j}}} d e_{i j} \\ &=\frac{\exp \left(V_{i j}\right)}{\sum_{\ell=1}^{J} \exp \left(V_{i \ell}\right)} \end{aligned}
$$


## 3. Poisson Regression

Let' s start from poisson distribution.

A poisson distribution has its probability mass function:


$$
Pr(Y=k)=\frac{e^{-\lambda} \lambda^{k}}{k\ !}
$$


where $$Y$$ follows the poisson distribution and $$\lambda$$ is the parameter in poisson distribution, which has the interpretation of the average number of events per interval. 



This equation can be adapted if, instead of the average number of events $$\lambda$$,  we are given a time rate $$r$$ for the events to happen. Then $$\lambda = rt$$ (with r in units of 1/time), and


$$
Pr(Y=k)
=\frac{(r t)^{k} e^{-r t}}{k !}
$$


The poisson distribution has the same expectation and variance that is the value of $$\lambda$$


$$
\lambda=\mathrm{E}(Y)=\operatorname{Var}(Y)
$$
 

In `Poisson Regression`, we expect $$\lambda$$ is determined by a vector of independent variables $$x$$.


$$
\lambda=E(Y|x) =  e^{\beta x^\prime}
$$


Hence, the linear form could be 


$$
\text{log}E(Y|x) = \beta x^\prime
$$


From Poisson distribution, the probability of "k" times appearance of  event Y is:


$$
Pr(Y=k|x;\beta)=\frac{e^{-e^{\beta x^\prime}}e^{\beta x^\prime k}}{k\ !}
$$

We can adopt MLE in estimating the coefficient $$\beta$$.

The likelihood function:


$$
L(\beta | x, Y)=\prod_{i=1}^{m} \frac{e^{k_{i} \beta x_{i}^{\prime}} e^{-e^{\beta x_{i}^{\prime}}}}{k_{i} !}
$$

Take the logarithm, we get the log-likelihood function.

$$
\text{log }L(\beta| x,Y) = -\sum_i^m e^{\beta x_i^\prime}+\sum_i^mk_i \beta x^\prime_i-\sum \text{log}(k_i)
$$

Take derivative with respect to $$\beta$$, 

$$
\frac{\partial \log L(\beta | x, Y)}{\partial \beta}=0
$$


We can get the MLE estimator of parameters in `Poisson Regression`.

However, the equation above doesn't have an analytical solution, we can only apply convex optimization to find the optimal (approximated) value of $$\beta$$.

