#' Create project
#'
#' @param path The path provided by the New Project Wizard
#' @param ... Additional parameters: stan (checkbox)
#'
#' @returns Creates a new project
#'
create_epictemplate_project <- function(path, ...) {
  # Ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # Collect inputs
  dots <- list(...)
  stan <- dots[["stan"]]

  # Get project name
  project_name <- basename(path)

  # Create folders
  dir.create(file.path(path, "Input"))
  dir.create(file.path(path, "Output"))
  dir.create(file.path(path, "R"))

  if (stan) {
    dir.create(file.path(path, "Stan"))
  }

  # Create files
  ## R/0_init.R
  new_file_script_packages <- file.path(path, "R", "0_init.R")
  file.create(new_file_script_packages)
  if (stan) {
    new_file_script_packages_code <- readLines(system.file("script_templates",
      "0_init_stan.R",
      package = "epictemplate"
    ))
  } else {
    new_file_script_packages_code <- readLines(system.file("script_templates",
      "0_init.R",
      package = "epictemplate"
    ))
  }
  new_file_script_packages_code <- gsub(
    pattern = "<<add_project_name>>",
    replacement = project_name,
    x = new_file_script_packages_code
  )
  writeLines(new_file_script_packages_code, con = new_file_script_packages)

  ## .lintr
  new_file_lintr <- file.path(path, ".lintr")
  file.create(new_file_lintr)
  new_file_lintr_code <- readLines(system.file("script_templates",
    "template.lintr",
    package = "epictemplate"
  ))
  writeLines(new_file_lintr_code, con = new_file_lintr)

  ## report.qmd
  new_file_report <- file.path(path, "report.qmd")
  file.create(new_file_report)
  new_file_report_code <- readLines(system.file("script_templates",
    "report.qmd",
    package = "epictemplate"
  ))
  writeLines(new_file_report_code, con = new_file_report)
}
