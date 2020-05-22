library(LAGOSUS)
library(readxl)
library(dplyr)
library(googledrive)

# lg <- lagosus_load(modules = c("locus", "depth"))
# names(lg$locus)

fpath <- "data-raw/locus_metadata_NOTMASTER.xlsx"
if (!file.exists(fpath)) {
  drive_download("locus_metadata_NOTMASTER.xlsx",
                 path = fpath, overwrite = TRUE)
}
dt_raw <- readxl::read_excel(fpath)
# unique(dt_raw$table_name)

table_name_ <- "lake_characteristics"
dt <- dt_raw %>%
  dplyr::filter(table_name == table_name_) %>%
  dplyr::select(variable_name, variable_description, units)
dt <- setNames(dt,
               snakecase::to_any_case(names(dt), "sentence"))
dt <- mutate(dt, across(everything(), ~ case_when(. == "NA"~ "", TRUE ~ .)))
# nrow(dt)
# ncol(lg$locus$locus_characteristics)
# names(lg$locus$locus_characteristics)
# dt$variable_name

# see jsta::tabular
tabular <- function(df, ...) {
  stopifnot(is.data.frame(df))

  align <- function(x) if (is.numeric(x)) "r" else "l"
  col_align <- vapply(df, align, character(1))

  cols <- lapply(df, format, ...)
  contents <- do.call("paste",
                      c(cols, list(sep = " \\tab ", collapse = "\\cr\n  ")))
  col_names <- paste0("\\bold{",
                      do.call("paste",
                              c(names(df), list(sep = "} \\tab \\bold{", collapse = "\\cr\n  "))),
                      "} \\cr")

  paste("\\tabular{", paste(col_align, collapse = ""), "}{\n",
        col_names,
        "\n",
        contents, "\n}\n", sep = "")
}

# paste into LAGOSUS-package.R
res <- paste0("#' ", readLines(textConnection(tabular(dt))))
clipr::write_clip(res)

res <- data.frame(dplyr::filter(x, table_name == "Lake information"))[,2:3]
res <- paste0("#' ", readLines(textConnection(tabular(res))))
clipr::write_clip(res)

res <- data.frame(dplyr::filter(x, table_name == "Lake characteristics"))[,2:3]
res <- paste0("#' ", readLines(textConnection(tabular(res))))
clipr::write_clip(res)

res <- data.frame(dplyr::filter(x, table_name == "Lake watersheds"))[,2:3]
res <- paste0("#' ", readLines(textConnection(tabular(res))))
clipr::write_clip(res)

unique(x$table_name)
