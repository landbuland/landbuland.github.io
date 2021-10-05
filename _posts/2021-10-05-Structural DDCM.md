---
layout: post
title: "一个行为模型的结构化估计：动态离散选择模型及应用（1）"
date:   2021-10-05 23:59:59
categories: Data_Analysis
---



# 一个行为模型的结构化估计：动态离散选择模型及应用（1）

2021-10-05

这一篇笔记参考的文献是劳动经济学手册卷4A的第四章，主要介绍了离散选择的动态规划（DCDP）模型的结构化估计方法，并且列举了很多该模型在一些经典劳动经济学问题中的应用，还一并提供了很多经典模型的例子作为参考。这一篇笔记介绍的是离散选择模型的基本框架，和在静态的离散选择模型中的实证的基本结构。其他部分会在后续的笔记中涉及。



## 离散选择问题的“隐变量框架” (Latent variable framework)

概括来说，离散选择模型的建模思想是模拟人做选择的过程，所以它可以视为一个行为模型。而选择的空间需要是离散的。因此借助效用的概念，如果我们看到一个人在某一个时间上选择了某一个选项，这就代表着对这个人来说，选择这一项的效用更高。所以这个时候就涉及到了不同潜在选择对应的效用的比较。而这种比较就涉及到了隐变量，因为这个人不可能在同一个时间有不一样的选择。

比如举个例子，假设有个人$i$ 在时间$$t = 1,...,T$$ 做选择要不要结婚，因此他的选择就是 $$d_{i t} \in\{0,1\}$$。那么他的决策就取决于一个隐变量 $$v_{it}^{*}$$ ， 这个隐变量描述是他两种潜在选择的效用之差。如果有$$v_{it}^*>0$$ 则  $$d_{it}=1$$ ，反之则  $$d_{it}=0$$ 。我们可以把这个隐变量看作一个函数，因为决策者的效用可能与一系列变量存在关系。可能和过去的选择和该决策者自身的一些情况相关，因此一般情况下，$$v_{it}$$  可以看作是三类变量的函数，即 

$$
v_{it}^ *= v_{i t}^{*}\left(\tilde{D}_{i t}, \tilde{X}_{i t}, \widetilde{\epsilon}_{i t}\right)
\tag{1}
$$

其中，$$\tilde{D}_{i t}$$ 表示由过去的选择 $$\left(d_{i \tau}: \tau=1, \ldots, t-1\right)$$ 所构成的向量， $$\tilde{X}_{i t}$$ 表示一些可以被观测到的当期和滞后的相关变量组成的集合 $$\left(X_{i j \tau}: j=1, \ldots, J ; \tau = 1,...,t\right)$$ ， $$\widetilde{\epsilon}_{i t} $$ 表示那些无法被观测到的，但是对决策者同样有作用的变量， $$\left(\epsilon_{i \tau}: \tau=1, \ldots, t\right)$$ 。

所有的二元选择问题，包括动态和静态的选择问题，实际上都与 $(1)$ 有关。不同的假设可以让这个框架应用到不同的问题上。比如如果考虑用 $$(1)$$ 建模一个动态的选择问题，就可以假设决策者在做选择的时候是有前瞻性的 (forward-looking) ， 或者在变量中体现在 $$\tilde{D}_{i t}$$ 和 $$\widetilde{\epsilon}_{i t}$$ 是具有序列相关性的。如果考虑一个静态的选择问题，模型就可以假设上面的变量不存在序列相关性，或者是决策者本身是短视的。



## 静态选择模型的实证结构

通过一个经典例子展示静态和动态离散选择模型之间的联系。这是一个劳动经济学中最古老和广泛研究的话题之一：家庭中已婚女性的劳动供给问题。

先来看静态离散选择的建模。假设一个家庭由一对夫妻和若干个子女构成，他们的目标是最大化生活的乐趣，也就是效用。同时家庭中存在决策，因为要决定妻子是外出工作还是留在家中抚养子女。如果外出工作将会增加收入，可以增加家庭的消费；如果留在家中照看子女则可以收获陪伴子女的乐趣，有助于家庭关系的和谐，因此也会增加家庭的总效用。因此这样存在一个权衡 (trade-off)， 家庭需要决策妻子是不是要外出工作来最大化他们的效用。

首先假设一个家庭(Household) $i$ 在时间$t$  效用由如下形式表示：

$$
U_{i t}=U\left(c_{i t}, 1-d_{i t} ; n_{i t}\left(1-d_{i t}\right), \kappa_{i t}\left(1-d_{i t}\right), \epsilon_{i t}\left(1-d_{i t}\right)\right)
\tag{2}
$$

