---
layout: post
title: "Solow Growth Model"
date:   2019-10-02 23:59:59
categories: Advanced_Macro
---

# Chap-1 Solow Growth model
`Given by Prof. Jaehone Kim, Tue & Thu 19.00-21.00 @学生公寓105`

10% Assignments and Quizzes.

40% Midterm

50% FInal.

<iframe frameborder="yes" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=34341360&auto=1&height=66"></iframe>

### 0.写在前面

Basic Solow Model 是没有优化的模型，假定saving rate 是外生变量，这样做的好处是:

1）能够说明增长的问题并不依赖于对于储蓄率的假设。

2）walfare issues。

3）framework and tools for studies in growth..

### 1.Assumptions and Model:

4 variables - output (*Y*), capital (*K*), labor(*L*), and "knowledge" or the "effectiveness of labor" (*A*).

$$
Y_t =F(K_t,A_tL_t)
$$

K is the aggregate capital in an isolated economy. Same as A and L.(Productivity and labor force)

**It satisfies two conditions**

1) Inada condition, making sure increasing and concave utility function. (Inada, 1964)

$$
F_1(K,AL)>0;\quad F_2(K,AL)>0
 \\ 
F_{11}(K, L)<0, \quad F_{22}(K, L)<0
\\
\begin{array}{ll}{\lim _{K \rightarrow 0} F_{1}(K, L)=\infty \text { for any } L>0,} & {\lim _{L \rightarrow 0} F_{2}(K, L)=\infty \text { for any } K>0} \\ {\lim _{K \rightarrow \infty} F_{1}(K, L)=0 \text { for any } L>0,} & {\lim _{L \rightarrow \infty} F_{2}(K, L)=0 \text { for any } K>0}\end{array}
$$

- It implies **concave** utility curve and marginal decreasing curve.

- 3/4条注意是一阶导函数的条件，不是原函数的条件。

2) Homogeneous degree of 1.$$Y = F(k\textbf{x})=kF(x)$$

Also, 

$$
F(0,AL)=F(K,0)=0
$$


If the homogeneity satisfies, then the following properties hold.

- 1

  $$
  \begin{array}{c}{f_{i}(\mathbf{x}) :=\frac{\partial f(\mathbf{x})}{\partial x_{i}} \text { is homogeneous of degree } k-1 . \text { i.e. }} \\ {f_{i}(\mu \mathbf{x})=\mu^{k-1} f_{i}(\mathbf{x})}\end{array}
  $$

- 2

  $$
  \begin{array}{l}f{\text {  satisfies: }} \\ {\qquad k f(\mathbf{x})=f_{1}(\mathbf{x}) x_{1}+f_{2}(\mathbf{x}) x_{2}+\cdots+f_{N}(\mathbf{x}) x_{N}}\end{array}
  $$

since $$\sum_{xi}k_i=k$$

所以对于Solow Growth model,总产出可以被分解成,

$$
Y=F(K, A L)=F_{K}(K, A L) K+F_{L}(K, A L) LY=F(K, A L)=F_{K}(K, A L) K+F_{L}(K, A L) L
$$

**Proof**: according to theorem 2 above,

$$
Y = F(K,AL) =F_K(K,AL)K+F_2(K,AL)AL\\since, F_L(K,AL)=\frac{\partial F(K,AL)}{\partial AL}\frac{\partial AL}{\partial L}=F_2(K,AL)A \quad\square
$$

**Per capita form**

$$
F\left(\frac{K}{A L}, 1\right)=\frac{1}{A L} F(K, A L)
$$

Divided by efficient labor, solow model could be rewrite as,

$$
y=f(k)
$$

Obviously, the output per capita is a function of capital per capita.

------



### 2.Per capita form and Steady state

denote:

$$
y = \frac{Y}{AL}
$$

for the aggregate output

$$
\dot K = I_t-\delta K_t
$$

in per capita form:

$$
\dot k=i_t-(\delta+n+g)k_t
$$

**proof**: notice that $$ \dot k = \frac{\partial k}{\partial t}$$and $$k = K/AL$$

In the steady state 

some growth rate A: g L:n Y/L g Y:n+g

------



### 3. Consumption impact$$\rightarrow$$ golden rule

$$
c^{*}=f\left(k^{*}\right)-(n+g+\delta) k^{*}
$$

and take the derivatives 

$$
\frac{\partial c^{*}}{\partial s}=\left[f^{\prime}\left(k^{*}(s, n, g, \delta)\right)-(n+g+\delta)\right] \frac{\partial k^{*}(s, n, g, \delta)}{\partial s}
$$

首先注意，$$k^*=k^*(n,g,\delta,s)$$，在Solow Growth Model中假设它们是exogenous的

由于$$\frac{\part k^*}{\part s}$$ 是positive的，所以$$\frac{\partial c^{*}}{\partial s}$$ 的正负号取决于前半部分的符号，也就是说，资本的边际生产率大于折旧率，人口增长和技术进步率的和的时候，提升saving rate 对稳态时的消费水平的边际效益是正的。

