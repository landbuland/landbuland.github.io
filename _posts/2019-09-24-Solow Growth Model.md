---
layout: post
title: "Solow Growth Model"
date:   2019-09-24 23:59:59
categories: Advanced_Macro
---

# Chap-1 Solow Growth model
`Given by Prof. Jaehone Kim, Tue & Thu 19.00-21.00 @学生公寓105`

10% Assignments and Quizzes.

40% Midterm

50% FInal.

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=34341360&auto=1&height=66"></iframe>

### 写在前面

Basic Solow Model 是没有优化的模型，假定saving rate 是外生变量，这样做的好处是:

1）能够说明增长的问题并不依赖于对于储蓄率的假设。

2）walfare issues。

3）framework and tools for studies in growth..

### Assumptions and Model:

4 variables - output (*Y*), capital (*K*), labor(*L*), and ‘‘knowledge’’ or the ‘‘effectiveness of labor’’ (*A*).

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

- 

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
Y=F(K, A L)=F_{K}(K, A L) K+F_{L}(K, A L) L
$$

**Per capita form**

$$
F\left(\frac{K}{A L}, 1\right)=\frac{1}{A L} F(K, A L)
$$

Divided by efficient labor, solow model could be rewrite as,

$$
y=f(k)
$$

Obviously, the output per capita is the function of capital per capita.

