FROM apache/airflow:2.9.3

USER root

# Install R and system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        r-base \
        gfortran \
        libpq-dev \
        libssl-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libpng-dev \
        libtiff-dev \
        libjpeg-dev \
        build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c( \
      'stringr', 'DBI', 'RPostgres', 'dplyr', 'tidyverse', \
      'tidyr', 'janitor', 'lubridate' \
    ), repos='https://cloud.r-project.org')"

USER airflow 

RUN pip install pandas sqlalchemy psycopg2-binary openpyxl
