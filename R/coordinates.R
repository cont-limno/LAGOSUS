
#' Convert a LAGOSUS flat file into a spatial object
#'
#' This function turns a data.frame into a spatial object using a reasonable
#'  default projection.
#'
#' @param dt data.frame
#' @param latname character name of latitude column; default is "lake_lat_decdeg"
#' @param longname character name of longitude column; default is "lake_lon_decdeg"
#' @param crs numeric epsg code; default is 4326 WGS84-lat-long
#' @importFrom sf st_as_sf
#' @examples \dontrun{
#' dt <- lagosus_load("locus")
#' res <- coordinatize(dt$locus$locus_information)
#'
#' library(maps)
#' map("state", xlim = c(-97.90363, -66.99892), ylim = c(34.61761, 49.41941))
#' plot(res$geometry, add = TRUE, pch = 19, cex = 0.05)
#' }
coordinatize <- function(dt, latname = "lake_lat_decdeg",
                         longname = "lake_lon_decdeg", crs = 4326){

  dt   <- sf::st_as_sf(dt, coords = c(longname, latname), crs = crs,
                       remove = FALSE)
  dt
}