其中 $$c_{it}$$ 是家庭在当期的消费，$$d_{it}$$ 是工作还是居家的决策，$$n_{it}$$ 表示家庭中的子女个数，$$\kappa_{i t}$$ 和 $$\epsilon_{it}$$ 分别表示其他可观测的和不可观测的与家庭效用相关的因素。如果选择不外出工作，那么家庭的总效用可以通过这些因素增加。但是如果选择外出工作，那么这些因素将不对效用的增加做出贡献。对于效用函数的形式，一些常规的假设也同样适用，比如常用的 $$\partial U / \partial C>0, \partial^{2} U / \partial C^{2}<0$$ ，描述效用随消费增加的递增和边际递减。家庭所面临的预算约束为

$$
c_{i t}=y_{i t}+w_{i t} d_{i t}-\pi n_{i t} d_{i t}
\tag{3}
$$

其中$ $y_{it} $$ 表示家庭丈夫的工作收入，模型中假设丈夫每一期都是有工作的。$$w_{it }$$  表示妻子如果工作的收入。$$\pi$$ 表示对每一个孩子的抚养成本，这一项假设是与时间无关的，而且对不同的家庭都是一致的。另外，模型假设对于劳动市场以外的人来说，工资水平是不可见的。因此在估计模型的时候，需要给定一个工资函数。

$$
w_{i t}=w\left(z_{i t}, \eta_{i t}\right)
\tag{4}
$$

$$z_{it}$$ 和 $$\eta_{it}$$ 分别表示影响工资水品的可见和不可见的因素。将工资水平和消费预算约束带入效用函数中进行整理，就可以得到一个化简之后的效用函数表达式，

$$
\begin{aligned}
U_{i t}=& U\left(y_{i t}+w\left(z_{i t}, \eta_{i t}\right) d_{i t}\right.\\
&\left.-\pi n_{i t} d_{i t}, 1-d_{i t} ; n_{i t}\left(1-d_{i t}\right), \kappa_{i t}\left(1-d_{i t}\right), \epsilon_{i t}\left(1-d_{i t}\right)\right)
\end{aligned}
\tag{5}
$$

如果某个家庭选择让妻子出去工作，那这个家庭的效用水平就可以表示为，

$$
U_{i t}^{1}=U\left(y_{i t}+w\left(z_{i t}, \eta_{i t}\right)-\pi n_{i t}, 0\right)
$$

反之如果不去工作，

$$
U_{i t}^{0}=U\left(y_{i t}, 1 ; n_{i t}, \kappa_{i t}, \epsilon_{i t}\right)
$$

因此，影响家庭做决策的隐变量函数就可以表示成，

$$
v_{i t}^{*}=U_{it}^1-U_{it}^0=v^{*}\left(y_{i t}, z_{i t}, n_{i t}, \kappa_{i t}, \epsilon_{i t}, \eta_{i t}\right)
\tag{6}
$$

如果$$v_{it}^*>0$$ ，那么家庭就应当选择让妻子外出工作，反之则不外出工作。这个函数包括了之前模型中所有可观测的变量，如丈夫的收入 $$y_{it}$$， 影响妻子收入水平的可见因素 $$ z_{it}$ ，家庭中子女的数量 $$n_{it}$$，以及直接影响家庭效用的可观测因素 $$\kappa_{it}$$ ；也包括了不可观测的全部因素 $$\epsilon_{it}$$ 和 $$\eta_{it}$$ 。这些可以被观测到的变量被成为这个家庭的状态变量(state variable)。因此，定义状态变量空间(State variable space) 是所有状态变量所构成的集合，记为 $$\Omega_{it}$$ ，另外包括不可观测变量的集合记为 $$\Omega_{it}^-$$ 。再定义 $$S\left(\Omega_{i t}^{-}\right)=\left\{\epsilon_{i t}, \eta_{i t} \mid v^{*}\left(\epsilon_{i t}, \eta_{i t} ; \Omega_{i t}^{-}\right)>0\right\}$$ ，表示让$$v_{it}^*>0$$ 的 $$\epsilon_{it}$$ 和 $$\eta_{it}$$ 的取值的集合。这样一来，如果知道了 $$\epsilon_{}$$ 和 $$\eta_{}$$ 的条件联合分布，就可以推断出家庭对于提供劳动供给的概率，就是该分布在S集合上的积分。

$$
\operatorname{Pr}\left(d_{i t}=1 \mid \Omega_{i t}^{-}\right)=\int_{S\left(\Omega_{i t}^{-}\right)} \mathrm{d} F_{\epsilon, \eta \mid y, \kappa, z, n}=G\left(y_{i t}, z_{i t}, n_{i t}, \kappa_{i t}\right)
\tag{7}
$$

