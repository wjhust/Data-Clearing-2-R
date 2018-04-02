x1<-c(82.9,88.0,99.9,15.3,117.7,131,148.2,161.8,174.2,184.7)
length(x1)
x2<-c(92,93,96,94,100,101,105,112,112,112)
length(x2)
x3<-c(17,21.3,25.1,29,34,40,44,49,51,53)
length(x3)
x4<-c(94,96,97,97,100,101,104,109,111,111)
length(x4)
y<-c(8.4,9.6,10.4,11.4,12.2,14.2,15.8,17.9,19.6,20.8)
length(y)
df<-data.frame(x1,x2,x3,x4,y)
df

a<-princomp(~x1+x2+x3+x4,data=df,cor=T)
summary(a,loadings = TRUE)
#去掉第三，四成分
#主成分回归
pre<-predict(a)
pre
df$z1<-pre[,1]
df$z2<-pre[,2]
fm<-lm(y~z1+z2,data=df)
summary(fm)
beta<-coef(fm); A<-loadings(a)
x.bar<-a$center; x.sd<-a$scale
coef<-(beta[2]*A[,1]+ beta[3]*A[,2])/x.sd
beta0 <- beta[1]- sum(x.bar * coef)
c(beta0, coef)

