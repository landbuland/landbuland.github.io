#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 09:57:43 2021

@author: zihan
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
