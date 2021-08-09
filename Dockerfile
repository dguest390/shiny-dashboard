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
#I actually have to go to 127.0.0.1:3838 I tried 0.0.0.0:3838 and that
#doesn't work. I switched the code to 127.0.0.1 right above, and then 
#nothing worked. Don't know why this works... but it does, which is 
#good enough at the moment.
