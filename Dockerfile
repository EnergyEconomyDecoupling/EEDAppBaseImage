# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

## Install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libssl-dev \
    libudunits2-dev

## Update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Copy required files
## renv
COPY /renv.lock /renv.lock

# Install renv & restore packages
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore()'