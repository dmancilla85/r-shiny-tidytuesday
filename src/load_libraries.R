# *****************************************************************************
# load_libraries.R - Project libraries loader.
# *****************************************************************************

# must include all libraries required for the project
current_libraries <- c(
  "shiny",
  "modules",
  "dplyr",
  "purrr",
  "shinydashboard",
  "ggplot2",
  "stringr",
  "scales",
  "DT",
  "tidyr"
)

loadLibraries <- function(libs) {
  for (i in 1:length(libs)) {
    library(libs[i],
      quietly = TRUE, character.only = TRUE,
      warn.conflicts = FALSE, verbose = FALSE
    )
  }
}

loadLibraries(libs = current_libraries)
current_libraries <- NULL
