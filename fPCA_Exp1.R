options(java.parameters = "- Xmx4096m")

require(rJava)
require(sft)
require(xlsx)

ss<-letters
getwd()

data<-data.frame()
for (index in 1:7){
  
  # load data
  solo<-read.xlsx('exp1 noncollaborate.xlsx',index,colIndex = c(2:6))
  team<-read.xlsx('exp1 collaborate.xlsx',index,colIndex = c(2:6))
  
  #seperate
  rt1<-subset(solo,Channel1==1)
  rt2<-subset(solo,Channel2==1)
  
  #trumcate 2.5%
  maxRT1<-quantile(rt1$RT,0.975)
  maxRT2<-quantile(rt2$RT,0.975)
  maxteam<-quantile(team$RT,0.975)
  minRT1<-quantile(rt1$RT,0.025)
  minRT2<-quantile(rt2$RT,0.025)
  minteam<-quantile(team$RT,0.025)
  
  rt1<-subset(rt1,RT>=minRT1 & RT<=maxRT1)
  rt2<-subset(rt2,RT>=minRT2 & RT<=maxRT2)
  team<-subset(team,RT>=minteam & RT<=maxteam)
  
  #build inputdata
  rt1$Subject<-ss[index]
  rt1$Condition<-'AND'
  
  rt2$Subject<-ss[index]
  rt2$Condition<-'AND'
  
  team$Subject<-ss[index]
  team$Condition<-'AND'
  
  tmp<-rbind(rt1,rt2,team)
  data<-rbind(data,tmp)
  
  rm(rt1,rt2,team,solo,tmp)
}

Condition<-"AND"

#fPCA (assessment function) 
a.and.cf<-fPCAassessment(data,2,stopping.rule = Condition,correct=TRUE,fast=TRUE, detection=TRUE,register=c("median"), plotPCs=T)
a.and.cs<-fPCAassessment(data,3,stopping.rule = Condition,correct=TRUE,fast=F, detection=TRUE,register=c("median"), plotPCs=T)
a.and.if<-fPCAassessment(data,2,stopping.rule = Condition,correct=F,fast=TRUE, detection=TRUE,register=c("median"), plotPCs=T)
a.and.is<-fPCAassessment(data,2,stopping.rule = Condition,correct=F,fast=F, detection=TRUE,register=c("median"), plotPCs=T)
sink('fPCA_At_cf_Exp1.txt')
a.and.cf
sink()

sink('fPCA_At_cs_Exp1.txt')
a.and.cs
sink()

sink('fPCA_At_if_Exp1.txt')
a.and.if
sink()

sink('fPCA_At_is_Exp1.txt')
a.and.is
sink()

Cdata<-subset(data,Correct==1)
Ct<-fPCAcapacity(Cdata,2,stopping.rule = Condition,register=c("median"), plotPCs=T)
sink('fPCA_Ct_Exp1.txt')
Ct
sink()