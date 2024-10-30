---
layout: post
title: "ACM (2010, AER) - Trade Shocks and Labor Adjustment: A Structural Empirical Approach"
date:   2024-10-30 00:59:59
categories: Paper_Notebook
---

# ACM(2010) - Trade Shocks and Labor Adjustment: A Structural Empirical Approach

By Artuc, Chaudhuri, and McLaren

[My Slides on ACM (2010)]("www.google.com")

### Research Question and motivation

This paper addresses a classic question in trade and labor economics: the impact of trade liberalization and other trade shocks on worker welfare. Unlike most studies in the existing literature, which typically use static models and assume labor is either perfectly mobile or immobile, this paper takes a pioneering approach by employing a dynamic model of labor supply. This dynamic framework allows for an analysis of the costs, welfare effects, and labor market adjustments that unfold over time in response to a (hypothetical) trade shock, offering new insights into labor market dynamics under trade liberalization.

### Model

The model features a dynamic labor supply and a static labor demand. The labor supply is described by a dynamic rational expectations framework, where workers can move across industries at a cost. Following a dynamic discrete choice model, each worker chooses the industry that offers the highest expected benefits, factoring in expected future wages, moving costs, and idiosyncratic shocks. With rational expectations, workers also consider the “option value” of being in an industry, which reflects the benefit of having flexibility to switch in response to future changes. In terms of production, each industry’s production is modeled with a CES production function, with industry-specific parameters for elasticity of substitution, labor and capital shares, and technology level.

### Data- CPS

The paper uses CPS data from 1976 to 2001 to support its estimation, which allows them to calculate industry-level migration flow probabilities and wages. The sample includes male workers aged 25-64 who worked at least 26 weeks per year and earned between \$50 and \$5,000 per week. Workers are categorized into six industries for the analysis: Agriculture and Mining, Construction, Manufacturing, Transportation, Communication and Utilities, Trade, and Services. 

### Estimation and calibration  

For estimating the dynamic labor supply model, this paper employs an Euler equation approach to establish equilibrium conditions, which removes the need to compute the workers' value function and significantly reduces computational complexity. The model's key parameters-moving cost $C$ and marginal utility of income $\nu$ (more precisely, $\beta/\nu$)-are estimated by regressing relative flow probabilities on wage differentials and a set of moving dummies using OLS. However, due to potential issues with reverse causality and omitted variable bias, the authors use lagged values of endogenous variables as IVs to obtain consistent estimates.

For the CES production functions, the authors use labor shares, average wages, and value-added GDP as moments in their GMM estimation to recover the parameters in the production function. So far, this paper finished all the process before setting up a hypothetical trade shock and check the impact of labor market using counterfactual simulations. 

### Simulation and results

The paper finds that labor market adjustment to trade shocks is sluggish, requiring several years to reach a new equilibrium due to high moving costs that slow worker mobility across industries. In import-competing sectors, wages decline significantly following trade liberalization and do not fully recover, reflecting reduced labor demand as these sectors contract. However, despite the wage drop, workers in these sectors may still experience welfare gains, as idiosyncratic shocks enable mobility, allowing them to take advantage of rising real wages in other industries. This mobility creates an “option value” that can offset wage losses in the affected sectors. 

