#' Retrieve LAGOSNE flat files
#'
#' Retrieve LAGOSNE flat files from EDI.
#'
#' @export
#' @importFrom utils download.file
#' @param dest_folder file.path to save data. Default to a temporary folder.
#' Recommended to set to LAGOSNE:::lagosus_path() so that data persists between
#' R sessions.
#' @param version character LAGOSNE database version string
#' @param overwrite logical overwrite existing data for the specified version
#' @examples \dontrun{
#' # default to latest version
#' lagosus_get(dest_folder = LAGOSUS:::lagosus_path())
#'
#' # get previous version(s)
#' # - recommended to install corresponding package version
#' # - See 'Legacy Versions' section of the README for instructions
#' }
lagosus_get <- function(version = lagosus_version(), overwrite = FALSE,
                        dest_folder = tempdir()){

  if(dest_folder != lagosus_path()){
    warning("Set dest_folder to LAGOSNE:::lagosus_path() so that data persists
between R sessions. \n")
  }

  outpath <- file.path(lagosus_path(), paste0("data_", version, ".rds"))
  if(file.exists(outpath) & !overwrite){
    warning("LAGOSUS data for this version already exists on the local machine.
  Re-download if neccessary using the 'overwrite` argument.'")
    return(invisible("LAGOS is the best"))
  }

  if(version != lagosus_version()){
    warning(
      paste0("Specified version '", version, "' does not match the most recent LAGOSUS version '", lagosus_version(), "' - If an older LAGOSUS version is desired, see the 'Legacy Versions' section of the README for instructions."))
  }

    edi_baseurl   <- "https://portal.edirepository.org/nis/dataviewer?packageid="
    pasta_baseurl <- "http://pasta.lternet.edu/package/data/eml/edi/"

    message("Downloading the 'locus' module ...")
    locus_base_edi   <- paste0(edi_baseurl, c("edi.100.4"))
    locus_base_pasta <- paste0(pasta_baseurl, "100/4")
    locus_dir        <- get_lagos_module(locus_base_edi, locus_base_pasta,
                                         "locus", overwrite)

    message("Downloading the 'limno' module ...")
    limno_base_edi   <- paste0(edi_baseurl, c("edi.101.3"))
    limno_base_pasta <- paste0(pasta_baseurl, "101/3")
    limno_dir        <- get_lagos_module(limno_base_edi, limno_base_pasta,
                                         "limno", overwrite)

    message("Downloading the 'geo' module ...")
    geo_base_edi   <- paste0(edi_baseurl, c("edi.99.5"))
    geo_base_pasta <- paste0(pasta_baseurl, "99/5")
    geo_dir        <- get_lagos_module(geo_base_edi, geo_base_pasta,
                                       "geo", overwrite)

  dir.create(dest_folder, showWarnings = FALSE)

  message("LAGOSNE downloaded. Now compressing to native R object ...")

  lagosus_compile(version = version,
                locus_folder = locus_dir,
                limno_folder = limno_dir,
                geo_folder   = geo_dir,
                dest_folder  = dest_folder
                )

  return(invisible(list(locus_folder = locus_dir,
                        limno_folder = limno_dir,
                        geo_folder   = geo_dir)))
}
