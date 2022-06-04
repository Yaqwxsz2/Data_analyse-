data = read.csv2("worldHappinessReport.csv",sep=",")
View(data)
library(dplyr)

data$Country = factor(data$Country)
data$Region = factor(data$Region)
data$SocialSupport = as.numeric((data$SocialSupport))
data$Freedom = as.numeric(data$Freedom)
data$Generosity= as.numeric(data$Generosity)
data$Corruption = as.numeric(data$Corruption)
data$PositiveAffect= as.numeric(data$PositiveAffect)
data$ConfidenceInGovernment = as.numeric(data$ConfidenceInGovernment)

#A- REPORTING








#B- STATS UNIVARIE
#GDP = Gross Domestic Product (PIB)

gdp = as.numeric(data$GDP)  #Parce que les infos de GDP sont en chaine de caracteres
                            #j'ai du convertir en numerique pour pouvoir effectuer des operations
table(gdp)
moyenne = mean(gdp)
moyenne
t.test(gdp, conf.level = 0.90)  #intervalle de confiance 90%
summary(gdp)
plot(gdp, col="purple")         #pas adapte a notre pb
hist(gdp,col=rainbow(4))        #ne suit pas la loi normale 
tab=table(gdp)
round(prop.table(tab),2)
ecart= sd(gdp)
ecart
boxplot(gdp)    # je ne vois pas d'aberration

#moy des gdp par region
data%>%group_by(data$Region)%>%summarise(mean(gdp))
boxplot((gdp~data$Region))


#C- STATS GENERALES ET REFERENTIELLES
#ETUDE DE VAR CATEGORIELLES : 
#Country
summary(data$Country)
country = table(data$Country)
freq = round(prop.table(country)*100,1)
pie(freq)
barplot(freq, col=rainbow(4))

#Region
region = table(data$Region)
freq = round(prop.table(region)*100,1)
pie(freq)
barplot(freq, col=rainbow(4))

#ETUDE DE VAR QUANTITATIVES
#Corruption
corrupt= as.numeric(data$Corruption)
table(corrupt)
moyenne = mean(corrupt)
summary(corrupt)
plot(corrupt, col="purple") 
hist(corrupt,col=rainbow(4))
tab=table(corrupt)
round(prop.table(tab),2)
ecart= sd(corrupt)
ecart
boxplot(corrupt)

#Health
health = as.numeric(data$Health)
table(health)
moyenne = mean(health)
summary(health)
plot(health, col="purple") 
hist(health,col=rainbow(4))
tab=table(health)
round(prop.table(tab),2)
ecart= sd(health)
ecart
boxplot(health)

#ASSOCIATION ENTRE VAR CATEGORIELLES
#KHI 2 : 
khi = chisq.test(table(data$Country, data$Region)
khi #p value <5 donc ya dependance 
barplot(data$Country,data$Region)


#ASSOCIATION ENTRE VAR QUANTITATIVES
#GDP et Happiness
cor.test(as.numeric(data$GDP),as.numeric(data$Happiness)) # cor = 0.7
plot(data$GDP , data$Happiness)
abline(lm(data$GDP~data$Happiness), lwd=5, col="RED")

#ASSOCIATION ENTRE VAR CATEGORIELLES ET QUANTI
attach(data)                                                #permet d'ecrire les noms des val tel que dans le tableau 
barplot(tapply(gdp, country, "mean"), col =rainbow(4))        #subjectif : manque de diff significative
boxplot(gdp~country,col =rainbow(4))                          #subjectif : diff significative 
#ANOVA - test pour etre objectif
anova = aov(gdp~country)
summary(anova) #Pr(>F)=pvalue<5% donc dependence


#D- MODELE DE REGRESSION





#E- LOI DE PROBABILTE
hist(as.numeric(data$Happiness),col=rainbow(4)) #on retrouve +/- la loi normale
     
barplot(as.numeric(data$Happiness),col=rainbow(4))   # pas adapte

library(e1071)
skewness(as.numeric(data$Happiness))    # skew = -0.06702301 = les donnees sont +/- symetriques
kurtosis(as.numeric(data$Happiness))    # kurto = -0.6461513 la distribution est +/- correcte
#F- MACHINE LEARNING