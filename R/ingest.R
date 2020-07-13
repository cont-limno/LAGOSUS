#' @name lagos_ingest
#' @title Ingest LAGOSUS flat files
#'
#' @description Ingest LAGOSUS data from component flat files
#' @inheritParams lagosus_compile
#' @importFrom utils read.table
#' @importFrom progress progress_bar
#' @examples \dontrun{
#' lg <- lagos_ingest(
#'  locus_version = "1.1",
#'  locus_folder = "~/Downloads/LAGOS-US-LOCUS-EXPORT")
#'}
lagos_ingest <- function(locus_version = NA, locus_folder = NA,
                         limno_version = NA, limno_folder = NA,
                         geo_version = NA, geo_folder = NA,
                         depth_version = NA, depth_folder = NA){

  if (sum(!is.na(nchar(c(locus_folder, limno_folder,
                         geo_folder, depth_folder)))) > 1) {
    stop("Only one folder at a time should be passed here, iteration occurs in lagosus_compile")
  }

  if (!is.na(locus_folder)) {
    # Importing LAGOS locus data ####

    locus_dictionary <- load_lagos_txt(
      list.files(locus_folder, pattern = "data_dictionary.*.csv",
                 include.dirs = TRUE, full.names = TRUE),
      na.strings = c(""), sep = ",")

    locus_link <- load_lagos_txt(
      list.files(locus_folder, pattern = "link.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = locus_dictionary)

    locus_characteristics <- load_lagos_txt(
      list.files(locus_folder, pattern = "characteristics.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = locus_dictionary)

    locus_watersheds <- load_lagos_txt(
      list.files(locus_folder, pattern = "watersheds.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = locus_dictionary)

    locus_information <- load_lagos_txt(
      list.files(locus_folder, pattern = "information.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = locus_dictionary)

    locus_source <- load_lagos_txt(
      list.files(locus_folder, pattern = "source_table.*.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = locus_dictionary)

    locus <- list(lake_link = locus_link,
                  lake_characteristics = locus_characteristics,
                  lake_watersheds = locus_watersheds,
                  lake_information = locus_information,
                  data_dictionary_locus = locus_dictionary,
                  source_table_locus = locus_source
                  )

    return(locus)
  }

  if (!is.na(depth_folder)) {
    # Importing LAGOS depth data ####

    depth_dictionary <- load_lagos_txt(
      list.files(depth_folder, pattern = "data_dictionary.*.csv",
                 include.dirs = TRUE, full.names = TRUE),
      na.strings = c(""), sep = ",")

    depth <- load_lagos_txt(
      list.files(depth_folder, pattern = "lake_depth.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    depth <- list(lake_depth = depth,
                  data_dictionary_depth = depth_dictionary)

    return(depth)
  }

  }
