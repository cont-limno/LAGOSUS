#' Interface to the LAGOSUS lakes database
#' @name LAGOSUS-package
#' @aliases LAGOSUS
#' @docType package
#' @importFrom magrittr %>%
#' @title R interface to the LAGOSUS lakes database
#' @author \email{stachel2@msu.edu}
NULL

#' Latest LAGOSUS module versions
#'
#' @name lagosus_version
#' @details Defaults to the latest release version of each data module. Can be
#' overridden using the `LAGOSUS_LOCUS_VER`, `LAGOSUS_LIMNO_VER`,
#' `LAGOSUS_GEO_VER`, or `LAGOSUS_DEPTH_VER` environment variables; see example
#' below. Using different environment variables for the same module in a single
#' interactive session will not invalidate the `lagosus_load` cache. Manually
#' specify module version numbers if needing to load multiple different module
#' versions.
#' @export
#'
#' @examples \dontrun{
#' # use defaults
#' lagosus_version()
#'
#' # custom setting
#' Sys.setenv(LAGOSUS_DEPTH_VER = 0)
#' lagosus_version()
#'
#' # revert to defaults
#' Sys.setenv(LAGOSUS_DEPTH_VER = "")
#' lagosus_version()
#' }
lagosus_version <- function(){
  res_defaults <- data.frame(
    modules = c("locus", "limno", "geo", "depth"),
    versions = c("1.0","2.1","1.0","0.1"),
    stringsAsFactors = FALSE)

  env_vars <- Sys.getenv(
    paste0("LAGOSUS_", c("LOCUS", "LIMNO", "GEO", "DEPTH"), "_VER"), "")
  env_vars <- data.frame(
    modules = tolower(stringr::str_extract(names(env_vars),
                                           "(?<=LAGOSUS_)(.*)(?=_VER)")),
    versions = as.character(env_vars),
    stringsAsFactors = FALSE)

  if (any(!env_vars$versions == "")) {
    env_vars$defaults <- res_defaults$versions
    res               <- dplyr::mutate(env_vars,
                                       versions = dplyr::case_when(
                                         versions == "" ~ defaults,
                                         TRUE ~ versions))
  }else{
    res <- res_defaults
  }

  res
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
#' @name lake_information
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
#' @name lake_characteristics
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
#' @name lake_watersheds
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
#' @name lake_link
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Data sources
#'
#' @eval get_table_metadata("locus", "source_table_locus")
#'
#' @name source_table_locus
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Chemical and physical data
#'
#' @eval get_table_metadata("limno", "site_chemicalphysical")
#'
#' @name site_chemicalphysical
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Contaminant data
#'
#' @eval get_table_metadata("limno", "site_contaminants")
#'
#' @name site_contaminants
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS LIMNO information
#'
#' @eval get_table_metadata("limno", "site_information")
#'
#' @name site_information
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS LIMNO Data sources
#'
#' @eval get_table_metadata("limno", "source_table_limno")
#'
#' @name source_table_limno
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

# #' LAGOSUS Terrain data
# #'
# #' @eval get_table_metadata("geo", "zone_terrain")
# #'
# #' @name zone_terrain
# #' @docType data
# #' @keywords datasets
# NULL

# #' LAGOSUS Soils data
# #'
# #' @eval get_table_metadata("geo", "zone_soils")
# #'
# #' @name zone_soils
# #' @docType data
# #' @keywords datasets
# NULL
