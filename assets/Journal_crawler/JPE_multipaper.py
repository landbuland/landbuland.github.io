#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 14 13:28:39 2021

@author: zihan
"""

import numpy as np
import requests
from bs4 import BeautifulSoup as soup

base = 'https://ideas.repec.org'
# url = 'https://ideas.repec.org/s/ucp/jpolec.html'

urlist = ['https://ideas.repec.org/s/ucp/jpolec.html',
          'https://ideas.repec.org/s/ucp/jpolec2.html',
          'https://ideas.repec.org/s/ucp/jpolec3.html']

header = {
    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
}


arturl = []
for url in urlist:
    root = requests.get(url, headers = header)
    leaf = soup(root.text,'lxml')
    element = leaf.find_all('li', class_ = 'list-group-item downgate')
    for i in element:
        target_sp = soup(str(i))
        target = target_sp.find('a')['href']
        arturl.append(target)
        print(target, ' doi got!')

abstracts = []
titles = []
authors = []
for doi in arturl:
    try:
        url = base + doi
        root = requests.get(url, headers = header)
        leaf = soup(root.text,'lxml')
    except(requests.exceptions.SSLError, requests.exceptions.ConnectionError) as e:
        if 'bad handshake' in str(e) or '10054' in str(e):
            continue
        else: 
             raise Exception(e)
    else:
        print(doi, ' URL OK!')         
        
    element = leaf.find_all('div', id = 'abstract-body')
    target = element[0].get_text()
    abstracts.append(target)
    
    element = leaf.find_all('h1')
    titles.append(element[0].get_text())
    
    element = leaf.find_all('li', class_ = 'authorname')
    for i in element:
        authors.append(i.get_text())
    
    print(doi, ' done!')
        
     
filename = open('JPEabstracts.txt', 'w',encoding='UTF-8')
for value in abstracts:
    filename.write(str(value))
filename.close()  # txt file
    
