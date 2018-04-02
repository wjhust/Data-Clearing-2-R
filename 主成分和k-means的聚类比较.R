library(cluster)	## needed for cluster analysis

states=c("AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
         "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT",
         "VA","WA","WV","WI","WY")
states
# 美国50个州名字
raw <- read.csv("~/unempstates.csv")
raw[1:3,]

## transpose so that we have 50 rows (states) and 416 columns 
rawt=matrix(nrow=50,ncol=416)
#50个州，416列每月的观测数据
rawt=t(raw) 
rawt[1:3,]
# 转置使得州变成行，描述失业的指标变成列；

pcaunemp <- prcomp(rawt,scale=FALSE)
pcaunemp
#主成分分析,scale已经为标准化
plot(pcaunemp, main="")
mtext(side=1,"Unemployment: 50 states",line=1,font=2)
#画图以及书写图例：根据图示前两三个基本可以解释大部分变异
#主成分的pcaunemp结果包括：标准差standard deviation和rotation转动结果（主成分）
pcaunemp$rotation[,1]
pcaunemp$rotation[1:10,1]   ## just the first 10 values

ave=dim(416)
for (j in 1:416) {
  ave[j]=mean(rawt[,j])
}
#计算平均失业率
par(mfrow=c(1,2))
plot(-pcaunemp$rotation[,1])  ## plot negative loadings for first principal comp
#根据pcaunemp$rotation[,1]的命令，得到结果是负值，需要变成正值
## plot monthly averages of unemployment rates
plot(ave,type="l",ylim=c(3,10),xlab="month",ylab="ave unemployment rate") 
abs(cor(ave,pcaunemp$rotation[,1]))
#abs取绝对值，得到平均失业率

pcaunemp$rotation[,2]
pcaunemp$rotation[,3]

## below we obtain the scores of the principal components
## the first 2-3 principal components do a good job
unemppc <- predict(pcaunemp)
unemppc	
#得到主成分的权重后，乘以原始变量的值，即得到主成分的得分
## below we construct a scatter plot of the first two princ components
## we assess whether an informal clustering on the first two principal components
## would have lead to a similar clustering than the clustering results of the 
## k-means clustering approach applied on all 416 components 
## the graph indicates that it does

#从主成分的图示看出前两个主成分基本可以概括变异方差（聚类），现在和k-means进行比较
set.seed(1)
grpunemp3 <- kmeans(rawt,centers=3,nstart=10)
par(mfrow=c(1,1))
plot(unemppc[,1:2],type="n")
text(x=unemppc[,1],y=unemppc[,2],labels=states,col=rainbow(7)[grpunemp3$cluster])
#k均值聚类分了3类，，大部分基本在前两类中；实际从图示可以看出前2-3类可以概括大部分
##plot(pcaunemp, main="")
##plot(unemppc[,1:2],type="n")