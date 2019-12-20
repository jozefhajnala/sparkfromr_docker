# Dummy sparklyR script

# Attach libraries
library(sparklyr)
library(dplyr)
library(nycflights13)

# Connect
sc <- sparklyr::spark_connect(master = "local")

# Copy weather to the instance
tbl_weather <- dplyr::copy_to(sc, nycflights13::weather, "weather", overwrite = TRUE)

# Collect it back
tbl_weather %>% collect()

# Create some functions
fun_implemented <- function(df, col) df %>% mutate({{col}} := tolower({{col}}))
fun_r_only <- function(df, col) df %>% mutate({{col}} := casefold({{col}}, upper = FALSE))
fun_hive_builtin <- function(df, col) df %>% mutate({{col}} := lower({{col}}))

# Run an example benchmark
microbenchmark::microbenchmark(
  times = 3, 
  setup = library(arrow),
  hive_builtin = fun_hive_builtin(tbl_weather, origin) %>% collect(),
  translated_dplyr = fun_implemented(tbl_weather, origin) %>% collect(),
  spark_apply_arrow = spark_apply(tbl_weather, function(tbl) {
    tbl$origin <- casefold(tbl$origin, upper = TRUE)
    tbl
  }) %>% collect()
)
