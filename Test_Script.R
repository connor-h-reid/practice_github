#This is a test script

#There is no code here

1+2

3-9

#Ctrl-Shift-R : make a new section - quite

# Packages ----------------------------------------------------------------


#Hope it works

install.packages('remotes') # for installing packages from sources that aren't CRAN
library(remotes) # load the package

install_github("allisonhorst/palmerpenguins") #installing development version of dataset
library(palmerpenguins) # loading the package which contains dataset we will use


install.packages('tidyverse')
library(tidyverse) # loading tidyverse package for ggplot etc.



# Stuff -------------------------------------------------------------------

sessionInfo()


# Create data -------------------------------------------------------------

data(penguins,package="palmerpenguins")

#Make sure folders in project (e.g., "raw_data" are spelled correctly)
write.csv(penguins_raw,"raw_data/penguins_raw.csv",row.names=F)

write.csv(penguins,"data/penguins.csv",row.names=F)



# Load data ---------------------------------------------------------------

pen.data=read.csv("data/penguins.csv")

str(pen.data)
colnames(pen.data)
head(pen.data)
tail(pen.data)

?pairs
pairs(pen.data[,c(3:6,8)]) # pairwise correlation plot of numeric columns

hist(pen.data$body_mass_g)

boxplot(pen.data$body_mass_g~pen.data$species)


#make a pdf
pdf("wt_by_spp.pdf",
    width=7,height=5)

boxplot(pen.data$body_mass_g~pen.data$species,
        xlab="Species",ylab="Body Mass (g)")

dev.off()


# ggplot ------------------------------------------------------------------

pen_fig <- pen.data %>% # calling on the data; %>% = pipes; thing on the left goes into the thing on the right
  drop_na() %>%  # dropping "NAs" from the plot
  ggplot(aes(y = body_mass_g, x = sex, # aesthetic: y = body mass, x = sex
             colour = sex)) + # colour violin plots by sex
  facet_wrap(~species) + # each species will have it's own plot
  geom_violin(trim = FALSE, # violin plot, turn off trim the edges
              lwd = 1) + # make the lines thick
  theme_bw() + # black and white background theme
  theme(text = element_text(size = 12), # change the text size
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        strip.text = element_text(size=12),
        legend.position = "none") + # remove the legend
  labs(y = "Body Mass (g)", # specify labels on axes
       x = " ") +
  scale_colour_manual(values = c("black", "darkgrey"))

pen_fig

ggsave("pen_fig.jpeg", pen_fig, # save figure to output
       width = 7,
       height = 5)


# committing --------------------------------------------------------------

# to commit a bunch at the same time, ctrl+a in Git window, press spacebar


