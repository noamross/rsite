#!/usr/local/bin/Rscript

shiny::runApp(appDir = "shiny-app.R", host = "127.0.0.1", port = Sys.getenv("SHINY_PORT"))


