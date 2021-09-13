#!/usr/local/bin/Rscript

router <- plumber::plumb('plumber-app.R')
router$run(host = '127.0.0.1', port = as.numeric(Sys.getenv("PLUMBER_PORT")), debug = TRUE)

