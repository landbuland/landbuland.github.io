---
layout: post
title: "Bayer, 2007, A Unified framework for measuring preferences for schools and neighborhoods"
date:   2021-10-26 23:59:59
categories: Paper_Notebook
---

# Bayer,2007,A Unified framework for measuring preferences for schools and neighborhoods

Published on JPE. [Paper](https://ideas.repec.org/a/ucp/jpolec/v115y2007i4p588-638.html)

My [slides]().

### Conclusion about findings:

1. First, households are willing to pay less than 1 percent
   more in house prices—substantially lower than previous estimates—
   when the average performance of the local school increases by 5
   percent. （当地的学校质量上升5个百分点，会让家庭的WTP上升一个百分点）
2. Second, much of the apparent willingness to pay for more
   educated and wealthier neighbors is explained by the correlation of
   these sociodemographic measures with unobserved neighborhood
   quality （这些社会人口统计指标与未被观察到的邻居质量之间的相关性解释了为受教育程度更高、更富有的邻里买单的明显意愿）
3. Third, neighborhood race is not capitalized directly into housing
   prices; instead, the negative correlation of neighborhood percent
   black and housing prices is due entirely to the fact that blacks live in
   unobservably lower-quality neighborhoods. （种族特征没有直接被考虑进房价，相反，观测到的黑人社区房价低是因为黑人居住在质量更低的社区，这体现在加入fixed effect之后系数变得不显著）
4. Finally, there is considerable heterogeneity in preferences for schools and neighbors, with households preferring to self-segregate on the basis of both race and education. （对学校和邻居的偏好存在相当大的异质性，取决于家庭的教育程度和种族）



### What did they do in this paper:

1. They developed a framework for **recovering household preference for a broad set of school and neighborhood attributes** in the presence of sorting. At the heart is a discrete choice model...permitting household choices to be influenced by unobservable choice attributes 

   Framework 沿用了两套评价家庭对于住房偏好的理论框架，hedonic price regression 和 discrete choice models.

2. They provide a strategy for addressing the endogeneity of school and neighborhood attributes in the context of heterggeneous sorting model, by embeding the boundary discountiuity design (BDD) developed by Black (1999). 

3. They provide new estimates of household preferneces for schools and neighbors. 

   因为他们数据质量好，A restricted- access version of US census with detailed characteristics for nearly a quarter of a million households and their houses in the San Francisco Bay Area. 

4. **Contribution to the estmation of hedonic price function for housing.** They introduce a model of residential sorting. This not noly returns estimates of the full distribution of household preferences for housing and neighborhood, but also serves to illuminate when the coefficients in a hedonic price regression provide a close approximation to mean prefrence. 加入这个模型，能够揭示hedonic price function在Household homogenous的假设下，regression 的系数正好反映Household 的平均偏好。在家庭异质性存在的假设下，这个模型又提供了对hedonic price function描述preference 的一种adjustment。（Sheppard(1999) 总结了hedonic price 识别上的一些困难，这个paper在对用hedonic price function 识别household对attributes的偏好上有贡献）



### Strategy (intuition) of their identification strategy - BDD

1. 首先在理想情况下，如果有两栋房子在学区边界两侧，而且都挨着边界，那么可以认为其他的socialdemographics feature对这两栋房子的影响是一样的。那么通过观察household sorting，就可以推断household对于学校质量的preference。但是在实践当中，为了保证有足够的样本数量进行有意义的统计推断，不能只比较紧挨着边界两侧的房子，而是要扩大一定的距离(e.g. 0.3 miles)。这时候就需要控制一些socialdemographics。 

   （个人感觉这里应用的是地理断点的思想，但是他的发表可能比较早？所以他们没有管自己的方法叫RD？类似于Dell(2014)也是用地理断点研究了秘鲁地区边界两侧长期发展不平衡的一个问题，还拿了2020年Clark奖。）

2. 由于Household sorting across the boundary, 边界之际的social demographics会呈现出一些特征上的变化，这些sorting带来的变化都和边界两侧的学校质量是相关的，因此一旦能控制住学校质量的差异，就可以推断出household 对neighborhood 的preference。





