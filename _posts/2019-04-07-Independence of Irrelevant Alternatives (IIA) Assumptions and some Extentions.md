---
layout: post
title: "Independence of Irrelevant Alternatives (IIA) Assumptions and some Extentions"
date:   2019-04-07 23:59:59
categories: Moments
---
# Independence of Irrelevant Alternatives (IIA) Assumptions and some Extentions

Author: ZHANG Zihan

----

## Abstract

In this note, I would like to concentrate on the topic about Independence of Irrelevant Alternatives(IIA) assumptions, which plays a crucial role in model selections when doing classifications. Thus, based on what we have learned from class, I would like to illustrate what IIA is, the method of testing it and some reliable models that could be applied if IIA failed.

----

## 1. What is IIA?

Generally speaking, Independence of Irrevelant Alternatives assumption suggests that the preference of an individual between item A and item B does not change when another item X alters if IIA assumption holds, which means the outcome of a choice between two items only depend on the features of these two items and it is not affected by the features or characteristics of other items or variables.



To have a better understanding of the implications of IIA, it is better to look at the formula of the multinomial logit model. According a standard multinomial logit model with 3 categories ($$J=3 $$), we can express the probabilities as:

$$Pr(y_i=1|\mathbf{x_i})=\frac{1}{1+exp(\mathbf{x_i'} \mathbf{\beta_2})+exp(\mathbf{x_i'} \mathbf{\beta_3})}$$

$$Pr(y_i=2|\mathbf{x_i})=\frac{exp(\mathbf{x_i'} \mathbf{\beta_2})}{1+exp(\mathbf{x_i'} \mathbf{\beta_2})+exp(\mathbf{x_i'} \mathbf{\beta_3})}$$

$$Pr(y_i=3|\mathbf{x_i})=\frac{exp(\mathbf{x_i'} \mathbf{\beta_3})}{1+exp(\mathbf{x_i'} \mathbf{\beta_2})+exp(\mathbf{x_i'} \mathbf{\beta_3})}$$

where $$\mathbf{x_i}$$ represents the vector of features of individual $$i$$ and $$\mathbf{x_i'} \mathbf{\beta_j}=\sum_{k=0}^K \beta_{jk}x_{ik}$$.

Therefore, we calculate the relevance between these categories (which is called odds) by:

$$log \frac{Pr(y_i=j|\mathbf{x_i})}{Pr(y_i=k|\mathbf{x_i})}=\mathbf{x_i'} (\mathbf{\beta_j}-\mathbf{\beta_k)}$$

which is in linear form and please notice that I have normalized $$\mathbf{\beta_1}=0$$.

From the formula, it is evident that the odds is only affected by option $$j$$ and $$k$$ , which is the implication of IIA assumption (at least in our classification topic and logit model).

------

## 2. Method of Testing IIA

As the previous chapter mentioned, the multinomial requires  the independence of irrevelent allternatives to hold, making the result to be reliable. Hence, in order to test the IIA assumption, Hausman and McFadden (1984) proposed a generalized method with underlying principle of removing one alternatives, estimating the model again and comparing the results. 



Specifically, Hausman-McFadden test requires us to estimate a model containing all the categories with $$J$$ alternatives and $$\mathbf{\widehat\beta_J}$$ as coefficients. After that, we have to estimate the model with one alternative deleted, which means it conprise $$J-1$$ categories and $$\mathbf{\widehat{\beta_{J-1}}}$$ as coefficients. Besides, we also need to calculate the variance and covariance matrix, which could be donated as $$\mathbf{V_J}$$ and $$\mathbf{V_{J-1}}$$ respectively.



Hence, we are able to calculate the Hausman-McFadden statistics by 

$$H_1=[\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-1}}}][\mathbf{\widehat{V_{J-1}}}-\mathbf{\mathbf{\widehat{V_J}}}][\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-1}}}]$$

It follows the Chi-Square distribution with the degree of freedom of 1. 

Actually, if the categories $$J$$ is large, we can delete more than one alternatives and do this test following the procedures above. In that circumstance, the H-M statistics ought to be:

$$H_k=[\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-k}}}][\mathbf{\widehat{V_{J-k}}}-\mathbf{\mathbf{\widehat{V_J}}}][\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-k}}}]$$

where k manifest the number of alternatives we delete in the H-M test, while the degree of freedom tend to be $$k $$.

