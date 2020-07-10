#' Load LAGOSUS data
#'
#' Load LAGOSUS data from local system files
#'
#' @param modules character vector of module names. One or more of "locus", "limno", "geo", or "depth.
#' @param versions character LAGOSUS database version strings. Defaults to \code{\link{lagosus_version}}
#' @param geo_tables character vector of geo module table names
#' @param fpath file.path to LAGOSUS data store. Defaults to lagosus_path()
#' @export
#' @importFrom rappdirs user_data_dir
#' @importFrom qs qread
#' @importFrom memoise memoise
#'
#' @examples \dontrun{
#' # works
#' lg <- lagosus_load("locus")
#' lg <- lagosus_load(modules = c("locus", "depth"), versions = c(0, 1))
#' lg <- lagosus_load(modules = c("locus", "depth"))
#' lg <- lagosus_load(modules = c("locus", "depth"), versions = c(0, NA))
#'
#' # errors
#' # lg <- lagosus_load()
#' # lg <- lagosus_load(modules = c("locus", "depth"), versions = c(0))
#' }
lagosus_load <- function(modules = NULL,
                                          versions = NULL,
                                          geo_tables = NA,
                                          fpath = NA){

  if (is.na(fpath)) {fpath <- lagosus_path()}

  # error if no modules specified
  if (is.null(modules)) {
    stop("Must specify one or more modules by name: locus, depth, geo, limno.")
  }

  modules_raw <- c("locus", "limno", "geo", "depth")
  modules_query <- modules_raw[modules_raw %in% modules]

  # sanity check of specified module names
  if (any(!(modules %in% c("locus", "limno", "geo", "depth")))) {
    # are they true module names?
    stop(paste0("Module '",  modules, "' not found. Please specify one or more modules by name: locus, depth, geo, limno. Alternatively, try running the `lagosus_get` command."))
  }
  # TODO are there <= 4 specified?
  # have versions been specified for all requested modules?

  # error if length > 0 but not equal to modules
  if (length(versions) != 0 & length(versions) != length(modules)) {
    stop("Specified versions must be of the same length as requested modules.
  Passing a value of NA for a position will default to the latest version.")
  }

  # assign defaults and message if length == 0
  if (length(versions) == 0) {
    versions <- dplyr::pull(
      dplyr::filter(lagosus_version(), modules == modules_query),
      versions)

    if("defaults" %in% names(lagosus_version())){
      message(paste0(
        "Module version(s) not specified, reading from environment variable(s) as ",
        paste0(paste0(modules_query, " = ", versions), collapse = " and ")
      ))
    }else{
      message(paste0(
        "Module version(s) not specified, defaulting to ",
        paste0(paste0(modules_query, " = ", versions), collapse = " and ")
        ))
    }
  }

  # TODO assign defaults to NA values (and print message)

  # TODO catch module versions if they don't exist

  # TODO if geo has been requested have geo_tables been specified?
  #   error if not
  # are geo_tables true table names?
  #   error if not

  # iterate through specified modules
  res <- list()

  if("locus" %in% modules_query){
    locus_path <- file.path(fpath,
                            paste0("locus_",
                                   versions[which(modules_query == "locus")],
                                   ".qs"))
    locus <- qs::qread(locus_path)
    res[["locus"]] <- locus
  }

  if("depth" %in% modules_query){
    depth_path <- file.path(fpath,
                            paste0("depth_",
                                   versions[which(modules_query == "depth")],
                                   ".qs"))
    depth <- qs::qread(depth_path)
    res[["depth"]] <- depth
  }

  res
}
