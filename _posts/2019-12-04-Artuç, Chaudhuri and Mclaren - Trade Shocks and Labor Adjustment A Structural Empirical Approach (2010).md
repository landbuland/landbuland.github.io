---
layout: post
title: "Artuç,et al.(2010),Trade Shocks and Labor Adjustment A Structural Empirical Approach"
date:   2019-12-04 23:59:59
categories: Paper_Notebook
---




# Artuç, Chaudhuri and Mclaren - Trade Shocks and Labor Adjustment: A Structural Empirical Approach (2010)

​		这篇文章探究的主要问题是贸易解放(Trade Liberalization) 等贸易政策变化 (Trade Shock) 对工人福利的影响。一个主要贡献在于文章对Dynamic DIscrete Choice Model (DDCM) 提出了一个简便且成本低的计算方法，不需要将该模型中每一期的Value function 计算出来。主要的特点如下：

1. 对工人的决策有Rational Expectation的假设
2. 引入了宏观经济学中常用的描述动态最优的 Euler Equation，替代对 Value Function 的多次迭代计算
3. 估计出的 Labor Transition Cost 极高，作者对此的解释是，它揭示了经济体中工人转移的 Slow Adjustment





## Introduction and LR

​		有很多文献研究贸易政策变化对工人福利的影响，但是这些研究有很多基于一些不现实的假设，比如假设工人在各个产业之间无成本的充分流动，或者是假设他们完全不会流动，这样忽视了流动这个行为对贸易政策的offset，估计出来的影响可能偏高或偏低。而且，在一个动态的环境中，贸易政策很有可能有许多不同的影响。

​		同时，也有很多文献关注的问题是 Trade Shock 对工人工资的影响，实际上工资和工人福利是两回事，很多时候可以看到产业中工人的福利和工资变化方向完全相反。

​		因此像其他很多经济学家一样，本文作者提出一个基于 rational expectation 的动态模型 (See McLaren, 2007)，并用美国 Current Population Survey (CPS) 数据估计参数。

​		作者还在工人流动的决策函数中引入了 idiosyncratic shock，作为个人层面转移决策的uncertainty 的来源。这一项代表的是不能被金钱代替的影响决策的因素，它是没有被经济学家观察到的。这样做有两个原因，其一是流动数据中总的流动量往往大于净流动量，这意味着有许多工人同时向不同的方向转移；第二是实际上可以观察到许多工人自愿从高工资的职业转移去了低工资的行业，这与模型的 Optimal Decision 是不一致的。所以 idiosyncratic shock 会在决策中起到不可忽视的作用。



----



## Models

​		作者引入的模型基本可以概括为两个模型。其一是 Ricardo-Viner Trade Model，用来描述基本的industry 产出、worker wage 与工人流动的动机。第二个模型是通过DDCM描述了动态环境中工人流动的具体行为。其中与传统的DDCM不同的一点是，作者引入了 Euler Equation，避免了对工人每期的Value Function进行计算，简化了计算成本。这里仅针对DDCM中的主要内容进行总结。



### Equilibrium Condition (Eular Equation)

假设第 *i* 个industry 中工人总数为 *L* ，每个工人的Utility 为$$
U^{i}(L, s, \varepsilon)
$$ ，*s* 为 state，$$\varepsilon$$ 表示每个工人各自的 idiosyncratic shock。$$V^{i}(L, s)$$ 表示对该 industry 中所有工人的 $$U^{i}(L, s,\varepsilon)$$ 的平均值。


$$
\begin{aligned} U^{i}\left(L_{t}, s_{t}, \varepsilon_{t}\right) &=w_{t}^{i}+\max _{j}\left\{\varepsilon_{t}^{j}-C^{i j}+\beta E_{t}\left[V^{j}\left(L_{t+1}, s_{t+1}\right)\right]\right\} \\ &=w_{t}^{i}+\beta E_{t}\left[V^{i}\left(L_{t+1}, s_{t+1}\right)\right]+\max _{j}\left\{\varepsilon_{t}^{j}+\bar{\varepsilon}_{t}^{i j}\right\} \end{aligned}
$$


其中：


$$
\bar{\varepsilon}_{t}^{i j} \equiv \beta E_{t}\left[V^{j}\left(L_{t+1}, s_{t+1}\right)-V^{i}\left(L_{t+1}, s_{t+1}\right)\right]-C^{i j}
$$