maximize the consumption and then get the golden rule 

golden rule 是在稳态的条件下最大化消费, i.e.

$$
f'\left(k^{*}\right)=(n+g+\delta)
$$

------



### 4. Elasticity

根据稳态的equation, 求$$\partial k^*/\part{s}$$

since in the steady state,

$$
sf(k^{*})=(n+g+\delta) k^{*}
$$

Take the FOC on both sides with respect to $$s$$，

$$
s f^{\prime}\left(k^{*}\right) \frac{\partial k^{*}}{\partial s}+f\left(k^{*}\right)=(n+g+\delta) \frac{\partial k^{*}}{\partial s}
$$

Therefore,

$$
\frac{\partial k^{*}}{\partial s}=\frac{f\left(k^{*}\right)}{(n+g+\delta)-s f^{\prime}\left(k^{*}\right)}
$$

把它带入

$$
\frac{\partial y^{*}}{\partial s}=f^{\prime}\left(k^{*}\right) \frac{\partial k^{*}(s, n, g, \delta)}{\partial s}
$$

用$$s f\left(k^{*}\right)=(n+g+\delta) k^{*}$$ 置换掉$$sf(k^*)$$，得到

$$
\frac{\partial y^{*}}{\partial s}=\frac{f^{\prime}\left(k^{*}\right) f\left(k^{*}\right)}{(n+g+\delta)-s f^{\prime}\left(k^{*}\right)}
$$

然后可以计算稳态收入水平对saving rate 的弹性。

$$
\begin{aligned}\frac{\triangle y^*/y^*}{\triangle s/s}= \frac{s}{y^{*}} \frac{\partial y^{*}}{\partial s} &=\frac{s}{f\left(k^{*}\right)} \frac{f^{\prime}\left(k^{*}\right) f\left(k^{*}\right)}{(n+g+\delta)-s f^{\prime}\left(k^{*}\right)} \\ &=\frac{(n+g+\delta) k^{*} f^{\prime}\left(k^{*}\right)}{f\left(k^{*}\right)\left[(n+g+\delta)-(n+g+\delta) k^{*} f^{\prime}\left(k^{*}\right) / f\left(k^{*}\right)\right]} \\ &=\frac{k^{*} f^{\prime}\left(k^{*}\right) / f\left(k^{*}\right)}{1-\left[k^{*} f^{\prime}\left(k^{*}\right) / f\left(k^{*}\right)\right]} \end{aligned}
$$

注意，$$\frac{dy}{dk^*}\frac{k^*}{y}=\frac{k^* f'(k^*)}{f(k^*)}=\alpha_k$$

$$
\frac{s}{y^{*}} \frac{\partial y^{*}}{\partial s}=
\frac{\alpha_{K}\left(k^{*}\right)}{1-\alpha_{K}\left(k^{*}\right)}
$$

此为收入对储蓄率的弹性表达式。

------



### 5. Speed of convergence

结论:

$$
\frac{\dot{k}}{k-k^*}=(\alpha_k - 1)(n+g+\delta)
$$

**Proof**

首先可以将 $$\dot k$$ 看做是 $$k_t$$ 的函数，$$\dot k=\dot k(k_t)$$

然后根据Taylor Expansion在 $$k^*$$ 处的展开， 可以得到，

$$
\dot k(k)\approx\dot k(k^*)+\frac{\part \dot k(k^*)}{\part k}(k-k^*)
$$

其中，稳态时$$\dot k = 0$$，所以convergence speed 实际上就是$$\frac{\partial \dot{k}\left(k^{*}\right)}{\partial k}$$ 

$$
\begin{aligned}\left.\frac{\partial \dot{k}(k)}{\partial k}\right|_{k=k^{*}} &=\left[s f^{\prime}\left(k^{*}\right)-(n+g+\delta)\right] \\ &=\frac{(n+g+\delta) k^{*} f^{\prime}\left(k^{*}\right)}{f\left(k^{*}\right)}- (n+g+\delta)\\ &=\left[\alpha_{k}-1\right](n+g+\delta) \quad\square\end{aligned} 
$$

**Note that ** $$\frac{\partial \dot{k}(k)}{\partial k}<0$$  since $$\alpha $$ is usually expected to less than 1.

同样可以证明，$$y_t$$ 也是按照相同的速率收敛到稳态。

------



### 6. 解释和补充

- Solow Growth Model implies the divergence in various countries could be attributed to two different factors, including capital per capita (K/L) and labor efficiency. However, in reality, there's no evidence supporting that gaps of capital per labor could lead to such huge differences between rich countries and the poor ones. Efficiency is a better explanation of income divergence.

- Solow model assume that the efficiency is growing at a constant rate exogenously, which suffers a problems of explaining economic growth with an assumption of growth cause the growth in efficiency is not proved within this model.



