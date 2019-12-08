client_id <- "CijTUKOxsKUIqWgLQQmo8A"
api <- "kTfxBsvITkcBwuxs9qEg5yXIwPuRSlcEEQeWVbJ45l1IZ6VH9GoRczuqO00p_g_l8w-405oqjbnEq_DBAuIx55G4wuEao9zGVF7ltjEqfqGWw-Cl7u9MpKZbYfHfXXYx"

#devtools::install_github("OmaymaS/yelpr")

library(yelpr)
key <- readLines("yelp_key.txt")

business_ny <- business_search(api_key = api,
                               location = 'Boston',limit = 50)

data = business_ny$businesses

business_d