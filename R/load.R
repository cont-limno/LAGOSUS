#' Load LAGOSUS data
#'
#' Load LAGOSUS data from local system files
#'
#' @param modules character vector of module names. One or more of "locus", "limno", "geo", or "depth.
#' @param versions character LAGOSUS database version strings. Defaults to \code{\link{lagosus_version}}
#' @export
#' @importFrom rappdirs user_data_dir
#' @importFrom memoise memoise
#'
#' @examples \dontrun{
#' lg <- lagosus_load(modules = c("locus", "depth"),
#'                    versions = c(0, 0))
#' }
lagosus_load <- memoise::memoise(function(modules = NULL,
                                          versions = NA,
                                          geo_tables = NA){

  browser()
  # TODO sanity check of specified module names
  # are they true module names?
  # are there <= 4 specified?
  # have versions been specified for all requested modules?
  #   print message(s) for defaults used

  # TODO if geo has been requested have geo_tables been specified?
  #   error if not
  # are geo_tables true table names?
  #   error if not

  # TODO iterate through specified modules

  # if(is.null(version)){
  #   version <- lagosne_version()
  #   if(interactive()){
  #     message(paste0("Loading LAGOSNE version: ", version))
  #   }else{
  #     warning(paste0("LAGOSNE version unspecified, loading version: ", version))
  #   }
  # }

  if(!is.na(fpath)){
      readRDS(fpath)
  }else{
    rds_path <- paste0(lagos_path(), "data_", version, ".rds")
    stop_if_not_exists(rds_path)
    readRDS(rds_path)
  }
})

#' Load depth data from Oliver et al. 2015.
#'
#' @format A data frame with 50607 observations of 8 variables:
#' \itemize{
#'        \item lagoslakeid: unique identifier for each lake in LAGOS-NE.
#'             For each row of data in this table, the lagoslakeid identifies the focal lake
#'             for which other measures are calculated
#'        \item nhdid: the 'Permanent_identifier' from the NHD,
#'             but is called the NHDID in LAGOS-NE
#'        \item hu4id: the unique ID of the HU4 zone that the focal lake is located within
#'        \item lat_decimal: lattitude geographic coordinate in decimal degrees
#'        \item long_decimal: longitude geographic coordinate in decimal degrees
#'        \item area: lake area in hectares
#'        \item zmaxobs: observed maximum lake depth (meters)
#'        \item zmaxpredict: predicted maximum lake depth (meters)
#'     }
#'
#' @export
#' @param fpath file.path optionally specify custom location of csv data file
#' @importFrom utils read.csv
#' @importFrom rappdirs user_data_dir
#'
#' @references Oliver SK, Soranno PA, Fergus EC, Wagner T, Webster KE, Scott C,
#'  Winslow LA, Downing JA, Stanley EH. 2015. LAGOS - Predicted and observed
#'  maximum depth values for lakes in a 17-state region of the U.S. Long Term
#'  Ecological Research Network.
#'  doi:10.6073/pasta/f00a245fd9461529b8cd9d992d7e3a2f
#' @examples \dontrun{
#' lagos_load_oliver_2015()
#' }
lagos_load_oliver_2015 <- function(fpath = NA){
  destdir <- rappdirs::user_data_dir("LAGOSNE")
  dir.create(destdir, showWarnings = FALSE)

  if(is.na(fpath)){
    read.csv(paste0(destdir, .Platform$file.sep, "oliver_2015_depth.csv"),
             stringsAsFactors = FALSE)
  }else{
    read.csv(fpath, stringsAsFactors = FALSE)
  }
}

#' Load LAGOSNE snapshot from Collins et al. 2017.
#'
#' @export
#' @param fpath file.path optionally specify custom location of csv data file
#' @importFrom utils read.csv
#' @importFrom rappdirs user_data_dir
#'
#' @references Collins S., S. Oliver, J. Lapierre, E. Stanley, J. Jones,
#'  T. Wagner, P. Soranno. 2016. LAGOS - Lake nitrogen, phosphorus,
#'  stoichiometry, and geospatial data for a 17-state region of the U.S..
#'  Environmental Data Initiative.
#'  doi:10.6073/pasta/3abb4a56e76a52a12a366a338fc07dd8.
#' @examples \dontrun{
#' lg <- lagos_load_collins_2017()
#' }
lagos_load_collins_2017 <- function(fpath = NA){
  destdir <- rappdirs::user_data_dir("LAGOSNE")
  dir.create(destdir, showWarnings = FALSE)

  if(is.na(fpath)){
    read.csv(paste0(destdir, .Platform$file.sep, "collins_2017.csv"),
             stringsAsFactors = FALSE)
  }else{
    read.csv(fpath, stringsAsFactors = FALSE)
  }
}
