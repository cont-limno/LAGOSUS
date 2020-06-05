#' Interface to the LAGOSUS lakes database
#' @name LAGOSUS-package
#' @aliases LAGOSUS
#' @docType package
#' @importFrom magrittr %>%
#' @title R interface to the LAGOSUS lakes database
#' @author \email{stachel2@msu.edu}
NULL

#' Latest LAGOSUS module versions
#' @name lagosus_version
#' @export
#' @examples
#' lagosus_version()
lagosus_version <- function(){
  data.frame(modules = c("locus", "limno", "geo", "depth"),
             versions = c("1.1","0","0","0"),
             stringsAsFactors = FALSE)
  }

#' LAGOSUS Lake information
#'
#' Includes information about lake identifiers used in LAGOS-US, information
#' about lake location (i.e., lat, lon, and elevation), and the zone IDs for
#' each spatial division containing the lake (e.g., state, county, hydrologic
#' unit).
#'
#' @eval c("@details", get_table_metadata("locus", "lake_information"))
#'
#' @name locus_information
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake characteristics
#'
#' Includes derived metrics for each lake such as lake geometry (e.g., area,
#'  perimeter, shape metrics), lake connectivity (e.g., lake connectivity
#'  class, number of upstream lakes), and whether the lake is located within an
#'  area that was glaciated during the Late Wisconsin glaciation.
#'
#' @eval c("@details", get_table_metadata("locus", "lake_characteristics"))
#'
#' @name locus_characteristics
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake watersheds
#'
#' Includes identifiers, location, and geometry for the calculated watersheds (WS) and network
#' watersheds (NWS).
#'
#' @eval c("@details", get_table_metadata("locus", "lake_watersheds"))
#'
#' @name locus_watersheds
#' @docType data
#' @keywords datasets
#' @aliases watersheds
NULL

#' LAGOSUS Identifier links
#'
#' @description Includes single or multiple identifiers per lake from other commonly used
#'  national-scale data products including: Water Quality Portal (WQP),
#'  Geographic Names Information System (GNIS), NHD MR Plusv2, LAGOS-NE, and
#'  the EPA National Lake Assessment surveys from 2007 and 2012.
#'
#' @eval c("@details", get_table_metadata("locus", "lake_link"))
#'
#' @name locus_link
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Data sources
#'
#' @eval get_table_metadata("locus", "source_table_locus")
#'
#' @name locus_source
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Depth data
#'
#' @eval c("@details", get_table_metadata("depth", "depth"))
#'
#' @name depth
#' @docType data
#' @keywords datasets
NULL
