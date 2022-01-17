#docker image found on the internet that works with shiny with our version of R we used :4.0.5
FROM rocker/shiny-verse:4.0.5

#creates a new directory and moves us into that directory
RUN mkdir /app
WORKDIR /app

#copies our files into our new directory
COPY app.R app.R
COPY water_potability.csv water_potability.csv

#these are the packages used in our source code. They need to be installed separately into the dockerfile
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"

#port we use to view our app. (localhost:3838)
EXPOSE 3838

#entrypoint to execute the container
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]

