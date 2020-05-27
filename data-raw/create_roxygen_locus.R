library(LAGOSUS)
library(dplyr)

lg     <- lagosus_load(modules = c("locus"))
dt_raw <- lg$locus$locus_dictionary
# names(lg$locus)
# unique(dt_raw$table_name)
tables <- data.frame(export = unique(dt_raw$table_name),
                     inpackage = c("locus_dictionary", "locus_characteristics",
                                   "locus_link", "locus_information",
                                   "locus_watersheds", "locus_source"),
                     stringsAsFactors = FALSE)

get_table_metadata <- function(dt_raw, table_name_){
  dt <- dt_raw %>%
    dplyr::filter(table_name == !!table_name_) %>%
    dplyr::select(variable_name, variable_description, units)
  dt <- setNames(dt,
                 snakecase::to_any_case(names(dt), "sentence"))
  dt <- mutate(dt, across(everything(), ~ case_when(. == "NA"~ "",
                                                    is.na(.) ~ "",
                                                    TRUE ~ .)))
  dt
}

res <- lapply(tables$export, function(x) get_table_metadata(dt_raw, x))
names(res) <- tables$inpackage

# paste into LAGOSUS-package.R @details tags
clipr::write_clip(
  paste0("#' ", readLines(textConnection(tabular(res$locus_information))))
)

clipr::write_clip(
  paste0("#' ", readLines(textConnection(tabular(res$locus_characteristics))))
)

clipr::write_clip(
  paste0("#' ", readLines(textConnection(tabular(res$locus_watersheds))))
)

clipr::write_clip(
  paste0("#' ", readLines(textConnection(tabular(res$locus_link))))
)

clipr::write_clip(
  paste0("#' ", readLines(textConnection(tabular(res$locus_source))))
)
