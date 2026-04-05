library(ggplot2)
library(tidyverse)
library(viridis)

library(readr)
library(gridExtra)
library(cowplot)



#Arbeitsbelastung#############


df<- tribble(
  ~Sex, ~Sektor, ~outcome, ~Belastung,
  #--|--|----
  "Männer", "Niedriglohn", 33.1, "Körperlich",
  "Männer", "Mittlerer Lohn", 29.5, "Körperlich",
  "Männer", "Hoher Lohn", 9.9, "Körperlich",
  "Männer", "Niedriglohn", 37.1, "Psychosozial",
  "Männer", "Mittlerer Lohn", 19.3, "Psychosozial",
  "Männer", "Hoher Lohn", 11.1, "Psychosozial",
  "Frauen", "Niedriglohn", 3.5, "Körperlich",
  "Frauen", "Mittlerer Lohn", 2.3, "Körperlich",
  "Frauen", "Hoher Lohn", 1.2, "Körperlich",
  "Frauen", "Niedriglohn", 42.5, "Psychosozial",
  "Frauen", "Mittlerer Lohn", 23.4, "Psychosozial",
  "Frauen", "Hoher Lohn", 12.4, "Psychosozial"
)

df$Sektor <- factor(df$Sektor,
                    levels = c("Niedriglohn", "Mittlerer Lohn", "Hoher Lohn"),
                    labels = c("Niedriglohn", "Mittlerer Lohn", "Hoher Lohn")) 

df$Belastung <- factor(df$Belastung,
                    levels = c("Körperlich", "Psychosozial"),
                    labels = c("Körperlich", "Psychosozial"))


ggplot(data=df, aes(x=Sektor, y=outcome, fill = Belastung)) +
  geom_bar(stat="identity", position = "dodge2")+
  geom_text(
    aes(label = outcome),
    position = position_dodge(0.9),
    vjust = 1,
    color = "white",
    size = 5)+
  facet_wrap(~ Sex)+
  ylab("Prozent")+
  theme_minimal(base_size = 14)+
  scale_fill_manual(values=c("#7AA6DC","#003C67"))+
  labs(caption = "Source: Datenreport 2018")+
  theme(legend.position="bottom")



#EInkommensplot#############



allbus_einkommen <- read_csv("C:/Users/gu99mywo/Dropbox/Lehre/Bildung/Vorlesung Bildung EF/SoSe2021/Folien/05_Soziale_HK_F/allbus_einkommen.csv")
head(allbus_einkommen)


p1 <- ggplot(allbus_einkommen, aes(einkommen)) +
  geom_histogram()+
  xlab("Einkommen in Deutschland")+
  ylab("")+
  labs(caption = "Data: Allbus 2010")+
  theme_minimal()

p2<- ggplot(allbus_einkommen, aes(einkommen)) +
  geom_boxplot()+
  theme_void()
  

plot_grid(p2, p1, align = "v", nrow = 2, rel_heights = c(1/6, 5/6))





#Titanic
library(ggplot2)
library(titanic)
library(broom)
library(tidyverse)

train_df<- titanic::titanic_train

train_df$Survived <- factor(train_df$Survived, 
                            levels = c(0, 1),
                            labels = c("Not survived", "Survived")) 

train_df$Pclass <- factor(train_df$Pclass, 
                          levels = c(1, 2 , 3),
                          labels = c("First class", "Second class", "Third class")) 

glm_fit <- glm(Survived ~ Sex + Age + Pclass , family = binomial(link = 'logit'), data = train_df)


ggplot(train_df, aes(x= Sex, fill = Survived)) + 
  geom_bar()+
  geom_text(stat='count', aes(label=..count..), vjust=-1,
            position = position_stack(vjust = 0), size = 6)+
  theme_bw(base_size = 18)+
  ylab("Count")+
  theme(legend.position="bottom")


#Plots
set.seed(2)
y <- rep(c(0,1), 500)
x <- 10 + rnorm(250, 3, 3)+ rnorm(250, 10, 3)*y

data <- data.frame(x, y) %>%
  as.tibble

p1 <- ggplot(data, aes(x = x, y = y)) + 
  geom_point(color = "gray")+
  geom_smooth(method='lm', formula= y~x, colour = "#008080")+
  theme_minimal(base_size = 14)+
  ggtitle("Linear")


p2<- ggplot(data, aes(x= x, y = y)) + 
  geom_point(color = "gray")+
  geom_smooth(method = "glm", 
              method.args = list(family = "binomial"), colour = "#008080")+
  theme_minimal(base_size = 14)+
  ggtitle("Logit")


plot_grid(p1, p2, align = "h", nrow = 1, rel_heights = c(1/2, 1/2))



