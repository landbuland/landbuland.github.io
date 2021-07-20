#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 13:40:51 2021

@author: zihan
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
    