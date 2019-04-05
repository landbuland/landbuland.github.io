clear
Portfolio=xlsread('Portfolio.xlsx')
index=randint(1,length(Portfolio),[1 length(Portfolio)]);


A=[]
B=1000
for i=1:B
    index=randint(1,length(Portfolio),[1 length(Portfolio)]);
    x=data(index,1);
    y=data(index,2);
    c=cov(x,y)
    alpha=((var(y)-c(1,2))/(var(x)+var(y)-2*c(1,2)))
    A(i)=alpha;
end

mu = mean(A)
sd = std(A)
