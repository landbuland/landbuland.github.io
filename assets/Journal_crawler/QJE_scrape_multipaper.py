# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 15:56:05 2021

@author: Zihan
"""
import numpy as np
import requests
from bs4 import BeautifulSoup as soup

base = 'https://academic.oup.com/qje/issue/'

url_list = []
for vol in range(132,137) :
    for issue in range(1,5):
        url = base + str(vol) + '/' + str(issue)
        url_list.append(url)

header = {
    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
}

authors = []
titles = []
abstracts_url = []

for url in url_list:
    root = requests.get(url,headers = header)        
    leaf = soup(root.text,'lxml')
    author_element = leaf.find_all('span', class_ = 'wi-fullname brand-fg')
    for au in author_element:
        author = soup(str(au),'lxml')
        author = author.find_all('a')[0].get_text()
        authors.append(author)
        
    title_element = leaf.find_all('h5', class_ = 'customLink item-title')
    for ti in title_element:
        target = soup(str(ti),'lxml')
        title = target.find_all('a')[0].get_text()
        titles.append(title)
        artweb = target.find_all('a')
        abstracts_url.append(artweb[0]['href'])

abstracts = []       
for url in abstracts_url:
    try:
        link = 'https://academic.oup.com' + url            
        root = requests.get(link, headers = header)
        leaf = soup(root.text,'lxml')
        abs_elements = leaf.find_all('section', class_ = 'abstract')
        abs_elements = str(abs_elements[0])
        leaf2 = soup(abs_elements,'lxml')
        abst = leaf2.find_all('p')[0].get_text()
        abstracts.append(abst)
        
    except IndexError:
        print(url + "No abstract scraped!")
        
    else:
        print(url+ ' done!')

