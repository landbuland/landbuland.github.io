---
layout: post
title: "A Web Crawler for Basic information of articles in Top 5 Econ Journals."
date:   2021-07-20 23:59:59
categories: Data_Analysis
---

# A Web Crawler for Basic information of articles in Top 5 Econ Journals.



There are five top English journals in Economics, including the American Economic Review (AER), the Quarterly Journal of Economics (QJE), Econometrica (ECA), Journal of Political Economics (JPE) and Review of Economic Studies (RES). They are the most authoritative ones in the field of economics, and widely recognized by  economists. Moreover, recent articles published on these journals are often regarded as the leading researches in each sub field of economics. As a result, catching up with what these journals favors now will be beneficial to econ researchers and students to closely put themselves together with the hot topics, and then, generating interesting research questions. However, it may be hard to read the articles one by one after each volume issued since there are a greater number of articles published each year. Hence, some techniques like web crawler can be helpful to get the topics of the recent articles. 

Here I provide a web crawler based on `Python` for the basic information of these journal articles. With this crawler, it is quite easy to scrape the headers, authors and abstracts of top journal articles for their websites. 



## 1. A simple case for AER

Firstly, let's take a look at the American Economic Association website. You will find it easy to get the article information directly from the website. The articles are organized by their DOI on the official website. Therefore, we can find each specific article based on DOI and further get the basic informations. 

Give DOI, the following `Python` code will help you to scrape information. Here I use the *Request* and *BeautifulSoup* module.

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 09:57:43 2021

@author: z
"""
"""
Given DOI, scrape basic information of AER articals
"""

import requests
from bs4 import BeautifulSoup as soup

link = 'https://www.aeaweb.org/articles?id=10.1257/aer.20191758'
root = requests.get(link)
leaf = soup(root.text,'lxml')

## get headers
header_list = leaf.find_all('h1') 
header_text = header_list[1].get_text()

## get authors
authors = []
author_list = leaf.find_all('li', class_ = 'author')
for au in author_list:
    autext = au.get_text()
    authors.append(autext)

## get abstracts
abs_list = leaf.find_all('section',class_ = 'article-information abstract')
abs_text = abs_list[0].get_text()

```



## 2. Scrape recent articles on AER

Haven scraped the information for one specific article, it is straight forward to think of how do we scrape them one by one. The solution is also intuitive, because it only requires us to get the DOI for each article from the website, then we can find the articles sequentially with DOIs.

Fortunately, the DOI and volumeurl are also well organized from the AEA website.  We can firstly scrape the url for each volume, and then find out the DOI for each article. You can go to https://www.aeaweb.org/issues/642 to take look at.

The code is as follows.

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 12:08:07 2021

@author: z
"""


import requests
from bs4 import BeautifulSoup as soup
import numpy as np

web = 'https://www.aeaweb.org'
base = 'https://www.aeaweb.org/journals/aer/issues'
root = requests.get(base)
leaf = soup(root.text,'lxml')

## scrape volume url
vol_list = []
for i in range(1,6):
    classlink = "journal-preview last-col-" + str(i) # link to last i year journals
    vol_element = leaf.find_all('article', class_ = classlink)
    vol_element = str(vol_element)
    vol_elementsp = soup(vol_element,'lxml') 
    vol_text = vol_elementsp.find_all('a')# find out the url for volumns
    for vol in vol_text:
        vol_list.append(vol['href'])
    
    print('volumn link successful! year',i)    
        
## scrape doi
doi_list = []
print('start scraping doi!')
for u in vol_list:
    vol_link = web + u
    doi_root = requests.get(vol_link)
    doi_leaf = soup(doi_root.text,'lxml')
    doi_element = doi_leaf.find_all('article')
    for doi in doi_element:
        try:
            doi_list.append(doi['id'])
        except KeyError:
            print('Unable to find id!')
        else:
            print(doi['id'] + ' successful!')
            
## save doi_list            
a = np.array(doi_list)
np.save('doi_list.npy', a)   # npy file

filename = open('doi_list.txt', 'w')
for value in doi_list:
    filename.write(str(value))
filename.close()  # txt file

```



After that, we can combine the code above to find the article one by one.

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 13:40:51 2021

@author: z
"""

import requests
from bs4 import BeautifulSoup as soup
import numpy as np

doi_list = np.load('doi_list.npy') # read doi_list file
doi_list = doi_list.tolist()

artweb = 'https://www.aeaweb.org/articles?id='

authors = []
abstracts = []
headers = []
for doi in doi_list:
    link = artweb + doi
    root = requests.get(link)
    leaf = soup(root.text,'lxml')
    
    try:
        ## get abstracts
        abs_list = leaf.find_all('section',class_ = 'article-information abstract')
        abs_text = abs_list[0].get_text()
        abstracts.append(abs_text)
        
        ## get headers
        header_list = leaf.find_all('h1') 
        header_text = header_list[1].get_text()
        headers.append(header_text)
        
        ## get authors

        author_list = leaf.find_all('li', class_ = 'author')
        for au in author_list:
            autext = au.get_text()
            authors.append(autext)
                
    except IndexError:
        print('Not an academic article')
        
    else:
        print(doi + ' done!')

## save            
a = np.array(abstracts)
np.save('abstracts.npy', a)   # npy file

b = np.array(authors)
np.save('authors.npy', b)

c = np.array(headers)
np.save('headers.npy',c)

filename = open('abstracts.txt', 'w')
for value in abstracts:
    filename.write(str(value))
filename.close()  # txt file
    
```



## 3. A word cloud

With the abstracts, we are able to draw a word cloud to see what are the most popular topics or fields that AER favors. Later I will discuss how to make this world cloud based on text data.

![wordcloud_aer](E:\课程资料备份\DigitalEconomyDecisionAnalytics-master\project_LDA\Output & Wordcloud\wordcloud_aer.png)



## 4. Code for other articles

You may find it via my Github repository.

