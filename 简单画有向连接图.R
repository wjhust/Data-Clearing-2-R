library(igraph)
m=matrix(nrow=3,ncol=3)
m[1,1]=0
  m[1,2]=1
  m[1,3]=1
  m[2,1]=1
  m[2,2]=0
  m[2,3]=0
  m[3,1]=0
  m[3,2]=1
  m[3,3]=0
  m
  # 构造矩阵
  lab=c(1,2,3)
  #构造节点的标签名字
  object<-graph.adjacency(m,mode = "directed")
  # 邻接矩阵画图，mode指的是“有向”
 set.seed(1)
 #有无的图不同，标签位置会变，关系不变
  plot(object,vertex.label=lab)
  #作出有向连接图