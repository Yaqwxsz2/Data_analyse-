data = read.csv2("pole_emploi_bmo_2019_metier_secteur.csv", fileEncoding = "Latin1", check.names = F)
View(data)

#Reporting
library(DataExplorer)
create_report(data)

library(SmartEDA)
ExpReport(data, op_file = "smarteda.html")

library(dlookr)
diagnose_report(data)
library(ggraptR)

#ETUDES CARACTERES QUALI
#Metier
summary(data$`Mtier`)
metier = table(data$`Mtier`)
freq = round(prop.table(metier)*100,1)
pie(freq)# pas adapte au probleme
barplot(freq, col=rainbow(4))

#Secteur
summary(data$`Grand secteur`)
secteur = table(data$`Grand secteur`)
freq = round(prop.table(secteur)*100,1)
pie(freq) # nous constatons une distribution +/- egale des secteurs
barplot(freq, col=rainbow(4)) # ici nous voyons que les secteurs commerce et servies aux particuliers sont legerement plus representes

#ETUDES CARACTERES QUANTI
#Nombre de projet
nb_proj= (data$`Nombre de projets`)
table(nb_proj)
moyenne = mean(nb_proj)
summary(nb_proj)
plot(log(nb_proj), col="purple") 
hist(log(nb_proj),col=rainbow(4)) # ressemble loi normale
tab=table(nb_proj)
round(prop.table(tab),2)
ecart= sd(nb_proj)
ecart
boxplot(nb_proj) #au dela de 5000 valeurs aberantes

#Nombre de projets difficiles
nb_proj_dif= (data$`Nombre de projets difficiles`)
table(nb_proj_dif)
moyenne = mean(nb_proj_dif)
summary(nb_proj_dif)
plot(log(nb_proj_dif), col="purple") 
hist(log(nb_proj_dif),col=rainbow(4)) # loi binomiale
tab=table(nb_proj_dif)
round(prop.table(tab),2)
ecart= sd(nb_proj_dif)
ecart
boxplot(nb_proj_dif) # au dela de 2000 valeurs aberantes

#Nombre de projets saisonniers
nb_proj_sais= (data$`Nombre de projets saisonniers`)
table(nb_proj_sais)
moyenne = mean(nb_proj_sais)
summary(nb_proj_sais)
plot(log(nb_proj_sais), col="purple") 
hist(log(nb_proj_sais),col=rainbow(4)) # suit la loi de poisson
tab=table(nb_proj_sais)
round(prop.table(tab),2)
ecart= sd(nb_proj_sais)
ecart
boxplot(nb_proj_sais) #audela de 5000 valeurs aberrantes

# STATS DESCRIPTIVES A DEUX VARIABLES

model = lm(data$`Nombre de projets saisonniers`~ data$`Nombre de projets difficiles` + data$`Nombre de projets`+data$`Grand secteur`+data$`Mtier`)

cor.test(data$`Nombre de projets saisonniers`,data$`Nombre de projets difficiles`)
# cor > 0.7 il y a correlation
plot(log(data$`Nombre de projets saisonniers`,data$`Nombre de projets difficiles`))
abline(lm(data$`Nombre de projets saisonniers`,data$`Nombre de projets difficiles`), lwd=5, col="PURPLE")

cor.test(data$`Nombre de projets saisonniers`,data$`Nombre de projets`)
# cor > 0.7 il y a correlation
plot(log(data$`Nombre de projets saisonniers`,data$`Nombre de projets`))
abline(lm(data$`Nombre de projets saisonniers`,data$`Nombre de projets`), lwd=5, col="PURPLE")

#STATISTIQUES INFÉRENTIELLES
#Donner un intervalle de confiance de la proportion de 
#« Nombre de projets saisonniers» aux niveaux 95%.
conf_intervalle = t.test(data$`Nombre de projets saisonniers`, conf.level = 0.95)
conf_intervalle

#TEST DU KHI-DEUX :
#Tester l’indépendance des caractères qualitatifs 
#présents dans la base de données.
khi = chisq.test(table(data$`Mtier`,data$`Grand secteur`))
khi   #p val <5 donc ya 

#TEST ANOVA :
#Faire un Test d’indépendance ANOVA de deux caractères que vous aurez choisies
anova = aov(data$`Nombre de projets difficiles`~data$`Mtier`)
summary(anova)   
#Pr(>F) donc y a dependance entre le nombre de projets difficiles
#et le metier

#TEST DE NORMALITÉ :
#Identifier les variables quantitatives qui suivraient 
#une loi normale ou d’autres loi (poisson, exponentielle etc).

#TEST NOMBRE DE PROJETS
shapiro.test(data$`Nombre de projets`)
# p val < 0.05 donc 'nombre de projets' ne suit pas la loi normale
hist(log(data$`Nombre de projets`))
#d'apres cet histogramme, `Nombre de projets` semble suivre la loi

#TEST NOMBRE DE PROJETS DIFFICILES
shapiro.test(data$`Nombre de projets difficiles`)
#p val < 0.05 donc 'nombre de projets difficiles' ne suit pas la loi normale
hist(log(data$`Nombre de projets difficiles`))
#d'apres cet histogramme, `Nombre de projets difficiles` semble suivre la loi


#TEST NOMBRE DE PROJETS SAISONNIERS
shapiro.test(data$`Nombre de projets saisonniers`)
# p val < 0.05 donc 'nombre de projets saisonniers' ne suit pas la loi normale
hist(log(data$`Nombre de projets saisonniers`))
# d'apres cet histogramme,`Nombre de projets saisonniers`semble suivre loi de poisson
# test pour le verifier