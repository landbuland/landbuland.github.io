---

layout: post
title: "Stata tips - Outreg2"
date:   2022-10-12 23:59:59
categories: Code_notebook

---

# Stata tips - Outreg2

- Descriptive Statistics

```stata
outreg2 using DS.tex, replace sum(log) keep(var) title(Decriptive statistics)
```



- Regression

```stata
reg Y X, r
outreg2 using reg1.tex, replace keep(var) title(reg1) addtext("A","YES","B","NO")

reg Y Z, r
outreg2 using reg2.tex, append keep(var) title(reg2) addtext("A","YES","B","NO")
```

