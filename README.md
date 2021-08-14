<p align="center">
  <img width="250" src="Media/Shiny-logo.png" alt="shinydashboard">
  <h3 align="center">Shiny Dashboard</h3>
  <p align="center"> R Shiny Dashboard inside a Docker container</p>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#quick-start">Quick Start</a></li>
    <li><a href="#details">Details</a></li>
    <li><a href="#additional-resources">Additional Resources</a></li>
  </ol>
</details>
 
## About

This project contains a sample [Shiny](https://rstudio.github.io/shinydashboard/) dashboard and a Dockerfile which builds and runs the application. Users can use their own datasets to create visualizations in R and make them accessible through a container.
  
## Prerequisites

Below are the tools you need to create this project:

- [R version 4.0.5 (Shake and Throw)](https://mirror.las.iastate.edu/CRAN/)
- [RStudio IDE](https://www.rstudio.com/products/rstudio/download/)
- [Docker Desktop](https://docs.docker.com/get-docker/)
- [GitHub Desktop](https://desktop.github.com/)
- [Have an account on GitHub](https://github.com/join)

## Quick Start

To Run this Project:

1. [Docker Desktop](https://docs.docker.com/get-docker/) is the only app you need to have in order to run the finished product so make sure you have Docker installed
2. Once you have the Docker Desktop app and it's running, go to powershell and type in the following:
    ```sh
    docker pull dguest390/shiny-dashboard
    ```
3. Once you have pulled the Docker Image to your computer, type in the following:
    ```sh
    docker run --rm -p 3838:3838 dguest390/shiny-dashboard
    ```
4. Now you should be hosting your own copy of the Shinydashboard locally, go to your browser and go to the following URL: 
    ```
    127.0.0.1:3838
    ```
## Details

__About The Project Here:__

__Insert 2 Screenshots Here:__

## Additional Resources

* [Readme Template](https://github.com/othneildrew/Best-README-Template)
* [Markdown Cheatsheet](https://www.markdownguide.org/cheat-sheet)
* [Shiny](https://shiny.rstudio.com/)
