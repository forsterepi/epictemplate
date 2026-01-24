#' Create new file
#'
#' Base function for the "Create file" addin. Inputs are provided via dialogs.
#'
#' @returns Creates a new file according to the specifications.
#' @export
#'
#' @examples
#' \dontrun{
#' new_file()
#' }
new_file <- function() {
  # User input: Get file name
  file_name <- rstudioapi::showPrompt(
    title = "Please specify the file name?",
    message = "",
    default = ".R"
  )

  # Get name and path
  if (stringi::stri_detect_regex(str = file_name, pattern = "\\.R$")) {
    file_path <- file_name
    file_name <- stringi::stri_replace_all_regex(
      str = file_name,
      pattern = "\\.R$",
      replacement = ""
    )
  } else {
    file_path <- stringi::stri_c(file_name, ".R")
  }

  # Get project name and path
  try(project_path <- rprojroot::find_root(rprojroot::is_rstudio_project))
  if (!exists("project_path")) {
    rstudioapi::showDialog(
      title = "No RStudio project",
      message = "This is not an RStudio project!"
    )
    return(invisible(NULL))
  }
  project_name <- basename(project_path)

  # Create file
  # Check if file exists
  if (!file.exists(file.path(project_path, "R", file_path))) {
    ## Create file
    new_file <- file.path(project_path, "R", file_path)
    file.create(new_file)
    new_file_code <- readLines(system.file("script_templates",
      "template_script.R",
      package = "epictemplate"
    ))
    new_file_code <- gsub(
      pattern = "<<add_project_name>>",
      replacement = project_name,
      x = new_file_code
    )
    new_file_code <- gsub(
      pattern = "<<add_script_name>>",
      replacement = file_name,
      x = new_file_code
    )
    writeLines(new_file_code, con = new_file)
    ## Open file
    rstudioapi::documentOpen(file.path(project_path, "R", file_path))
  } else {
    rstudioapi::showDialog(
      title = "File exists",
      message = "File already exists!"
    )
  }
}
