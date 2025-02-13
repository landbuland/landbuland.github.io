---
layout: post
title: "Consumer Demand in a Nested CES Utility Framework"
date:   2025-02-12 00:00:59
categories: Advanced_Micro
---
# Consumer Demand in a Nested CES Utility Framework

Consider a consumer who has a two-layer nested utility function, where the upper nest is a Cobb-Douglas form:

$$
U=\alpha \ln C_D+(1-\alpha) \ln C_M
$$

where

$$
C_D=\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]^{\frac{\sigma}{\sigma-1}}
$$


The consumption bundle $$C_D$$ contains a number of varieties $$v$$.
Suppose the price level $$p$$ is given.
In the first step, we need to solve the upper nest:

$$
\begin{array}{c}
\max U=\alpha \ln C_D+(1-\alpha) \ln C_M \\
\text { s.t. } P_D C_D+P_M C_M=E
\end{array}
$$

which gives the Marshallian demand for the composite goods $$C_D$$ and $$C_M$$ :

$$
C_D=\frac{\alpha E}{P_D}, \quad C_M=\frac{(1-\alpha) E}{P_M}
$$


In the second step, we solve the demand for each variety $$v$$ by maximizing the subutility $$C_D$$ given the expenditure $$E_D=P_D C_D$$ :

$$
\begin{array}{l} 
\max C_D=\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]^{\frac{\sigma}{\sigma-1}} \\
\text { s.t. } \sum p_v q_v=E_D
\end{array}
$$

The first-order condition yields:

$$
\begin{aligned}
\lambda p_v & =\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]^{\frac{1}{\sigma-1}} b_v^{\frac{1}{\sigma}} q_v^{-\frac{1}{\sigma}} \\
& =\frac{C_D}{\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]} b_v^{\frac{1}{\sigma}} q_v^{-\frac{1}{\sigma}}
\end{aligned}
$$


Then,

$$
q_v=\frac{C_D^\sigma b_v}{\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]^\sigma p_v^\sigma} \lambda^{-\sigma}
$$


Multiply both sides by $$p_v$$ and sum over $$v$$, we can solve for $$\lambda$$ :

$$
\lambda^\sigma=\frac{C_D^\sigma\left[\sum_v p_v^{1-\sigma}\right]}{E_D\left[\sum_v b_v^{\frac{1}{\sigma}} q_v^{\frac{\sigma-1}{\sigma}}\right]^\sigma}
$$


Plug $$\lambda$$ back into $$q_v$$ :

$$
q_v=\frac{b_v E_D}{p_v^\sigma P_D^{1-\sigma}}
$$

where $$E_D=\frac{\alpha E}{P_D}$$ and $$P_D=\left[\sum_v b_v p_v^{1-\sigma}\right]^{\frac{1}{1-\sigma}}$$.
