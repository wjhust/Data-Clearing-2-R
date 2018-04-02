library(igraph)
florence<-as.matrix(read.csv("~/firenze.csv"))
florence
marriage<-graph.adjacency(florence,mode="undirected",diag=FALSE)
#diag是指对角线是否加入计算，如果是FALSE，那么对角线将归0；
#??graph.adjacency
set.seed(1)
plot(marriage,layout=layout.fruchterman.reingold,vertex.label=V(marriage)$name,
     vertex.color="red",vertex.label.color="blue",vertex.frame.color=10,vertex.label.cex=1.5)
#参数解释： vertex是节点
#vertex.color="red" 是指节点背景圆的颜色；
# vertex.label.color="blue" 是指标签名字或者字母的颜色；
# vertex.frame.color=0是指节点的框架；
# vertex.label.cex=1.5是指标签字体的大小；
data.frame(V(marriage)$name,degree(marriage))
#统计各节点的度； 


V(marriage)$color <- 8
E(marriage)$color <- 8
#V为表示图中所有点的集合（点），E为边集（路径）
PtoA <- get.shortest.paths(marriage, from="Peruzzi", to="Acciaiuoli")
E(marriage, path=PtoA$vpath[[1]])$color <- "magenta"
V(marriage)[PtoA$vpath[[1]] ]$color <- "magenta"
#Peruzzi的最短路径中，边和点，画成紫色；
GtoS <- get.shortest.paths(marriage, from="Ginori", to="Strozzi")
E(marriage, path=GtoS$vpath[[1]])$color <- "green"
V(marriage)[ GtoS$vpath[[1]] ]$color <- "green"
V(marriage)[ "Medici" ]$color <- "cyan"
#Ginori的最短路径中，边和点画成绿色，
#经过Medici的路径画成灰色；
set.seed(1)
plot(marriage,  layout=layout.fruchterman.reingold, vertex.label=V(marriage)$name,vertex.label.color="black", vertex.frame.color=0, vertex.label.cex=1.5)

data.frame(V(marriage)$name, betweenness(marriage))
#统计另外的指标，中间性，有计算公式；
#结果分析：Medici度是Strozzi的1.5倍，中间性却是它的5倍多，说明整体连通性更好；


