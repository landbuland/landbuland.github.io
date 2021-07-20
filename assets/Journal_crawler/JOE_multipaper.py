#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 14 15:22:19 2021

@author: zihan
"""

import numpy as np
import requests
from bs4 import BeautifulSoup as soup

base = 'https://www.sciencedirect.com/journal/journal-of-econometrics/vol/'

issurl = []
for vol in range(196,224):
    for issue in range(1,3):
        link = base + str(vol) +'/issue/' + str(issue)
        issurl.append(link)

header = {
    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
}

arturl = []
for url in issurl:
    try:
        root = requests.get(url, headers = header)
        leaf = soup(root.text,'lxml')
        element = leaf.find_all('a', class_ = 'anchor article-content-title u-margin-xs-top u-margin-s-bottom')
        for i in element:
            arturl.append(i['href'])
    except (requests.exceptions.SSLError, requests.exceptions.ConnectionError) as e:
        if 'bad handshake' in str(e) or '10054' in str(e):
            continue
        else: 
            raise Exception(e)
    else: print(url, ' Volumn URL OK!')

web = 'https://www.sciencedirect.com'
abstracts = []
for urli in arturl:
    url = web + urli
    try:
        root = requests.get(url, headers = header)
        leaf = soup(root.text,'lxml')
    except (requests.exceptions.SSLError, requests.exceptions.ConnectionError) as e:
        if 'bad handshake' in str(e) or '10054' in str(e):
            continue
        else: 
            raise Exception(e)
    else: print(url, ' Paper URL OK!')
    
    try:
        element = leaf.find_all('div', class_ = 'abstract author')
        element = soup(str(element),'lxml')
        element = element.find_all('p')
        abstracts.append(element[1].get_text())
    except IndexError:
        print(url, ' Not an adacemic artical!')
        
    else:
        print(url, ' done!')
        
filename = open('JOEabstracts.txt', 'w',encoding='UTF-8')
for value in abstracts:
    filename.write(str(value))
filename.close()  # txt file
                
