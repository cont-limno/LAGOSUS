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
             versions = c("0","0","0","0"),
             stringsAsFactors = FALSE)
  }

#' LAGOSUS Lake information
#'
#'\tabular{lll}{
#'  Lake information \tab lagoslakeid        \tab LAGOS sourced unique identifier for the focal lake                                                                              \cr
#'  Lake information \tab lake_nhdid         \tab the unique 'Permanent_identifier' from the NHD for each LAGOS lake                                                              \cr
#'  Lake information \tab lake_nhdfcode      \tab NHD five-digit integer code with feature code plus additional characteristics/values                                            \cr
#'  Lake information \tab lake_nhdftype      \tab NHD three-digit integer code providing a unique identifier of feature type for the waterbody                                    \cr
#'  Lake information \tab lake_reachcode     \tab NHD reachcode for stream reach intersecting the lake from NHD stream network                                                    \cr
#'  Lake information \tab lake_namegnis      \tab lake name from the gnis database                                                                                                \cr
#'  Lake information \tab lake_namelagos     \tab lake name from a combination of data sources (gnis, wqp, etc.)                                                                  \cr
#'  Lake information \tab ♦                  \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                 \cr
#'  Lake information \tab lake_ismultipart   \tab flag indicating that the focal lake polygon is multipart                                                                        \cr
#'  Lake information \tab lake_missingws     \tab flag indicating that the lake's watershed (ws or nws) was not delineated                                                        \cr
#'  Lake information \tab lake_shapeflag     \tab flag indicating lake polygon shape is excessively angular (e.g., triangle, rectangle) or elongate (very thin relative to length)\cr
#'  Lake information \tab lake_lat_decdeg    \tab latitude of centroid of the NHD lake polygon in decimal degrees (NAD83)                                                         \cr
#'  Lake information \tab lake_lon_decdeg    \tab longitude of  centroid of the NHD lake polygon in decimal degrees (NAD83)                                                       \cr
#'  Lake information \tab lake_centroidstate \tab abbreviation of state containing the lake centroid                                                                              \cr
#'  Lake information \tab lake_states        \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                       \cr
#'  Lake information \tab lake_huc12         \tab HUC12 of the WBD HU12 watershed containing the lake                                                                             \cr
#'  Lake information \tab buff100_zoneid     \tab unique 100m buffer zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                   \cr
#'  Lake information \tab buff500_zoneid     \tab unique 500m buffer zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                   \cr
#'  Lake information \tab ws_zoneid          \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                               \cr
#'  Lake information \tab nws_zoneid         \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                               \cr
#'  Lake information \tab hu12_zoneid        \tab unique HU12 zone identifier assigned by LAGOS for zone containing the focal lake                                                \cr
#'  Lake information \tab hu8_zoneid         \tab unique HU8 zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
#'  Lake information \tab hu4_zoneid         \tab unique HU4 zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
#'  Lake information \tab county_zoneid      \tab unique county zone identifier assigned by LAGOS for zone containing the focal lake                                              \cr
#'  Lake information \tab state_zoneid       \tab unique state zone identifier assigned by LAGOS for zone containing the focal lake                                               \cr
#'  Lake information \tab epanutr_zoneid     \tab unique EPA Nutrient Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                              \cr
#'  Lake information \tab omernik3_zoneid    \tab unique Omernik Level III Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                         \cr
#'  Lake information \tab wwf_zoneid         \tab unique WWF zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
  #'  Lake information \tab mlra_zoneid        \tab unique Major Land Resource Area zone identifier assigned by LAGOS for zone containing the focal lake                            \cr
  #'  Lake information \tab bailey_zoneid      \tab unique Bailey Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                                    \cr
  #'  Lake information \tab neon_zoneid        \tab unique NEON zone identifier assigned by LAGOS for zone containing the focal lake
  #'}


