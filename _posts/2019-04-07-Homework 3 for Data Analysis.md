---



---
# Independence of Irrelevant Alternatives (IIA) Assumptions and some Extentions



## Abstract

In this note, I would like to concentrate on the topic about Independence of Irrelevant Alternatives(IIA) assumptions, which plays a crucial role in model selections when doing classifications. Thus, based on what we have learned from class, I would like to illustrate what IIA is, the method of testing it and some reliable models that could be applied if IIA failed.



## What is IIA?

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

## Method of Testing IIA

As the previous chapter mentioned, the multinomial requires  the independence of irrevelent allternatives to hold, making the result to be reliable. Hence, in order to test the IIA assumption, Hausman and McFadden (1984) proposed a generalized method with underlying principle of removing one alternatives, estimating the model again and comparing the results. 



Specifically, Hausman-McFadden test requires us to estimate a model containing all the categories with $$J$$ alternatives and $$\mathbf{\widehat\beta_J}$$ as coefficients. After that, we have to estimate the model with one alternative deleted, which means it conprise $$J-1$$ categories and $$\mathbf{\widehat{\beta_{J-1}}}$$ as coefficients. Besides, we also need to calculate the variance and covariance matrix, which could be donated as $$\mathbf{V_J}$$ and $$\mathbf{V_{J-1}}$$ respectively.



Hence, we are able to calculate the Hausman-McFadden statistics by 

$$H_1=[\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-1}}}][\mathbf{\widehat{V_{J-1}}}-\mathbf{\mathbf{\widehat{V_J}}}][\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-1}}}]$$

It follows the Chi-Square distribution with the degree of freedom of 1. 



Actually, if the categories $$J$$ is large, we can delete more than one alternatives and do this test following the procedures above. In that circumstance, the H-M statistics ought to be:

$$H_k=[\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-k}}}][\mathbf{\widehat{V_{J-k}}}-\mathbf{\mathbf{\widehat{V_J}}}][\mathbf{\widehat{\beta_J}-\widehat{\beta_{J-k}}}]$$

where k manifest the number of alternatives we delete in the H-M test, while the degree of freedom tend to be $$k $$.



##  Nested logit model

Sometimes the IIA assumption fails, the multinomial logit model fails correspondingly and we have to try other models. In essence, the multinomial probit model that we have learned in class could be an alternative, however, it suffers from the speed of calculation. Commonly it takes relatively long time to get access to the result. Hence, in this section I would like to introduce another optional model, which is the nested logit model.



Nested logit model deals with the problems that IIA fails. It divided all the alternatives into some subsets (also called nests) and those alternatives within the same subsets or nests are allowed to be similiar and correlated. The correlation between alternatives are shown in the following figure. The left one shows multinomial logit model while the right one shows the nested logit model.

[图片1]

where $$A_i$$ and $$B_i$$ indicates the alternatives that individual $$i$$ has.

For classification with nested logit model, first we estimate for the alternatives in Multinomial logit model within the lower nests, which is represented as $B$ in the above figure. Notice that we have to omit all the variables (denote as $\mathbf{Z}$) that could be the same for alternatives within the nests.



Take the example of mode of transportation that we have discussed in class to illustrate, suppose households are choosing their transportations from bus subway and car. the relationships for the alternatives should be:

[图片2]



$$Pr(Bus|PT)=\frac{exp(\mathbf{x'\beta_{bus}})}{exp(\mathbf{x'\beta_{bus}})+exp(\mathbf{x'\beta_{subway}})}$$

$$Pr(Subway|PT)=1-Pr(Bus|PT)$$

$$P(Car)=\frac{exp(\mathbf{x'\beta_{car}})}{exp(\mathbf{x'\beta_{car}})+exp(V_{PT})}$$

where $$V_{PT}=\phi log(exp(\mathbf{x'\beta_{bus}})+exp(\mathbf{x'\beta_{subway}}))+\sum_k \alpha_kZ_k$$

$$P(PT)=1-P(Car)$$

Therefore, according to the conditional probability, we are able to compute the probability of various choices and do the classification.

$$P(Bus)=P(Bus|PT)P(PT)$$

$$P(Subway)=P(Subway|PT)P(PT)$$



## Realization of H-M test and Nested logit model in R


$$
# Hausman test for IIA
library(mlogit)
transport.long <- mlogit.data(transport, shape="wide",  choice = "ModeOfTransportation")
logitfit2 <- mlogit(ModeOfTransportation~0|LogIncome+DistanceToWork,transport.long,reflevel = "bus")

## first estimate the same model only for public transports
public <- mlogit(ModeOfTransportation~0|LogIncome+DistanceToWork, transport.long,alt.subset=c("bus","subway"))
hmftest(logitfit2,public)
$$