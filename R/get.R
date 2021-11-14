#' Retrieve LAGOSNE flat files
#'
#' Retrieve LAGOSNE flat files from EDI.
#'
#' @export
#' @importFrom utils download.file
#' @inheritParams lagosus_compile
#' @examples \dontrun{
#' # default to latest version
#' lagosus_get(dest_folder = LAGOSUS::lagosus_path())
#'
#' # get previous version(s)
#' # - recommended to install corresponding package version
#' # - See 'Legacy Versions' section of the README for instructions
#' }
lagosus_get <- function(locus_version = NA, locus_folder = NA, locus_overwrite = FALSE,
                        limno_version = NA, limno_folder = NA, limno_overwrite = FALSE,
                        geo_version = NA, geo_folder = NA, geo_overwrite = FALSE,
                        depth_version = NA, depth_folder = NA, depth_overwrite = FALSE,
                        dest_folder = NA){

  if(dest_folder != lagosus_path()){
    warning("Set dest_folder to LAGOSNE::lagosus_path() so that data persists
between R sessions. \n")
  }


  check_version <- function(module, version) {
    outpath <- file.path(lagosus_path(), paste0(module, "_", version, ".rds"))
    if(file.exists(outpath) & !locus_overwrite) {
      warning("LAGOSUS data for this version already exists on the local machine.
    Re-download if neccessary using the 'overwrite` argument.'")
      return(invisible("LAGOS is the best"))
    }
  }

  check_latest <- function(module, version) {
    if(all(version != lagosus_version()) & !is.na(version)) {
      warning(
        paste0("Specified version '", version,
        "' does not match the most recent LAGOSUS version '",
        lagosus_version(), "' - If an older LAGOSUS version is desired, see the 'Legacy Versions' section of the README for instructions."))
    }
  }

    edi_baseurl   <- "https://portal.edirepository.org/nis/dataviewer?packageid="
    pasta_baseurl <- "http://pasta.lternet.edu/package/data/eml/edi/"

    message("Downloading the 'locus' module ...")
    check_version("locus", locus_version)
    check_latest("locus", locus_version)
    if(is.na(locus_version)) {
      locus_version <- dplyr::pull(
        dplyr::filter(lagosus_version(), modules == "locus"), "versions")
    }
    locus_base_edi   <- paste0(edi_baseurl, c("edi.854.1"))
    locus_base_pasta <- paste0(pasta_baseurl, "854/1")
    locus_dir        <- get_lagos_module(locus_base_edi, locus_base_pasta,
                                         "locus", locus_overwrite)

    # message("Downloading the 'limno' module ...")
    # limno_base_edi   <- paste0(edi_baseurl, c("edi.101.3"))
    # limno_base_pasta <- paste0(pasta_baseurl, "101/3")
    # limno_dir        <- get_lagos_module(limno_base_edi, limno_base_pasta,
    #                                      "limno", limno_overwrite)

    # message("Downloading the 'geo' module ...")
    # geo_base_edi   <- paste0(edi_baseurl, c("edi.99.5"))
    # geo_base_pasta <- paste0(pasta_baseurl, "99/5")
    # geo_dir        <- get_lagos_module(geo_base_edi, geo_base_pasta,
    #                                    "geo", geo_overwrite)    

  dir.create(dest_folder, showWarnings = FALSE)

  message("LAGOSUS downloaded. Now compressing to native R object ...")

  lagosus_compile(locus_version = locus_version,
                locus_folder = locus_dir,
                locus_overwrite = locus_overwrite,
                limno_folder = NA,
                geo_folder   = NA,
                dest_folder  = dest_folder
                )

  return(invisible(list(locus_folder = locus_dir,
                        limno_folder = NA,
                        geo_folder   = NA)))
}
