---
layout: post
title: "3 Tips Tips of Checking differences of scripts in STATA"
date:   2021-07-20 23:59:59
categories: Code_notebook
---

# 3 Tips of Checking differences of scripts in STATA

- 生成日志文件人工比较

  code：STATA 生成log file 日志文件

```STATA
cap log close // 主要是防止与上一个log file 互相干扰
log using "name.log", replace text
include your code that need be written in log here
cap log close //结束

```



- 自动检查两个do file是否一致

​	STATA 检查两个do file (data1 and data2) 是否一致

```
use data1.dta
cf _all using data2.dta, verbose
```



- 利用Mac终端检查任意脚本（文本）是否一致

​	Mac 利用Terminal 比较script是否一致

```MacTerminal
cd "path"
diff "fileA.do" "fileB.do"
```







