#charles Ferté


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

## model the ER status (binary) using RandomForest
fit <- randomForest(x=t(T_EXP),y=T_CLIN,ntree=200, do.trace=10)






