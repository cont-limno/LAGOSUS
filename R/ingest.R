#' @name lagos_ingest
#' @title Ingest LAGOSUS flat files
#'
#' @description Ingest LAGOSUS data from component flat files
#' @inheritParams lagosus_compile
#' @importFrom utils read.table
#' @importFrom progress progress_bar
#' @examples \dontrun{
#' download_path <- "~/"
#' # download_path <- "../../../"
#'
#' lg <- lagos_ingest(
#'  locus_version = "1.0",
#'  locus_folder = paste0(download_path, "Downloads/LOCUS_v1.0"))
#'
#' lg <- lagos_ingest(
#'  limno_version = "2.1",
#'  limno_folder = paste0(download_path, "Downloads/LIMNO_v2.1/Final exports"))
#'
#' lg <- lagos_ingest(
#'  depth_version = "0.1",
#'  depth_folder = paste0(download_path, "Downloads/DEPTH_v0.1"))
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
      list.files(locus_folder, pattern = "data_dictionary_locus.csv",
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
      sep = ",", na.strings = "NULL", dictionary = locus_dictionary)

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

  if (!is.na(limno_folder)) {
    # Importing LAGOS limno data ####

    limno_dictionary <- load_lagos_txt(
      file_name = list.files(limno_folder, pattern = "data_dictionary*",
                 include.dirs = TRUE, full.names = TRUE),
      na.strings = c(""), sep = ",")

    limno_chemicalphysical <- load_lagos_txt(
      list.files(limno_folder, pattern = "chemicalphysical",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = limno_dictionary)

    # TODO: turn on the claritycarbon table if it has a tss_mgl field
    # limno_claritycarbon <- load_lagos_txt(
    #   list.files(limno_folder, pattern = "claritycarbon",
    #              include.dirs = TRUE, full.names = TRUE),
    #   sep = ",", dictionary = limno_dictionary)

    limno_contaminants <- load_lagos_txt(
      list.files(limno_folder, pattern = "*contaminants_epi.csv",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = limno_dictionary)

    limno_information <- load_lagos_txt(
      list.files(limno_folder, pattern = "information",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = limno_dictionary)

    limno_nutrientsalgae <- load_lagos_txt(
      list.files(limno_folder, pattern = "nutrientsalgae",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = limno_dictionary)

    limno_source <- load_lagos_txt(
      list.files(limno_folder, pattern = "source_table",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = limno_dictionary)


    limno <- list(
                  site_chemicalphysical = limno_chemicalphysical,
                  # site_claritycarbon = limno_claritycarbon,
                  site_contaminants = limno_contaminants,
                  site_information = limno_information,
                  site_nutrientsalgae = limno_nutrientsalgae,
                  data_dictionary_limno = limno_dictionary,
                  source_table_limno = limno_source
    )

    return(limno)
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

  if (!is.na(geo_folder)){
    # Importing LAGOS geo data ####

    variable_dictionary_geo <- load_lagos_txt(
      list.files(geo_folder, pattern = "variable_dictionary.*.csv",
                 include.dirs = TRUE, full.names = TRUE),
      na.strings = c(""), sep = ",")

    zone_terrain <- load_lagos_txt(
      list.files(geo_folder, pattern = "zone_terrain",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = variable_dictionary_geo, parse_units = FALSE)

    zone_soils <- load_lagos_txt(
      list.files(geo_folder, pattern = "zone_soils",
                 include.dirs = TRUE, full.names = TRUE),
      sep = ",", dictionary = variable_dictionary_geo, parse_units = FALSE)

    geo <- list(zone_terrain = zone_terrain,
                zone_soils = zone_soils,
                variable_dictionary_geo = variable_dictionary_geo)

    return(geo)
  }
}
