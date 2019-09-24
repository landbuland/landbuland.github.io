---
layout: post
title: "An Overview of Causal Inference"
date:   2019-06-06 23:59:59
categories: Data Analysis
---

# An Overview of Causal Inference

## Abstract 

 In this note, I am going to write an overview of the part of the causal inference and make some summaries and comparisons with the idea of traditional econometrics.

-----

## 1. 因果关系推断

计量经济学主要解决的是如何推断因果关系的问题。变量间有没有因果关系，且因果关系的程度如何，以及如何区分相关关系和因果关系的问题。

首先要明确的是，现实中的相关关系往往并不意味着因果关系。从数学表达式的角度来看，相关关系和因果关系的主要区别在于，在人为改变解释变量的情况下，因变量会不会随之改变，也就是Seeing 与 Doing 的区别。如果改变解释变量的值对应着因变量的变化，那么因果关系即成立。如下式所示。

$$
E[y | \operatorname{do}(x=a)]=E[y | x=a]
$$

### 1.1 RCM

传统用于探究因果关系的一个框架是Rubin Causal Model(RCM)，这一模型借鉴了实验的思想。假设我们要探究一个treatment是否多outcome有因果关系，在RCM中假设个体的outcome $$Y_i= \{ Y_{1i},Y_{0i} \} $$ ，其中$$Y_{1i}$$ 表示个体 $$i$$ 如果受到了treatment的outcome, $$Y_{oi}$$ 表示个体i 如果没有收到treatment 的结果。而且他们和treatment之间有如下的关系。

$$
Y_{i}=D_iY_{1i}+(1-D_i)Y_{0i}
$$

对于个体的treatment effect，可以表示为

$$
TE = Y_{1i}-Y_{0i}
$$

但是实际对于个体来说，$$Y_{1i}$$ 和 $$Y_{0i}$$ 是不可能同时获取的。一个个体在收到treatment的时候，也就意味着其本身不可能在成为没有收到treatment 的个体。因此对于每个个体来说，无法实际计算他们的treatment effect。



### 1.2 ATE 和随机实验

因此，要探究treatment effect，只可能在群体的层次上计算。RCM中定义了Average treatment effect (ATE)，Average treatment effect on the treated (ATT) 和 Average treatment effect on the untreated (ATU)。

$$
ATE=E[Y_{1i}-Y_{0i}] \\
ATT=E[Y_{1i}-Y_{0i}|D=1] \\
ATU=E[Y_{1i}-Y_{0i}|D=0] \\
$$

而且在个体随机分配是否treatment 的条件下，我们可以假设如果受到了treatment的这一群体，如果他们没有收到treatment的话，那么这一组的outcome应当和没有收到treatment 的那一组相同。因此在随机的条件下，ATE、ATT 和ATU 应该是完全一致的，而且通过直接比较两个组的平均值，就可以得到treatment effect。

$$
\operatorname{Treatment effect}\\E(Y|\operatorname{do(x=1)})=E[y | x=1]-E[y | x=0]
$$


在现实应用当中，除了平均值的比较，我们还可以用线性回归等一系列模型去估计ATE。

$$
ATE=\frac{\partial E(Y|\operatorname{Do(x=a)}}{\partial x}
$$

### 1.3 Conditional Independence Assumption (CIA)

在现实中，完全随机分配的实验凤毛麟角，因此直接找到treatment effect 不太现实，我们需要更进一步的假设。

CIA假设强调，在其他一些变量的条件下，treatment的分配与实验结果可以看做是不相关的。

$$
E(Y|\operatorname{do(x=1),Z})=E(Y|x=1,Z)
$$

------

## 2. 外部有效性

因果关系的推断往往伴随着其适用性这一问题。因果关系的大小也往往随着不同的总体的变化而变化。在不同的总体中，因为潜在的因果关系机制变化，或者是其他条件发生的概率变化，可能会导致因果关系的大小发生变化。传统的计量经济学中并未对这一部分进行深入的探究，但事实上，如果我们要了解这一因果关系的适用范围，那么需要了解这一因果关系的背后机制，并且用backdoor creterion 以及frontdoor creterion等一些方法解决。

-----

## 3. Structural Estimation

Structural Estimation 的主要思想是，使用一些经济学的模型或者理论构建描述因果关系的函数形式，如果背后的理论模型是正确的，那么Structural Estimation能够较好的估计出整个因果关系网络，能够从全局上探究因果关系。

Structural Estimation 有如下特点：

- 根据经济学理论构建模型
- 能够识别哪些不能被非参数方法识别的因果关系
- 因果关系可以应用到其他不同的总体当中
- 可以根据潜在的因果关系框架生成新数据用于拟合
- 可以用于计算消费者福利等难以量化的事物
- 更好的预测准确度



