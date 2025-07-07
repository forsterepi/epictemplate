# Title -------------------------------------------------------------------
# Project Title: <<add_package_title>>
# Script Title: 0_packages

# Script Description: This script loads packages and solves resulting conflicts.


# Load packages -----------------------------------------------------------

library(conflicted)
library(lintr)
library(tidyverse)
library(magrittr)

conflicts_prefer(
  magrittr::extract,
  magrittr::set_names,
  dplyr::filter,
  dplyr::select,
)

conflict_scout()
