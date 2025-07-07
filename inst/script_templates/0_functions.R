# Title -------------------------------------------------------------------
# Project Title: <<add_package_title>>
# Script Title: 0_functions

# Script Description: This script loads your own functions.


# Get scripts -------------------------------------------------------------

files <- list.files(path = "Functions", pattern = ".R$")


# Run scripts -------------------------------------------------------------

if (length(files) >= 1L) {
  for (i in seq_along(files)) {
    source(file.path("Functions", files[i]))
  }
  rm(i)
}


# Clean -------------------------------------------------------------------

rm(files)
