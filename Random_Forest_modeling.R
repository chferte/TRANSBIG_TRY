# Charles Ferté
#

###
require(Biobase)
require(randomForest)
require(breastCancerTRANSBIG)

###
data(transbig)
transbig@phenoData
EXP <- exprs(transbig)
CLIN <- phenoData(transbig)

# separtae the dataset into a TS and a VS
set.seed(070912)
randVec <- rbinom(dim(transbig)[2],size=1, prob=.5)
T_EXP <- EXP[,randVec==0]
V_EXP <- EXP[,randVec==1]

T_CLIN <- CLIN$er[randVec==0]
V_CLIN <- CLIN$er[randVec==1]

## model the ER status (binary) using RandomForest using T_EXP
fit <- randomForest(x=t(T_EXP),y=factor(T_CLIN),ntree=200, do.trace=10)

## aapply the fit on the V_EXP
Validation_Score_Hat <- predict(fit,t(V_EXP),type="prob")

# plot a ROC curve to asses the response
require(ROCR)
erPred <- prediction(as.numeric(Validation_Score_Hat[,2]),as.numeric(V_CLIN))
erPerf <- performance(prediction.obj=erPred,"tpr","fpr")
erAUC <- performance(prediction.obj=erPred,"auc")
plot(erPerf, col=rainbow(10))
text(x=.7,y=.4,labels=paste("AUC=",erAUC@y.values))






