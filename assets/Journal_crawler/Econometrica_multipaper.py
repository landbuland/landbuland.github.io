#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 14 00:46:18 2021

@author: zihan
"""
import pandas as pd
import numpy as np
import requests
from bs4 import BeautifulSoup as soup
import time

header = {
    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
}


base = 'https://onlinelibrary.wiley.com/toc/14680262/' # url for ECA

yearlist = list(range(2017,2022))
vollist = list(range(85,90))
volurl = []
for i in range(5):
    for j in range(6):
        volurl.append(base + str(yearlist[i]) + '/' + str(vollist[i]) + '/' + str(j+1))    
 
# scrape doi     
doi_list = []    
print("start scraping doi!")
for url in volurl:
    try:
        time.sleep(1)
        root = requests.get(url, headers = header)    
        leaf = soup(root.text, 'lxml')
        element = leaf.find_all('a',class_ = 'issue-item__title visitable')
        for doi in element:
            doi_list.append(doi['href'])
        
    except (requests.exceptions.SSLError, requests.exceptions.ConnectionError) as e:
        if 'bad handshake' in str(e) or '10054' in str(e):
            continue
        else:
            raise Exception(e)
    else:
        print(url,' done!')
    
    
artweb = 'https://onlinelibrary.wiley.com'

abstracts = []
titles = []
authors = []

print('start scraping article information!')
# scrape abstract
for doi in doi_list:
    time.sleep(1)
    
    try:
        url = artweb + doi
        root = requests.get(url, headers = header)
        leaf = soup(root.text, 'lxml')
    except (requests.exceptions.SSLError, requests.exceptions.ConnectionError) as e:
        
        if 'bad handshake' in str(e) or '10054' in str(e):
            continue
        else: 
             raise Exception(e)
    else:
        print(doi, ' URL OK!')         
    
    try:
        element = leaf.find_all('div', class_ = 'article-section__content en main')
        abst = element[0].select('p')
        abst = str(abst)
        abst.strip()[4:-5]
        abstracts.append(abst)
        
        element = leaf.find_all('h1', class_ = 'citation__title')
        title = element[0].get_text()
        titles.append(title)
        
        element = leaf.find_all('a', class_ = 'author-name accordion-tabbed__control')
        for i in element:
            au_text = str(i.find('span'))
            au_sp = soup(au_text,'lxml')
            author = au_sp.find('span').get_text()
            authors.append(author)

    except IndexError:
        print(doi, ' No information found!')       
    else:
        print(doi, ' done!')            
        
        
filename = open('Eca_abstracts.txt', 'w',encoding='UTF-8')
for value in abstracts:
    filename.write(str(value))
filename.close()  # txt file
    