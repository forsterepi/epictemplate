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
  dir.create(file.path(path, "Functions"))
  dir.create(file.path(path, "Input"))
  dir.create(file.path(path, "Output"))
  dir.create(file.path(path, "R"))

  if (stan) {
    dir.create(file.path(path, "Stan"))
  }

  # Create files
  ## workflow_main.R
  new_file_workflow_main <- file.path(path, "workflow_main.R")
  file.create(new_file_workflow_main)
  new_file_workflow_main_code <- readLines(system.file("script_templates",
    "template_workflow.R",
    package = "epictemplate"
  ))
  new_file_workflow_main_code <- gsub(
    pattern = "<<add_package_title>>",
    replacement = project_name,
    x = new_file_workflow_main_code
  )
  new_file_workflow_main_code <- gsub(
    pattern = "<<add_workflow_name>>",
    replacement = "workflow_main",
    x = new_file_workflow_main_code
  )
  writeLines(new_file_workflow_main_code, con = new_file_workflow_main)

  ## R/0_packages.R
  new_file_script_packages <- file.path(path, "R", "0_packages.R")
  file.create(new_file_script_packages)
  if (stan) {
    new_file_script_packages_code <- readLines(system.file("script_templates",
      "0_packages_stan.R",
      package = "epictemplate"
    ))
  } else {
    new_file_script_packages_code <- readLines(system.file("script_templates",
      "0_packages.R",
      package = "epictemplate"
    ))
  }
  new_file_script_packages_code <- gsub(
    pattern = "<<add_package_title>>",
    replacement = project_name,
    x = new_file_script_packages_code
  )
  writeLines(new_file_script_packages_code, con = new_file_script_packages)

  ## R/0_functions.R
  new_file_script_functions <- file.path(path, "R", "0_functions.R")
  file.create(new_file_script_functions)
  new_file_script_functions_code <- readLines(system.file("script_templates",
    "0_functions.R",
    package = "epictemplate"
  ))
  new_file_script_functions_code <- gsub(
    pattern = "<<add_package_title>>",
    replacement = project_name,
    x = new_file_script_functions_code
  )
  writeLines(new_file_script_functions_code, con = new_file_script_functions)

  ## R/0_options.R
  new_file_script_options <- file.path(path, "R", "0_options.R")
  file.create(new_file_script_options)
  if (stan) {
    new_file_script_options_code <- readLines(system.file("script_templates",
      "0_options_stan.R",
      package = "epictemplate"
    ))
  } else {
    new_file_script_options_code <- readLines(system.file("script_templates",
      "0_options.R",
      package = "epictemplate"
    ))
  }
  new_file_script_options_code <- gsub(
    pattern = "<<add_package_title>>",
    replacement = project_name,
    x = new_file_script_options_code
  )
  writeLines(new_file_script_options_code, con = new_file_script_options)

  ## .lintr
  new_file_lintr <- file.path(path, ".lintr")
  file.create(new_file_lintr)
  new_file_lintr_code <- readLines(system.file("script_templates",
    "template.lintr",
    package = "epictemplate"
  ))
  writeLines(new_file_lintr_code, con = new_file_lintr)
}