对 *U* 求期望即为 *V*


$$
V^{i}\left(L_{i}, s_{t}\right)=w_{t}^{i}+\beta E_{t}\left[V^{i}\left(L_{t+1}, s_{t+1}\right)\right]+\Omega\left(\bar{\varepsilon}_{t}^{i}\right)
$$


其中：


$$
\Omega\left(\bar{\varepsilon}_{t}^{i}\right)=\sum_{j=1}^{N} \int_{-\infty}^{\infty}\left(\varepsilon^{j}+\bar{\varepsilon}_{t}^{i j}\right) f\left(\varepsilon^{j}\right) \prod_{k \neq j} F\left(\varepsilon^{j}+\bar{\varepsilon}_{t}^{i j}-\bar{\varepsilon}_{t}^{i k}\right) d \varepsilon^{j}
$$


用$$
V^{i}\left(L_{i}, s_{t}\right)
$$ 替换掉 $$
\bar{\varepsilon}_{t}^{i j}
$$ 的表达式得到：


$$
\begin{aligned} C^{i j}+\bar{\varepsilon}_{i}^{i j}=& \beta E_{i}\left[V^{j}\left(L_{i+1}, s_{i+1}\right)-V^{i}\left(L_{i+1}, s_{i+1}\right)\right] \\=& \beta E_{i}\left[w_{i+1}^{j}-w_{i+1}^{i}+\beta E_{i+1}\left[V^{j}\left(L_{i+2}, s_{i+2}\right)-V^{i}\left(L_{i+2}, s_{i+2}\right)\right]\right.\\ &\left.+\Omega\left(\bar{\varepsilon}_{i+1}^{j}\right)-\Omega\left(\bar{\varepsilon}_{i+1}^{i}\right)\right] \end{aligned}
$$


i.e.


$$
C^{i j}+\bar{\varepsilon}_{i}^{i j}=\beta E_{i}\left[w_{i+1}^{j}-w_{i+1}^{i}+C^{i j}+\bar{\varepsilon}_{i+1}^{i j}+\Omega\left(\bar{\varepsilon}_{i+1}^{j}\right)-\Omega\left(\bar{\varepsilon}_{i+1}^{i}\right)\right]
$$


这里 *V* 的表达式即为 Euler Equation，也就是说 Equilibrium Condition 需要满足这个式子。



### The Estimating Equation

​		这里有一个前提，即如果一个工人选择了一个 industry，那么意味着对他来说，选择这个 industry 的效用要高于其他选择的效用。同时假设各个工人是独立同分布的。

​		另外，我们需要假设idiosyncratic shock 满足 Extreme Value Distribution。


$$
\varepsilon \sim \text{Gumble}(0,\nu)
$$


i.e.


$$
\begin{aligned} E(\varepsilon) &=0,  \\ 

\\
\operatorname{Var}(\varepsilon) &=\frac{\pi^{2} \nu^{2}}{6} \end{aligned}
$$


​		由此可以推出，
$$
\begin{aligned}
\begin{array}{c}{\bar{\varepsilon}_{t}^{i j} \equiv  \beta E_{t}\left[V_{t+1}^{j}-V_{t+1}^{i}\right]-C^{i j}=\nu\left[\ln m_{t}^{i j}-\ln m_{t}^{i i}\right]} \\ {\Omega\left(\bar{\varepsilon}_{t}^{i}\right)=-\nu \ln m_{t}^{i i}}\end{array}\end{aligned}
$$


​		然后可得：


$$
\begin{array}{l}{E_{t}\left[\frac{\beta}{\nu}\left(w_{t+1}^{j}-w_{t+1}^{i}\right)+\beta\left(\ln m_{t+1}^{i j}-\ln m_{t+1}^{j j}\right)\right.}  {\left.-\frac{(1-\beta)}{\nu} C^{i j}-\left(\ln m_{t}^{i j}-\ln m_{t}^{i i}\right)\right]=0}\end{array}
$$


即，


$$
\left(\ln m_{i}^{i j}-\ln m_{t}^{i i}\right)= \frac{-(1-\beta)}{\nu} C^{i j}+\frac{\beta}{\nu}\left(w_{t+1}^{j}-w_{t+1}^{i}\right) +\beta\left(\ln m_{t+1}^{i j}-\ln m_{t+1}^{j j}\right)+\mu_{t+1}
$$