通过以上过程，我们最终得到了一个描述家庭供给劳动的概率的一个函数，它的解释变量包括建模过程中用到的所有可观测的变量。

有了$(7)$ ，我们就可以对模型进行估计。从模型结构的角度可以分为结构估计和非结构估计(structural estimation and non-structural estimation)。区别在于，非结构估计的目的只是为了找到$$(7)$$ 中的 $$G( \dot \ )$$，因此非结构估计更侧重于解释某些因素最终的影响，而不是具体的作用机制；相反，结构估计则要更深入地找出其中一些元素的作用机制，也就能够最后求出模型的整个结构，从而能够进行一些反事实推断。另外从估计方法的角度，又可以把估计分为参数估计和非参数估计。前者需要对之前模型中设定的一些方程进行一些参数化的假设，将求解模型简化为求解其中的一些参数，而后者则要通过非参数的方法估计模型所用到的函数的具体形式。

在这个例子中，参数化的非结构估计很类似于跑回归，这可以用来解释各个可观测的变量对于劳动供给的影响。比如可以直接通过一个Probit回归分析这个问题。

如果要用参数结构估计，考虑一个比较简单的例子，所有的函数都是线性可加的。

$$
\begin{aligned}
U_{i t}=& c_{i t}+\alpha_{i t}\left(1-d_{i t}\right) \quad \text { with } \alpha_{i t}=\kappa_{i t} \beta_{\kappa}+\beta_{n} n_{i t}+\epsilon_{i t} \\
c_{i t}=& y_{i t}+w_{i t} d_{i t}-\pi n_{i t} d_{i t} \\
w_{i t}=& z_{i t} \gamma+\eta_{i t} \\
& f\left(\epsilon_{i t}, \eta_{i t}\right) \sim N(0, \Lambda)
\end{aligned}
$$

其中 $\Lambda=\left(\begin{array}{cc}\sigma_{\epsilon}^{2} & \\ \sigma_{\epsilon \eta} & \sigma_{\eta}^{2}\end{array}\right)$。然后把这些假设的方程形式带入之前的模型，可以得到$(6)$ 的具体形式。

$$
\begin{aligned}
v_{i t}^{*}\left(z_{i t}, n_{i t}, \kappa_{i t}, \eta_{i t}, \epsilon_{i t}\right) &=z_{i t} \gamma-\left(\pi+\beta_{n}\right) n_{i t}-\kappa_{i t} \beta_{\kappa}+\eta_{i t}-\epsilon_{i t} \\
&=\xi_{i t}^{*}\left(\Omega_{i t}^{-}\right)+\xi_{i t}
\end{aligned}
\tag{8}
$$

现在问题简化成了估计模型中的参数，需要估计的参数包括 $$\beta_{\kappa}$$，$$ \beta_{n}$$，$$\gamma$$ ，$$ \pi$$， $$\sigma_{\epsilon}^{2}$$ ，$$\sigma_{\eta}^{2}$$ 和 $$ \sigma_{\epsilon \eta}$$ 。需要注意的是如果没有额外假设，无法直接分别估计得到 $$\pi $$ 和 $$\beta_n$$ 的值，而是只能得到他们的和。

通过构造一个Likehood function，以上参数可以用MLE进行估计。

$$
\begin{aligned}
L\left(\theta ; \kappa_{i t_{i}}, z_{i t_{i}}, n_{i t_{i}}\right)=& \prod_{i=1}^{I} \operatorname{Pr}\left(d_{i t_{i}}=1, w_{i t_{i}} \mid \Omega_{i t}^{-}\right)^{d_{i t_{i}}} \operatorname{Pr}\left(d_{i t_{i}}=0 \mid \Omega_{i t_{i}}^{-}\right)^{1-d_{i}} \\
=& \prod_{i=1}^{I} \operatorname{Pr}\left(\xi_{i t_{i}} \geq-\xi_{i t_{i}}^{*}\left(\Omega_{i t_{i}}^{-}\right), \eta_{i t_{i}}=w_{i t_{i}}-z_{i t_{i}} \gamma\right)^{d_{i t_{i}}} \\
& \times \operatorname{Pr}\left(\xi_{i t}<-\xi_{i t}^{*}\left(\Omega_{i t}^{-}\right)\right)^{1-d_{i t_{i}}}
\end{aligned}
\tag{9}
$$

至此，结构模型的估计已完成。将这些参数的估计值填入模型即可进行反事实模拟，可以用来做分析。