Here, I provide the realization of hausman test in R.

First, load the data and transfer it into wide shape. We have to estimate with multinomial logit model.
{% highlight R %}
## first estimate the same model only for public transports
library(mlogit)
transport <- read.csv("Transport.txt")
transport.long <- mlogit.data(transport, shape="wide",  choice = "ModeOfTransportation")
logitfit2 <- mlogit(ModeOfTransportation~0|LogIncome+DistanceToWork,transport.long,reflevel = "bus")
{% endhighlight %}

Then, we are going to delete the "Car" option and estimate within the subset. Having those done, Hausman test is available.

{% highlight R %}
## subset estimation and Hausman test for IIA
public <- mlogit(ModeOfTransportation~0|LogIncome+DistanceToWork, transport.long,alt.subset=c("bus","subway"))
hmftest(logitfit2,public)
$$
{% endhighlight %}

The result for this dataset is as follows.

<img src="/static/posts/HW3/4.png">

## 3. Nested logit model

Sometimes the IIA assumption fails, the multinomial logit model fails correspondingly and we have to try other models. In essence, the multinomial probit model that we have learned in class could be an alternative, however, it suffers from the speed of calculation. Commonly it takes relatively long time to get access to the result. Hence, in this section I would like to introduce another optional model, which is the nested logit model.



Nested logit model deals with the problems that IIA fails. It divided all the alternatives into some subsets (also called nests) and those alternatives within the same subsets or nests are allowed to be similiar and correlated. The correlation between alternatives are shown in the following figure. The left one shows multinomial logit model while the right one shows the nested logit model.

<img src="/static/posts/HW3/1.png">

where $$A_i$$ and $$B_i$$ indicates the alternatives that individual $$i$$ has.

For classification with nested logit model, first we estimate for the alternatives in Multinomial logit model within the lower nests, which is represented as $$B$$ in the above figure. Notice that we have to omit all the variables (denote as $$\mathbf{Z}$$) that could be the same for alternatives within the nests.



Take the example of mode of transportation that we have discussed in class to illustrate, suppose households are choosing their transportations from bus subway and car. the relationships for the alternatives should be:

<img src="/static/posts/HW3/2.png">

Hence, we can donete these probabilities as follows:

$$Pr(Bus|PT)=\frac{exp(\mathbf{x'\beta_{bus}})}{exp(\mathbf{x'\beta_{bus}})+exp(\mathbf{x'\beta_{subway}})}$$

$$Pr(Subway|PT)=1-Pr(Bus|PT)$$

$$P(Car)=\frac{exp(\mathbf{x'\beta_{car}})}{exp(\mathbf{x'\beta_{car}})+exp(V_{PT})}$$

where $$V_{PT}=\phi log(exp(\mathbf{x'\beta_{bus}})+exp(\mathbf{x'\beta_{subway}}))+\sum_k \alpha_kZ_k$$

$$P(PT)=1-P(Car)$$

Therefore, according to the conditional probability, we are able to compute the probability of various choices and do the classification.

$$P(Bus)=P(Bus|PT)P(PT)$$

$$P(Subway)=P(Subway|PT)P(PT)$$

----------

## Reference
[1]Independence of irrelevant alternatives, Wikipedia,[https://en.wikipedia.org/wiki/Independence_of_irrelevant_alternatives#Criticism_of_IIA](https://en.wikipedia.org/wiki/Independence_of_irrelevant_alternatives#Criticism_of_IIA)

[2]Nested Logit Model,Indian institute of technology, [https://www.civil.iitb.ac.in/~kvkrao/uploads/5/9/3/7/59372049/nl.pdf](https://www.civil.iitb.ac.in/~kvkrao/uploads/5/9/3/7/59372049/nl.pdf)

[3]Jiaming Mao, Classification, [https://jiamingmao.github.io/data-analysis/assets/Lectures/Classification_and_Discrete_Choice_Models.pdf](https://jiamingmao.github.io/data-analysis/assets/Lectures/Classification_and_Discrete_Choice_Models.pdf)

[4]王静, 《嵌套logit模型在STATA软件当中的拟合》

------

## Appendix

The homework is also written in $$\mathbf{LaTex}$$ with [PDF version]({{site.baseurl}}/assets/script_3.pdf)available. 

Data (Transport.txt) are available [here](https://github.com/landbuland/landbuland.github.io/tree/master/assets/HW3/)

