library(readxl)
library(tidyxl)
library(dplyr)
library(unpivotr)

# read wholesale ----

fpath <- "taxonomy/locus_taxonomy_njs_20191121.xlsx"
dt    <- readxl::read_excel(fpath, skip = 24, col_names = FALSE) %>%
  dplyr::select(2:3) %>%
  setNames(c("variable", "description"))

# chunk excel file by filled headers ----
x_raw       <- xlsx_cells(fpath)
formats     <- xlsx_formats(fpath)
header_rows <- x_raw[
  x_raw$local_format_id %in% which(!is.na(
    formats$local$fill$patternFill$patternType)), c("address", "character")] %>%
  dplyr::filter(!is.na(character)) %>%
  mutate(address = gsub("A", "", address)) %>%
  pull(address)
header_rows <- header_rows[(length(header_rows) - 4):length(header_rows)]
x         <- dplyr::filter(x_raw, row >= as.numeric(header_rows[1])) %>%
  dplyr::filter(!(col == 1 & !(row %in% header_rows))) %>%
  rectify() %>% dplyr::select(2:4) %>%
  janitor::remove_empty("rows") %>%
  dplyr::filter(`2(B)` != "New" | is.na(`2(B)`)) %>%
  setNames(c("table_name", "variable", "description")) %>%
  tidyr::fill(table_name) %>% dplyr::filter(!is.na(variable)) %>%
  dplyr::mutate(table_name = trimws(stringr::str_extract(table_name, "Lake\\s\\w*\\s")))

tabular <- function(df, ...) {
  stopifnot(is.data.frame(df))

  align <- function(x) if (is.numeric(x)) "r" else "l"
  col_align <- vapply(df, align, character(1))

  cols <- lapply(df, format, ...)
  contents <- do.call("paste",
                      c(cols, list(sep = " \\tab ", collapse = "\\cr\n  ")))

  paste("\\tabular{", paste(col_align, collapse = ""), "}{\n  ",
        contents, "\n}\n", sep = "")
}

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
