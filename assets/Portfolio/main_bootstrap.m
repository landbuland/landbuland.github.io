function main_bootstrap()
%% import the data from R, "Portfolio" is the same dataset from R.
Portfolio=xlsread('Portfolio.xlsx')

%% generate one bootstrap sample and calculate the alpha.
index=randint(1,length(Portfolio),[1 length(Portfolio)]);
alpha = return_alpha(Portfolio,index) 

%% do bootstrap manually.
A=[]
B=1000
for i=1:B
A(i)=return_alpha(Portfolio,randint(1,length(Portfolio),[1 length(Portfolio)]));
end

mu = mean(A)
sd = std(A)

%% This is the function used for computing alpha.
    function alpha= return_alpha(data,index)
        x=data(index,1);
        y=data(index,2);
        c=cov(x,y)
        alpha=((var(y)-c(1,2))/(var(x)+var(y)-2*c(1,2)))
    end
end