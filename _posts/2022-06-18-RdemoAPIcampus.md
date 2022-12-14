---

layout: post
title: "R demo - Using Baidu API to identify the number of separate college campuses in China"
date:   2022-06-18 23:59:59
categories: Code_notebook

---





# R demo - Using Baidu API to identify the number of separate collegecampuses in China


In this note, I use R and Baidu Map API service to identify all separate
campuses of Chinese universities. First, we can find the namelist of
nationwide universities from the Ministry of Education
[website](http://m.moe.gov.cn/jyb_xxgk/s5743/s5744/A03/202206/t20220617_638352.html).

We can obtain the name of university from this namelist, as well as
their provinical level locations. Headlines of the sample are:

    ## # A tibble: 6 x 7
    ##      id name                   code leader         loc    type  remark
    ##   <dbl> <chr>                 <dbl> <chr>          <chr>  <chr> <chr> 
    ## 1     1 北京大学         4111010001 教育部         北京市 本科  ""    
    ## 2     2 中国人民大学     4111010002 教育部         北京市 本科  ""    
    ## 3     3 清华大学         4111010003 教育部         北京市 本科  ""    
    ## 4     4 北京交通大学     4111010004 教育部         北京市 本科  ""    
    ## 5     5 北京工业大学     4111010005 北京市         北京市 本科  ""    
    ## 6     6 北京航空航天大学 4111010006 工业和信息化部 北京市 本科  ""

Then, utilize the name and locaition information, we can find campuses
of each universities by requesting information from Baidu Map. The R
code is displays as follows:

    AK = "..." # Access key
    namelist <- data.frame(mysample$name)


```R
# loop, request through API
for (count in c(1:length(namelist))) {
  location <- county[count]
  #print(location)
  url<-paste("http://api.map.baidu.com/geocoding/v3/?address=",location,"&output=json&ak=",AK,sep="")
  url_string <- URLencode(url)
  # request 
  connect <- getURI(url_string)      
  # process json
  temp_geo <- fromJSON(connect)
  temp_lat<-temp_geo$result$location$lat
  temp_lng<-temp_geo$result$location$lng
  comprehens <- temp_geo$result$comprehension
  if (temp_geo$status==0){
    print(paste(location,"Done！"))
    # produce data frame
    baidu_geo  <-c(baidu_geo,temp_geo)
    content[count,1] <- county[count]
    content[count,2] <- temp_lng
    content[count,3] <- temp_lat
    content[count,4] <- comprehens
    wgs_content[count,c(1,2)] <- bd2wgs(temp_lat,temp_lng)
  }
  else {print(paste(location,"Error！"))}
}
```

Throgh baidu API service, we are able to construct a new dataset
containing the campus information of each campus like this:

    ## # A tibble: 6 x 8
    ##   school           campus            name2 address province city  district    nc
    ##   <chr>            <chr>             <chr> <chr>   <chr>    <chr> <chr>    <dbl>
    ## 1 三亚学院         三亚学院          "南…  三亚市… 海南省   三亚… 吉阳区       1
    ## 2 三峡大学         三峡大学          ""    湖北省… 湖北省   宜昌… 西陵区       1
    ## 3 三峡大学科技学院 三峡大学-科技学院 ""    湖北省… 湖北省   宜昌… 西陵区       1
    ## 4 三明学院         三明学院          "三…  福建省… 福建省   三明… 三元区       2
    ## 5 三明学院         三明学院          ""    福建省… 福建省   三明… 三元区       2
    ## 6 三江学院         三江学院          "东…  中水路… 江苏省   南京… 江宁区       4
