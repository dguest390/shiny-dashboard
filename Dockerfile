#docker image with our version
FROM rocker/shiny-verse:4.0.5

#creates and moves us into directory
RUN mkdir /app
WORKDIR /app

#copies our files
COPY app.R app.R
COPY water_potability.csv water_potability.csv

#needed to install these separately
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"

#port to go to
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
#entrypoint for the container
