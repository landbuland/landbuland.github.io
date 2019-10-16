---
layout: post
title: "RCK Model"
date:   2019-10-16 23:59:59
categories: Advanced_Macro
---

# Chap 2 ,Part A - Ramsey-Cass-Koopmans Model 



## 0. 写在前面

In this model, `saving rate` is no longer exogenous, in other words, it is determined by households and firms in competitive market.



It is an overlapping generation model (OLG) developed by Ramsey, Cass and Koopmans in 1928, 1965 and 1965 respectively.

------



## 1. Assumptions

**Function form**: $$F(K,AL)$$ and $$F(\bullet)$$ also satisfies two conditions.

- Inada Conditions

- Homogeneous Degree of 1



**Growth rate**: *A* grows at rate *g* and *L* grows at rate *n*, all positive.



**Capital Accumulation**: `no depreciation`

$$
\dot{K}(t)=Y(t)-\zeta(t)
$$

where $$\zeta$$ implies the `total consumption`, while *C* (in capital form) represents the consumption per person and *c* in ordinary form denotes the <u>consumption per effective labor.</u>

$$
c_t=\frac{C_t}{A_t}
$$

**Firm Production**: each firm can produce with a function of $$F(K,AL)$$. Their target is to maximize their profit in the competitive market. They rent capital ( *K* ) and purchase labor ( *L* ) from households.

$$
k_t=\frac{K_t}{A_tL_t}
$$


**Capital Supply**: from household, all capital owned by households go to firms.



**Labor Supply**: from households, one member in households owns one unit of labor. 



**Labor's Utility**: Households max their **lifetime** Utility by determining the ratio of consumption and saving.

$$
U=\int_{t=0}^{\infty} e^{-\rho t} u(C(t)) \frac{L(t)}{H} d t
$$

where 

- $$u(\bullet)$$: 当期household 的utility ,是消费的函数
- *L(t)* : Total labor force (population)
- *H*: number of households
- $$\frac{L(t)}{H}$$: number of members of households
- $$\rho$$ : discount rate

The expression of utility:

$$
u(C(t))=\frac{C(t)^{1-\theta}}{1-\theta}, \quad \theta>0, \quad \rho-n-(1-\theta) g>0
$$

In addition, this kind of utility firm has the same interpretation as the log utility function,

**Proof**







------



## 2. Behaviors of Household and Firms

在这个模型中，假设时间是连续的，因此除了常数参数之外，变量是时间的函数。总结如下。

常数：

