n=100
nsim=1000
m=1
y=rep(0, nsim)
for(m in 1:nsim){
 x=rnorm(n=100,mean=10,sd=sqrt(2))
  y[m]=sum(x)/n
  m=m+1
 }
Mean=sum(y)/nsim
Bias=Mean-10
SD=sqrt(sum(y-Mean)^2/(nsim-1))
RMSE=sqrt(sum(y-10)^2/(nsim-1))
Mean
Bias
SD
RMSE


n=100
nsim=1000
mu0=10
m=1
CP=0
AL=0
for(m in 1:nsim){
  x=rnorm(n=100,mean=mu0,sd=sqrt(2))
  bar=sum(x)/n
  t0=sum((x-bar)^2)/(n-1)
  temp=sqrt(t0)*1.96/sqrt(n)
  if(bar-temp<=mu0 & mu0<=bar+temp)CP=CP+1
  AL=AL+2*temp
  m=m+1
}
bar
CP=CP/nsim
AL=AL/nsim
CP
AL

n=100
nsim=1000
mu0=10
m=1
T=rep(0, nsim)
for(m in 1:nsim){
  x=rnorm(n=100,mean=mu0,sd=sqrt(2))
  bar=sum(x)/n
  t0=sum((x-bar)^2)/(n-1)
  T[m]=sqrt(n)*(bar-mu0)/sqrt(t0)
  m=m+1
}
qqnorm(T)