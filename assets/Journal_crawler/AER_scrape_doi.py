#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 12:08:07 2021

@author: zihan
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
    
    
        
    
