library(dplyr)

# from http://r.789695.n4.nabble.com/Path-to-R-script-tp2196648p2196984.html
setwd(dirname(sys.frame(1)$ofile))

scarf.rows <- read.table("rows.txt",
                   header = TRUE)

# http://stackoverflow.com/a/26609390
scarf.rows <- scarf.rows %>% 
  mutate(total.cumsum = cumsum(count)) %>% 
  group_by(color) %>% 
  mutate(color.cumsum = cumsum(count))

# http://stackoverflow.com/a/23758886
scarf.colors <- scarf.rows %>%
  group_by(color) %>% 
  filter(color.cumsum == max(color.cumsum)) %>% 
  select(color, rows=color.cumsum)

# all of the following is an approximation
# yarn is Wool of the Andes Sport, 137 yds/50 grams
# 
# based on camel:
rows.per.skein <- 134

# fwiw
scarf.colors$skeins <- scarf.colors$rows / rows.per.skein
total.skeins <- sum(scarf.colors$skeins)

# what it says on the label:
yards.per.skein <- 137
# what was left after finishing the first skein of camel:
extra.inches <- 30
yarn.inches.per.row <- (yards.per.skein * 36 - extra.inches) / rows.per.skein

half.length <- 34.5
scarf.length.per.row <- 34.5 / 415

