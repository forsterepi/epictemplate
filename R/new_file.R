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
  # User input
  input <- rstudioapi::showPrompt(
    title = "Which type of file doe you want to create?",
    message = "s = script; f = function; w = workflow; sub = subworkflow",
    default = "s"
  )
  input <- stringi::stri_trim_both(input)

  allowed_inputs <- c("s", "f", "w", "sub")
  if (!(input %in% allowed_inputs)) {
    rstudioapi::showDialog(
      title = "Invalid input",
      message = "Please select one of the specified options."
    )
  } else {
    # Get file name
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
    project_path <- rprojroot::find_root(rprojroot::is_rstudio_project)
    project_name <- basename(project_path)

    # Create file
    ## Create script ----
    if (input == "s") {
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
          pattern = "<<add_package_title>>",
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
        utils::file.edit(file.path(project_path, "R", file_path))
      } else {
        rstudioapi::showDialog(
          title = "File exists",
          message = "File already exists!"
        )
      }
      # Create function ----
    } else if (input == "f") {
      # Check if file exists
      if (!file.exists(file.path(project_path, "Functions", file_path))) {
        ## Create file
        new_file <- file.path(project_path, "Functions", file_path)
        file.create(new_file)
        new_file_code <- readLines(system.file("script_templates",
          "template_fun.R",
          package = "epictemplate"
        ))
        new_file_code <- gsub(
          pattern = "<<add_package_title>>",
          replacement = project_name,
          x = new_file_code
        )
        new_file_code <- gsub(
          pattern = "<<add_function_name>>",
          replacement = file_name,
          x = new_file_code
        )
        writeLines(new_file_code, con = new_file)
        ## Open file
        utils::file.edit(file.path(project_path, "Functions", file_path))
      } else {
        rstudioapi::showDialog(
          title = "File exists",
          message = "File already exists!"
        )
      }
      ## Create workflow ----
    } else if (input == "w") {
      # Check if file exists
      if (!file.exists(file.path(project_path, file_path))) {
        ## Create file
        new_file <- file.path(project_path, file_path)
        file.create(new_file)
        new_file_code <- readLines(system.file("script_templates",
          "template_workflow.R",
          package = "epictemplate"
        ))
        new_file_code <- gsub(
          pattern = "<<add_package_title>>",
          replacement = project_name,
          x = new_file_code
        )
        new_file_code <- gsub(
          pattern = "<<add_workflow_name>>",
          replacement = file_name,
          x = new_file_code
        )
        writeLines(new_file_code, con = new_file)
        ## Open file
        utils::file.edit(file.path(project_path, file_path))
      } else {
        rstudioapi::showDialog(
          title = "File exists",
          message = "File already exists!"
        )
      }
      ## Create subworkflow ----
    } else if (input == "sub") {
      # Check if file exists
      if (!file.exists(file.path(project_path, "R", file_path))) {
        ## Get workflow name (assumption: text before first underscore)
        workflow_name <- stringi::stri_sub(
          str = file_name,
          from = 1L,
          to = stringi::stri_locate_first_fixed(
            str = file_name,
            pattern = "_"
          )[1, 1] - 1
        )
        workflow_name <- stringi::stri_c("workflow_", workflow_name)
        ## Create file
        new_file <- file.path(project_path, "R", file_path)
        file.create(new_file)
        new_file_code <- readLines(system.file("script_templates",
          "template_script.R",
          package = "epictemplate"
        ))
        new_file_code <- gsub(
          pattern = "<<add_package_title>>",
          replacement = project_name,
          x = new_file_code
        )
        new_file_code <- gsub(
          pattern = "<<add_subworkflow_name>>",
          replacement = file_name,
          x = new_file_code
        )
        new_file_code <- gsub(
          pattern = "<<add_workflow_title>>",
          replacement = workflow_name,
          x = new_file_code
        )
        writeLines(new_file_code, con = new_file)
        ## Open file
        utils::file.edit(file.path(project_path, "R", file_path))
      } else {
        rstudioapi::showDialog(
          title = "File exists",
          message = "File already exists!"
        )
      }
    }
  }
}
