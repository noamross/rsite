options(
  repos = c(CRAN="https://cran.rstudio.com"),
  renv.verbose = TRUE,
  renv.config.cache.enabled = TRUE,
  renv.config.cache.symlinks = TRUE,
  renv.config.install.verbose = TRUE
)

if (file.exists(".env")) {
  readRenviron(".env")
} else if (file.exists("../.env")) {
  readRenviron("../.env")
} else if (file.exists("~/.env")) {
  readRenviron("~/.env")
}

source("renv/activate.R")
