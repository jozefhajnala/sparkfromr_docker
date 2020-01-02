# Docker image `sparkfromr` 

![](https://github.com/jozefhajnala/sparkfromr_docker/workflows/Docker%20Image%20CI/badge.svg)

Based on images by the [Rocker Project](https://www.rocker-project.org/). Used for building the [sparkfromr.com](https://sparkfromr.com) bookdown website. Has RStudio exposed at [http://localhost:8787](http://localhost:8787).

## Main features

- R 3.6.1
- RStudio Server
- openjdk 8
- Apache Spark 2.4.3
- Apache Arrow C++ libraries

R Packages (including dependencies):

- sparklyr (1.0.2)
- arrow (0.14.1.1)
- remotes (2.1.0)
- microbenchmark (1.4-6)
- knitr (1.24)
- rmarkdown (1.15)
- bookdown (0.13)
- data.table (1.12.2)

## Usage

### Interactive with RStudio and sparklyr

```
# replace <password> with a password of your choice
docker run -d -p 8787:8787 -e PASSWORD=<password> --name rstudio jozefhajnala/sparkfromr:latest
```
Navigate to [http://localhost:8787](http://localhost:8787). Username for login is: `rstudio`, password is the one you chose above.

### Building bookdown books

```
docker run --rm -it jozefhajnala/sparkfromr:latest /bin/bash
git clone https://github.com/rstudio/bookdown-demo
cd bookdown-demo
Rscript -e "bookdown::render_book('.')"
```

### Rendering spark-related code with R Markdown

```
docker run --rm -it jozefhajnala/sparkfromr:latest R
rmarkdown::render("/root/.local/spark_script.R")
```

### Interactive with R and sparklyr

```
docker run --rm -it jozefhajnala/sparkfromr:latest R

# R session should start
library(sparklyr)
sc <- spark_connect("local")
```

### Interactive with spark shell

```
docker run --rm -it jozefhajnala/sparkfromr:latest /root/spark/spark-2.4.3-bin-hadoop2.7/bin/spark-shell

# Scala REPL should open with
# - Spark context available as `sc`
# - Spark session avaiable as `spark`
```

### Running an example R script

```
docker run --rm jozefhajnala/sparkfromr:latest Rscript /root/.local/spark_script.R
```
