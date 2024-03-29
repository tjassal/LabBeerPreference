# Title:  LabBeerPrefs.R
# 13 nov 2020
# Author: Tim Assal
# script to create & visualize our beer preferences
# also, we'll use this as part of the example repo on github (everyone will pull it down and add their beer prefs)

#load the packages you'll need
#REMEMBER to install them first if you haven't used them before
library(tidyverse)
library(wesanderson) #load the Wes Anderson Color package
#I know the guy (Karthik) who create this package. He's a strange dude; but I like Wes Anderson movies. 
#nick edit: maybe we'll have to have a lab poll for ranking Wes Anderson movies as well? Weekly GitHub homework!

##########
# 1. Rank your beer prefence: #7 is your favorite, #1 is your least favorite
##########
Beer.Type<- c('Pilsner','IPA','Porter', 'Stout', 'Wild/Sour', 'Pale', 'Wheat')

#add your name and beer preferences here:
Tim <- c(5, 6, 3, 1, 2, 7, 4)
#Lab.mascot <- c(1, 2, 4, 5, 6, 7, 3)
Nick <- c(2, 1, 7, 6, 5, 4, 3)
Hana<-c(2, 1, 3, 4, 7, 5, 6)
Mainul<-c(1, 3, 6, 5, 4, 2, 7)
Michelle <- c(6, 1, 3, 7, 2, 4, 5)

###########
###########

###########
# 2. Add your name in the line of code below
#compile into a data frame
#df<- data.frame(Beer.Type, Tim, Nick, Hana, Mainul, Michelle)
df<- data.frame(Beer.Type, Tim, Nick, Hana, Mainul, Michelle) 
          
###########
###########

###########
# 3. Run the rest of the code - the code SHOULD be robust to handle the additional names
#reshape the dataframe for the plot
df2 <-df%>%
  gather(key = "Lab.Member", value="Beer.Preference",-Beer.Type) 
head(df2)

#create plot 1
p1<-ggplot(data=df2, aes(Beer.Type, Beer.Preference, fill = Lab.Member)) +
  geom_bar(position = "dodge", stat = "identity", alpha=1) +
  scale_fill_manual(values=wes_palette("Zissou1"))+ #use the Zissou theme
  ylab("Least Favorite     <-------------   Beer Preference   ------------>      Favorite") + xlab("Beer Type") + 
  theme_bw() +
  theme(axis.text.y=element_blank())+ #remove y-axis tick marks
  guides(fill=guide_legend(title="Lab Member")) #rename legend

plot(p1)
### Nutz - we get an error if there are more than five people
#b/c the Zissou1 theme only has five colors

#instead of doing anything fancy; let's create a new palette using two 
#of Wes' 5-color palettes
wes.combo<-c(wes_palette("Zissou1"), wes_palette("Darjeeling2"))

#create plot 1 again
p1<-ggplot(data=df2, aes(Beer.Type, Beer.Preference, fill = Lab.Member)) +
  geom_bar(position = "dodge", stat = "identity", alpha=1) +
  #scale_fill_manual(values=wes_palette("Zissou1"))+ #use the Zissou theme
  scale_fill_manual(values=wes.combo)+ #use the Zissou theme
  ylab("Least Favorite     <-------------   Beer Preference   ------------>      Favorite") + xlab("Beer Type") + 
  theme_bw() +
  theme(axis.text.y=element_blank())+ #remove y-axis tick marks
  guides(fill=guide_legend(title="Lab Member")) #rename legend

plot(p1)

#looks good

#save updated figure - not done yet! 
ggsave("Figures/LabBeerPrefs.jpg", p1, width = 18.5, height=14, units=c("cm"), dpi = 300)
###########
###########

###########
# 4. Take it a step further
## take it a step further and add the Duff beer image to top right corner of your graph
#install & load additional libraries
library(cowplot)
library(magick)


#run the code below
ggdraw() +
  draw_plot(p1)+
  draw_image("SourceData/bld-logo.jpg",  x = 0.385, y = 0.4, scale = .2) 
  #draw_image("SourceData/Duff_beer.jpg",  x = 0.385, y = -0.3, scale = .2) 

ggsave("Figures/LabBeerPrefsLogo.jpg", width = 18.5, height=14, units=c("cm"), dpi = 300)
###########
###########

#!!!!!!!!!!!
# Check your figures directory; it should have updated your name to the figure list
# Now push the repo back up to github
# !!!!!!!!!!
