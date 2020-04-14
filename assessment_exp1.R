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
  
  rt1<-subset(rt1,RT>=minRT1 & RT<=maxRT1  )
  rt2<-subset(rt2,RT>=minRT2 & RT<=maxRT2 )
  team<-subset(team,RT>=minteam & RT<=maxteam  )
  
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

#assessment function
# To plot a better figure, we output the results from R and use Matlab to draw A(t).
# If you want to use R plot, please amend 'plotAt=F' to 'plotAt=T'.
a.and.cf<-assessmentGroup(data,stopping.rule = Condition,correct=TRUE,fast=TRUE, detection=TRUE, plotAt=F)
tmp<-rbind(matrix(a.and.cf$time,nrow = 1),a.and.cf$At.fn)
write.csv(tmp, "Exp1 and cf.csv",na = "NaN")
rm(tmp)

a.and.cs<-assessmentGroup(data,stopping.rule = Condition,correct=TRUE,fast=FALSE, detection=TRUE, plotAt=F)
tmp<-rbind(matrix(a.and.cs$time,nrow = 1),a.and.cs$At.fn)
write.csv(tmp, "Exp1 and cs.csv",na = "NaN")
rm(tmp)

a.and.if<-assessmentGroup(data,stopping.rule = Condition,correct=FALSE,fast=TRUE, detection=TRUE, plotAt=F)
tmp<-rbind(matrix(a.and.if$time,nrow = 1),a.and.if$At.fn)
write.csv(tmp, "Exp1 and if.csv",na = "NaN")
rm(tmp)

a.and.is<-assessmentGroup(data,stopping.rule = Condition,correct=FALSE,fast=FALSE, detection=TRUE, plotAt=F)
tmp<-rbind(matrix(a.and.is$time,nrow = 1),a.and.is$At.fn)
write.csv(tmp, "Exp1 and is.csv",na = "NaN")
rm(tmp)
