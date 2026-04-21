# Title -------------------------------------------------------------------
# Project Title: <<add_project_name>>
# Script Title: 0_init

# Script Description: Loading packages, solving resulting conflicts, setting
# options, and initialising the cache.


# Load packages -----------------------------------------------------------

library(conflicted)
library(lintr)
library(tidyverse)
library(magrittr)
library(patchwork)
library(simcausal)
library(flextable)
library(gtsummary)
library(cmdstanr)
library(bayesplot)
library(posterior)

## GitHub packages
library(simChef)

## Private packages
library(supfuns)

## Handle conflicts
conflicts_prefer(
  magrittr::extract,
  magrittr::set_names,
  dplyr::filter,
  dplyr::select,
)

conflict_scout()

## Check if plyr is installed
rlang::check_installed("plyr")


# Set options -------------------------------------------------------------

options(mc.cores = 4)
# options(warnPartialMatchArgs = TRUE)
# ggplot2::theme_set(ggplot2::theme_bw())
# options(simcausal.verbose = FALSE)
# progressr::handlers(global = TRUE)
# progressr::handlers("cli")


# Init cache --------------------------------------------------------------

cache <- storr::storr_rds("Cache")
