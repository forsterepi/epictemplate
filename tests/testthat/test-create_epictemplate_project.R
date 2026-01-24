test_that("create_epictemplate_project works", {
  stan <- TRUE

  withr::with_tempdir({
    path <- getwd()
    expect_no_error(create_epictemplate_project(path = path, stan = stan))

    expect_true(file.exists(file.path(path, "Input")))
    expect_true(file.exists(file.path(path, "Output")))
    expect_true(file.exists(file.path(path, "R")))
    expect_true(file.exists(file.path(path, "Stan")))

    expect_true(file.exists(file.path(path, "R", "0_init.R")))

    expect_true(file.exists(file.path(path, "report.qmd")))
    expect_true(file.exists(file.path(path, ".lintr")))
  })

  stan <- FALSE

  withr::with_tempdir({
    path <- getwd()
    expect_no_error(create_epictemplate_project(path = path, stan = stan))

    expect_false(file.exists(file.path(path, "Stan")))

    expect_true(file.exists(file.path(path, "R", "0_init.R")))
  })
})
