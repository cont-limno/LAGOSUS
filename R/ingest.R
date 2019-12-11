#' @name lagos_ingest
#' @title Ingest LAGOSUS flat files
#'
#' @description Ingest LAGOSUS data from component flat files
#' @inheritParams lagosus_compile
#' @importFrom utils read.table
#' @importFrom progress progress_bar
#' @examples \dontrun{
#'lg <- lagos_ingest(
#'  locus_version = "0",
#'  locus_folder = "~/Downloads/LAGOS-US-LOCUS-EXPORT")
#'}
lagos_ingest <- function(locus_version = NA, locus_folder = NA,
                         limno_version = NA, limno_folder = NA,
                         geo_version = NA, geo_folder = NA,
                         depth_version = NA, depth_folder = NA){

  if(sum(!is.na(nchar(c(locus_folder, limno_folder,
                        geo_folder, depth_folder)))) > 1){
    error("Only one folder at a time should be passed here, iteration occurs in lagosus_compile")
  }

  if(!is.na(locus_folder)){
    # Importing LAGOS locus data ####
    locus_information <- load_lagos_txt(
      list.files(locus_folder, pattern = "information_\\d*.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    locus_ws <- load_lagos_txt(
      list.files(locus_folder, pattern = "watersheds_ws_\\d*.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    locus_nws <- load_lagos_txt(
      list.files(locus_folder, pattern = "watersheds_nws_\\d*.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    locus_characteristics <- load_lagos_txt(
      list.files(locus_folder, pattern = "characteristics_\\d*.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    locus_link <- load_lagos_txt(
      list.files(locus_folder, pattern = "Link_v2_\\d*.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    locus <- list(locus_information = locus_information,
                  locus_ws = locus_ws,
                  locus_nws = locus_nws,
                  locus_characteristics = locus_characteristics,
                  locus_link = locus_link
                  )

    locus
  }

  if(!is.na(depth_folder)){
    # Importing LAGOS depth data ####
    depth <- load_lagos_txt(
      list.files(depth_folder, pattern = "lagosus_depth.csv",
                 include.dirs = TRUE, full.names = TRUE), sep = ",")

    depth <- list(depth = depth)

    depth
  }

  }