$$
\left\{\begin{array}{l}{\text { Two growth rates: } n, g} \\ {\text { Number of Households: } H} \\ {\text { Other constants: } \rho, \theta, \beta}\end{array}\right.
$$

时间的函数：

$$
\left\{\begin{array}{l}{C=C(t)} \\ {c=c(t)} \\ {r=r(t)} \\ {W=W(t)} \\ {w=w(t)} \\ {\vdots}\end{array}\right.
$$

### 

### Firm optimization

$$
max\quad F(K,AL)-rK-WL
$$



在每个时期中，Firm向Household 支付资本的租金以及劳动的报酬，同时卖出他们自己的产品获益。其中资本的租金为MPK，劳动的报酬为MPL

*注意在Firm optimization中* $$W$$ 代表的是wage per labor, $$w$$ 代表的是wage per effective labor. 注意区分两者的区别。

$$
W = wA,\quad \text{and} \quad w=\frac{W}{A}
$$

$$
\begin{array}
 \ MPK =r_t=f'(k_t)\\ \\ 
MPL=W_t=A_t[f(k_t)-k_tf'(k_t)]
\end{array}
$$

**Proof** :

将production function 改写成

$$
F(K,AL)=\frac{1}{AL}F(K,AL)\times AL
$$

therefore, MPK could be denoted as:


$$
\begin{array}
{l}
\textsf{MPK:}=\frac{\part F(K,AL)}{\part K}=\frac{\part f(K/AL)}{\part K}AL = f'(k)
\\

{\textsf{MPL}:
\begin{aligned}
\frac{\partial F(K, A L)}{\part L}=\frac{\partial f(K / A L)}{\partial L} A L&= ALf'(k)(-k)+Af(k) \\ &= A(f(k)-k f^{\prime}(k))
\end{aligned}}
\end{array}

$$

Therefore, the wage for effective labor:

$$
w = f(k)-k f^{\prime}(k)
$$




Hence, the firm's profit goes to 0. 这个结论也符合了市场的competitive 假设。





### Household optimization

$$
max \quad U=\int_{t=0}^{\infty} e^{-\rho t} u(C(t)) \frac{L(t)}{H} d t \\ \\
\\
 .
\\
\textsf{under the budget constraints.}
$$

- Here, the utility function could be denoted as

$$
u(C(t))=\frac{C^{1-\theta}}{1-\theta}
$$

这里的$$\frac{1}{\theta}$$ 表示的是两种消费品的替代弹性

**Proof**:

假设消费者有两种商品可以选择，他们的效用最大化表示为

$$
\max _{C_{1}, C_{2}} \frac{C_{1}^{1-\theta}}{1-\theta}+\frac{C_{2}^{1-\theta}}{1-\theta} \quad \text { s.t. } \quad p_{1} C_{1}+p_{2} C_{2}=1
$$

构造Lagrange 函数后，

$$
C_1^{-\theta}-\lambda p_1=0
\\ 
C_2^{-\theta}-\lambda p_2=0
$$

Then,

$$
\frac{C_2^\theta}{C_1^\theta}=\frac{p_1}{p_2}
$$

两边log取对数，

$$
-\frac{\partial \ln \left(C_{1} / C_{2}\right)}{\partial \ln \left(p_{1} / p_{2}\right)}=-\frac{\frac{\partial\left(C_{1} / C_{2}\right)}{C_{1} / C_{2}}}{\frac{\partial\left(p_{1} / p_{2}\right)}{p_{1} / p_{2}}}=\frac{1}{\theta}
$$

- 这一效用函数形式和$$u(C(t))=\text{ln }C(t)$$ 等价

  当$$\theta \rightarrow 1$$时，

$$
  u(C)-\frac{1}{1-\theta} \rightarrow \ln C
  $$

**Proof**

$$
  \lim _{\theta \rightarrow 1} \frac{C^{1-\theta}-1}{1-\theta}=\lim _{x \rightarrow 0} \frac{C^{x}-1}{x}=\lim _{x \rightarrow 0} \frac{C^{x} \ln C}{1}=\ln C
  $$



### Budget Constraints

Main idea: 整个lifetime中 agent 消费的现值不能超过初始资本以及lifetime 收入的现值的和，i.e. 

$$
\int_{t=0}^{\infty} e^{-R(t)} C(t) \frac{L(t)}{H} d t \leq \frac{K(0)}{H}+\int_{t=0}^{\infty} e^{-R(t)} W(t) \frac{L(t)}{H} d t
$$


其中, $$R(t) = \int_{t=0}^\infin r(\tau)d\tau$$，相当于迭代计算的折现率（利率）。

变形得到：

$$
\frac{K(0)}{H}+\int_{t=0}^{\infty} e^{-R(t)}[W(t)-C(t)] \frac{L(t)}{H} d t \geq 0
$$

写成极限的形式：

$$
\lim _{s \rightarrow \infty}\left[\frac{K(0)}{H}+\int_{t=0}^{s} e^{-R(t)}[W(t)-C(t)] \frac{L(t)}{H} d t\right] \geq 0
$$

在任意一个时间*s*中，household‘ s wealth可以表示为

$$
\frac{K(s)}{H}=e^{R(s)} \frac{K(0)}{H}+\int_{t=0}^{s} e^{R(s)-R(t)}[W(t)-C(t)] \frac{L(t)}{H} d t
$$

因此 Budget constraint 可以写为，

$$
\lim _{s \rightarrow \infty} e^{-R(s)} \frac{K(s)}{H} \geq 0 \quad\textsf{For any "s"}
$$

即在任何状态下，household 的wealth 将为正。

这个budget constraint 被称为， *no-Ponzi-game condition*



### Budget Constraints - Extensions

- Dynamic budget constraint

  $$
  \frac{\dot{K}(t)}{H}=r(t) \frac{K(t)}{H}+W(t) \frac{L(t)}{H}-C(t) \frac{L(t)}{H}
  $$
  
  它的意义在于，household 的财富增加值是在任意一个时间上，资本收益与劳动收益的和，再减掉这个时间的消费。注意在这个模型当中没有资本的折旧，时间是一个连续的函数。

  从这个constraint 推导上面一个constraint
  
  $$
  \begin{array}{l}{\textsf { From the dynamic budget constraint, we can derive }} \\ {\qquad \int_{0}^{T} e^{-R(t)} \dot{K}(t) d t=\int_{0}^{T} e^{-R(t)} r(t) K(t) d t+\int_{0}^{T} e^{-R(t)}(W(t)-C(t)) L(t) d t} \\ {\textsf { Note that by using the "integration by part", we have }} \\ {\qquad \int_{0}^{T} e^{-R(t)} \dot{K}(t) d t=e^{-R(T)} K(T)-e^{-R(0)} K(0)+\int_{0}^{T} e^{-R(t)} r(t) K(t) d t} \\ {\textsf { Hence, also by taking limits } T \rightarrow \infty, \textsf { we have }} \\ {\quad \lim _{T \rightarrow \infty} e^{-R(T)} K(T)=K(0)+\int_{0}^{\infty} e^{-R(t)}(W(t)-C(t)) L(t) d t \geq 0}\end{array}
  $$
  

  