​		这里 $$\mu_{t+1}$$ 与 wage 很可能相关，作者将使用工具变量解决遗漏变量偏差。

​		在模型中， Wage differential 的系数 $$\frac{\beta}{\nu}$$ 与 *C*  是主要需要估计的参数。  $$\frac{\beta}{\nu}$$ 越小，则说明 wage differential 对工人转移的吸引力越小，可能是一些非经济的因素决定了工人的转移；它也可以理解为劳动力供给的弹性，若这个值越小，则工资相对劳动力供给的弹性越差。另外，这个模型也可以引入工人之间的异质性，比如可以按工人的类型分类，然后分别通过这个模型估计参数。



## Data

​		本文中使用的数据是 US Census Bureau's March Current Population Survey Data。时间范围从1976年至2001年。样本中的个人的行业信息是指的调查前一年受访人工作时间最长的行业。该行业中的工资收入由在这个行业中的所有工人的平均工资决定，并用CPI折合成实际收入。行业总数为6个。

​		由于CPS在1976年与1989年有两次统计方法的变化，导致同样的指标在当年的变化十分剧烈，因此作者将一部分imputation的数据提出，并且删除掉了1976年之前的数据。

​		在估计参数的时候，作者将 wage 进行了 normalization，以便于直观地发现 transition cost 的大小。

​		描述性统计如下图：

![image-20191204195528227](https://tva1.sinaimg.cn/large/006tNbRwly1g9kxrzxaowj30oj0gndim.jpg)



## Results

![image-20191204195753290](https://tva1.sinaimg.cn/large/006tNbRwly1g9kxufn8crj30oc0kjad1.jpg)

​		

​		Panel 1 和 2 分别是OLS 和 IV regression 的结果，但是估计出的 Transition Cost 仍然较大，相当于13倍(或者8倍)的工资收入。这意味着由 wage differential 引起的产业间的工人转移是缓慢的，是不太敏感的。因此作者考虑了四种可能导致偏差的情况。



### Sampling Error in Wages

​		第一种可能的偏差来源于样本中 wage 数据可能存在的错误。如果 wage 数据有问题，那么会导致 regression 中 migration pattern 与 wage pattern 不匹配，导致 wage differential 前的系数偏低。

​		为了检验并解决这个问题，首先作者将时间跨度加大，regression 中用五年而不是一年作为一个区间，结果如上图 Panel 3，cost 比起 baseline 变小了，但是作者认为五年的额区间对于政策评估来说没有意义，但是这个结果说明，只有一部分过高的 cost 估计值是因为样本中工资数据的问题导致。其次，作者用另外一个有更多观测值的数据集替代掉CPS 数据的平均工资，但是结果并没有太大改善。因此作者认为，这个问题并不是导致这里不准确估计的原因。



### Timing and Misinterpretation of Flow  rate

​		由于CPS是在每年三月份进行的调查，作者认为这个数据集只能记录一年中数个月窗口期中的人口流动。因此工人产业转移的比例被大大降低了。所以作者对Transition Matrix 进行了年化调整 (annualize transition matrix)。基于另外一个数据集的参照，作者给出的调整方法是:


$$
m_t = m_t^{\frac{12}{5}}
$$


其中 $$m_t$$ 是各个年份中 CPS 数据集中所记录的工人转移矩阵。



### Sectoral Composition Effect

​		在之前的 identification strategy 中，所有的结论都是基于全部工人是同质的这一假设，但是实际上这个假设不成立。为了去除工资中存在的有 heterogeneous worker 带来的 labor composition effect，文章中用 linear，log-linear和 log-linear and extra interactions 三种OLS regression 形式估计 wage，然后用这个值带入估计 Transition cost，结果如最后3个 Panel 所示。



### Misspecification of moving cost

​		最后一种，作者放宽了对所有Transition 使用相同的cost的设定，允许了不同行业有不同的Entry Cost。结果如下：大多数Sector 的cost 下降，除了sector4 。这说明sector4 相较于其他行业来说有较大的障碍妨碍工人转移进入。但是其他的一些行业仍然也存在着较大的 Transition Cost。



![](https://cdn.mathpix.com/snip/images/4WiZ6BLpkh_yxHGcSjPXLMKZoaYuOuoxC2PQyUJh98s.original.fullsize.png)



## Simulation

待续..
