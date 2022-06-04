
file=choose.files()

data=read.csv2(file, sep=",")  #essayez d abord read.csv
View(data)

head(data)

str(data)

#as.factor
#as.numeric
# modifions les caracteres numeric
summary(data)
data$price=as.numeric(data$price)
data$carat=as.numeric(data$carat)
data$x=as.numeric(data$x)
data$y=as.numeric(data$y)
data$z=as.numeric(data$z)
data$depth=as.numeric(data$depth)
data$table=as.numeric(data$table)

#as.factor
# modifions les caracteres qualitative
data$color=factor(data$color)
data$cut=factor(data$cut)
data$clarity=factor(data$clarity)


summary(data)


str(data)  #que des numeric et factor: parfait!!


#1.Étudiez les variables catégorielles (cut, color par exemple) : fréquences, proportions, graphiques.

attach(data)
summary(data$cut)
summary(cut)  #avec attach

x=table(cut)
x
#frequences ou proportions
freq=round(prop.table(x)*100,1)
freq
pie(freq, col=rainbow(6))
barplot(freq, col=rainbow(6))

boxplot(price~cut, col=rainbow(6))

library(dplyr)

data%>%group_by(cut)%>%
  summarise(mean(price))
data%>%group_by(cut)%>%
  summarise(sum(price))










#2. Etudier deux variables quantitatives (carat et prix) : statistiques descriptives, graphiques.
#price

summary(price)

sd(price)/mean(price)*100   #PRIX DISPERSés


boxplot(price)
min(boxplot(price)$out)
#a partir de 11800 euros, les prix sont aberrantes


plot(carat, price)


#3.Créer une variable VOLUME et 
#supprimer les variables depth, x,y, z, table et justifiez ces suppressions
library(dplyr)

#creer volume
data=data%>%mutate(volume=x*y*z)
View(data)
#supprimer x y z depth table
data=data%>%select(-c(x,y,z, depth, table))
View(data)




#POUR LES QUESTIONS SUIVANTES : FAITES AU MOINS UN GRAPHE avant de répondre !
#  4.Étudier les associations entre 2 variables 
#catégorielles que vous aurez choisies.

tab=table(data$color, data$cut)
tab
barplot(tab, col=rainbow(5))

#test de dependance
t.test(tab)
chisq.test(tab)
#pvalue<5% donc il y a dependance




#GGPLOT

#5.Étudier les associations entre une quantitative et 
#une variable catégorielle que vous aurez choisies

#pareille 7.Effectuez une ANOVA sur deux variables.
boxplot(price~cut, col=rainbow(6))
summary(aov(price~cut))
#Pr(>F)=pvalue<5% donc dependence

#6.Réalisez des tests sur deux variables 
#quantitatives.
par(mfrow=c(2,3))  #pour faire deux graphes
hist(price, col=rainbow(6))
boxplot(price, col=rainbow(6))
hist(carat, col=rainbow(6))
boxplot(carat, col=rainbow(6))
plot(carat,price)
abline(lm(price~carat)$coefficients, lwd=5, col="RED")
attach(data)

plot(volume,price)
abline(lm(price~volume)$coefficients, lwd=5, col="RED")

lm(price~carat+volume)  #LINEAR MODEL /LM

data%>%arrange(price)%>%tail(10)


quant=data$price
categ=data$cut

par(mfrow=c(2,4))  #pour faire deux graphes
barplot(table(categ), col=rainbow(6))
pie(table(categ), col=rainbow(6))
boxplot(quant, col=rainbow(6))
hist(quant, col=rainbow(6))
boxplot(quant~categ, col=rainbow(6))
plot(quant, col=rainbow(6))

hist(price, col=rainbow(6))

hist(x, col=rainbow(6))


cor.test(price, carat)
