test_that("create_epictemplate_project works", {
  stan <- TRUE

  withr::with_tempdir({
    path <- getwd()
    expect_no_error(create_epictemplate_project(path = path, stan = stan))

    expect_true(file.exists(file.path(path, "Functions")))
    expect_true(file.exists(file.path(path, "Input")))
    expect_true(file.exists(file.path(path, "Output")))
    expect_true(file.exists(file.path(path, "R")))
    expect_true(file.exists(file.path(path, "Templates")))
    expect_true(file.exists(file.path(path, "Stan")))

    expect_true(file.exists(file.path(path, "R", "0_packages.R")))
    expect_true(file.exists(file.path(path, "R", "0_functions.R")))
    expect_true(file.exists(file.path(
      path, "Templates",
      "template_fun.R"
    )))
    expect_true(file.exists(file.path(
      path, "Templates",
      "template_script.R"
    )))
    expect_true(file.exists(file.path(
      path, "Templates",
      "template_subworkflow.R"
    )))
    expect_true(file.exists(file.path(
      path, "Templates",
      "template_workflow.R"
    )))

    expect_true(file.exists(file.path(path, "workflow_main.R")))
    expect_true(file.exists(file.path(path, ".lintr")))

    expect_equal(
      readLines(file.path(path, "workflow_main.R"))[2],
      paste0("# Project Title: ", basename(path))
    )

    expect_equal(
      readLines(file.path(path, "R", "0_packages.R"))[14],
      "library(cmdstanr)"
    )
  })

  stan <- FALSE

  withr::with_tempdir({
    path <- getwd()
    expect_no_error(create_epictemplate_project(path = path, stan = stan))

    expect_false(file.exists(file.path(path, "Stan")))

    expect_true(file.exists(file.path(path, "R", "0_packages.R")))

    expect_equal(
      readLines(file.path(path, "R", "0_packages.R"))[15],
      "conflicts_prefer("
    )
  })
})
