library(jsonlite)
business = stream_in(file("business.json"),)
business_flat = flatten(business)

library(tibble)
business_tibble = data.frame(business_flat)
business_tibble = business_tibble$business_flat
business_tibble = data.frame(business_tibble)

library(funModeling)
library(tidyverse)
inta = data_integrity(business_tibble)
inta = inta$results$vars_cat_with_NA
inta = inta %>% filter(p_na>0.3)

business_tibble = business_tibble %>% select(-c(inta$variable))
business_tibble = business_tibble %>% drop_na()
business_tibble = business_tibble %>% filter(review_count>=100)

saveRDS(business, file = "business.rds")


user = stream_in(file("user.json"),)
user = select(user,-friends)
saveRDS(user, file = "user.rds")










saveRDS(business, file = "business.rds")
tip = stream_in(file("tip.json"))
saveRDS(tip, file = "tip.rds")

library(RSQLite)
yelp_data = dbConnect(SQLite(),"yelp.sqlite")
dbWriteTable(yelp_data,"business",business)
dbWriteTable(yelp_data,"tip",tip)

library(tidyverse)
target.city = business %>% group_by(city) %>% summarise(num.business = unique(business_id)%>%length) %>% arrange(desc(num.business)) %>% filter(num.business>1000)
business = business %>% filter(city %in% target.city$city)

business = readRDS(file = "business.rds")
business = data.frame(business)
business = business[complete.cases(business[,list()])]
business = business %>% drop_na()

library(rjson)
business = fromJSON(file = "business.json")
