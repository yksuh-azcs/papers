setwd("I:\\My Documents\\research\\a causal model\\conf_data")

newVarModel <- read.table("conf010817.txt",
                   header=TRUE,
                   sep="\t"         # use "\t" for tab-delimited files
)



# combined <- merge(mainModel, newVars, by=c("DBMS", "RUNID", "QUERYNUM"))

# save(combined,file="dataC.Rda")

newVarModel$int_si_op<- newVarModel$sec_idx*newVarModel$opCt
newVarModel$int_si_nf<- newVarModel$sec_idx*newVarModel$NUMFROM
newVarModel$int_si_na<- newVarModel$sec_idx*newVarModel$NumAgg
newVarModel$int_si_pp<- newVarModel$sec_idx*newVarModel$pk_pr
newVarModel$int_si_sp<- newVarModel$sec_idx*newVarModel$sq_pr

# Transform Subopt 
newVarModel$log_SUBOPT = log10(1 + newVarModel$SUBOPT)



# excluding "PK_NoJoin" since not populated for smaller set
woDBMS <- c("opCt", "NUMFROM", "NumAgg", "pk_pr", "sq_pr", "CEPS", "num_repeats", "NumDiscontOperators", "log_SUBOPT", "sec_idx_pr", "skew")
# woDBMS <- c("queryId", "querynumber", "opCt", "NUMFROM", "CEPS", "NUMSELFJOIN", "CtDbOp", "SUBOPT", "runid", "NumDiscontOperators", "NumAgg", "PK_NoGroupBy", "PK_TwoSided", "PK_InGroupBy", "PK_InOnesideJoin", "PK_NotInGroupBy", "PK_NotInJoin", "pk_pr", "num_repeats", "sec_idx_pr", "sq_pr")
newVarModel[woDBMS] 


# get means for variables in data frame newVars
# excluding missing values 
# sapply(newVars[woDBMS], mean, na.rm=TRUE)

# Set no of digits for output
options(digits=2)

# Correlations/covariances among numeric variables in 
# data frame newVars. Use listwise deletion of missing data. 
cor(newVarModel[woDBMS] , use="pairwise.complete.obs", method="pearson") 
# cov(newVars[woDBMS], use="all.obs")

# Correlations with significance levels
# install Hmisc
install.packages("Hmisc")

library(Hmisc)

#newVarModel is a data frame --> so convert to matrix
rcorr(as.matrix(newVarModel[woDBMS]), type="pearson")

inter <- c("int_si_op", "int_si_nf", "int_si_na", "int_si_pp", "pk_pr", "int_si_sp", "CEPS", "num_repeats", "NumDiscontOperators", "sec_idx_pr")

rcorr(as.matrix(newVarModel[inter]), type="pearson")

fit_subopt <- lm(log_SUBOPT~ NumDiscontOperators + num_repeats + CEPS + pk_pr + opCt + NUMFROM , data=newVarModel)
summary(fit_subopt) # show results

# adding skew
fit_subopt2 <- lm(log_SUBOPT~ NumDiscontOperators + num_repeats + CEPS + pk_pr + opCt + NUMFROM + skew, data=newVarModel)
summary(fit_subopt2) # show results



fit_NumRepeats <- lm(num_repeats ~ opCt + NUMFROM + NumAgg + pk_pr + sq_pr + int_si_op + int_si_nf + int_si_na + int_si_pp + int_si_sp, data=newVarModel)
fit_CEPS <- lm(CEPS ~ opCt + NUMFROM + NumAgg + pk_pr + sq_pr + int_si_op + int_si_nf + int_si_na + int_si_pp + int_si_sp, data=newVarModel)
fit_NumDisconOp <- lm(NumDiscontOperators ~ opCt + NUMFROM + NumAgg + pk_pr + sq_pr + int_si_op + int_si_nf + int_si_na + int_si_pp + int_si_sp, data=newVarModel)

summary(fit_NumRepeats) # show results
summary(fit_CEPS) # show results
summary(fit_NumDisconOp) # show results






# From http://www.statmethods.net/stats/regression.html 
coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(fit) # regression diagnostics

# diagnostic plots 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit)

# Old code
# newVars <- read.table("subopt_expl_new_var.txt",
                   header=TRUE,
                   sep="\t"         # use "\t" for tab-delimited files
)

# mainModel <- read.table("subopt_expl_new_qatc.txt",
                   header=TRUE,
                   sep="\t"         # use "\t" for tab-delimited files
)
