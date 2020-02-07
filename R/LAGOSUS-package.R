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
#'@details
#'\tabular{ll}{
#' lagoslakeid        \tab LAGOS sourced unique identifier for the focal lake \cr
#' lake_nhdid         \tab the unique 'Permanent_identifier' from the NHD for each LAGOS lake \cr
#'  lake_nhdfcode      \tab NHD five-digit integer code with feature code plus additional characteristics/values                                            \cr
#'  lake_nhdftype      \tab NHD three-digit integer code providing a unique identifier of feature type for the waterbody                                    \cr
#'  lake_reachcode     \tab NHD reachcode for stream reach intersecting the lake from NHD stream network                                                    \cr
#'  lake_namegnis      \tab lake name from the gnis database                                                                                                \cr
#'  lake_namelagos     \tab lake name from a combination of data sources (gnis, wqp, etc.)                                                                  \cr
#'  ♦                  \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                 \cr
#'  lake_ismultipart   \tab flag indicating that the focal lake polygon is multipart                                                                        \cr
#'  lake_missingws     \tab flag indicating that the lake's watershed (ws or nws) was not delineated                                                        \cr
#'  lake_shapeflag     \tab flag indicating lake polygon shape is excessively angular (e.g., triangle, rectangle) or elongate (very thin relative to length)\cr
#'  lake_lat_decdeg    \tab latitude of centroid of the NHD lake polygon in decimal degrees (NAD83)                                                         \cr
#'  lake_lon_decdeg    \tab longitude of  centroid of the NHD lake polygon in decimal degrees (NAD83)                                                       \cr
#'  lake_centroidstate \tab abbreviation of state containing the lake centroid                                                                              \cr
#'  lake_states        \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                       \cr
#'  lake_huc12         \tab HUC12 of the WBD HU12 watershed containing the lake                                                                             \cr
#'  buff100_zoneid     \tab unique 100m buffer zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                   \cr
#'  buff500_zoneid     \tab unique 500m buffer zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                   \cr
#'  ws_zoneid          \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                               \cr
#'  nws_zoneid         \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                               \cr
#'  hu12_zoneid        \tab unique HU12 zone identifier assigned by LAGOS for zone containing the focal lake                                                \cr
#'  hu8_zoneid         \tab unique HU8 zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
#'  hu4_zoneid         \tab unique HU4 zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
#'  county_zoneid      \tab unique county zone identifier assigned by LAGOS for zone containing the focal lake                                              \cr
#'  state_zoneid       \tab unique state zone identifier assigned by LAGOS for zone containing the focal lake                                               \cr
#'  epanutr_zoneid     \tab unique EPA Nutrient Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                              \cr
#'  omernik3_zoneid    \tab unique Omernik Level III Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                         \cr
#'  wwf_zoneid         \tab unique WWF zone identifier assigned by LAGOS for zone containing the focal lake                                                 \cr
#'  mlra_zoneid        \tab unique Major Land Resource Area zone identifier assigned by LAGOS for zone containing the focal lake                            \cr
#'  bailey_zoneid      \tab unique Bailey Ecoregion zone identifier assigned by LAGOS for zone containing the focal lake                                    \cr
#'  neon_zoneid        \tab unique NEON zone identifier assigned by LAGOS for zone containing the focal lake
#' }
#'
#' @name locus_information
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake characteristics
#'
#' \tabular{ll}{
#'   lagoslakeid                     \tab LAGOS sourced unique identifier for the focal lake                                                                                                                                       \cr
#'   lake_elevation_m                \tab the elevation of the lake polygon centroid, in meters (referenced to the North American Vertical Datum of 1988 (NAVD88)) and obtained from the National Elevation Dataset                \cr
#'   lake_waterarea_ha               \tab surface area of lake waterbody polygon from NHD (excludes islands)                                                                                                                       \cr
#'   lake_totalarea_ha               \tab surface area within outer boundary of lake waterbody polygon from NHD (includes islands)                                                                                                 \cr
#'   lake_islandarea_ha              \tab surface area of islands within outer boundary of lake waterbody polygon from NHD                                                                                                         \cr
#'   lake_perimeter_m                \tab perimeter of outer boundary of lake waterbody polygon from the NHD (excludes islands)                                                                                                    \cr
#'   lake_islandperimeter_m          \tab perimeter of islands within the lake waterbody polygon from the NHD                                                                                                                      \cr
#'   lake_shorelinedevfactor         \tab shoreline development factor calculated as the lake_perimeter_m / (2*√(π*lake_waterarea_ha*10000))                                                                                       \cr
#'   lake_mbgconhull_length_m        \tab the longest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                   \cr
#'   lake_mbgconhull_width_m         \tab the shortest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                  \cr
#'   lake_mbgconhull_orientation_deg \tab orientation (from 0 to 180 degrees) of the line connecting the antipodal pairs defining the longest distance within the minimum bounding geometry convex hull enclosing the zonal polygon\cr
#'   lake_mbgrect_length_m           \tab length of the minimum bounding geometry rectangle by area enclosing the zonal polygon                                                                                                    \cr
#'   lake_mbgrect_width_m            \tab width of the minimum bounding geometry rectangle by area enclosing the zonal polygon                                                                                                     \cr
#'   lake_mbgrect_arearatio          \tab ratio between lake_waterarea_ha (* 10000 m^2/ha) and the area of the minimum bounding rectangle by area of the zonal polygon                                                             \cr
#'   lake_meanwidth_m                \tab lake water area (* 10000 m^2/ha) divided by the convex hull length of the focal lake polygon                                                                                             \cr
#'   lake_connectivity_class         \tab hydrologic connectivity class of the focal lake determined from the NHD network considering both permanent and intermittent/ephemeral flow                                               \cr
#'   lake_connectivity_fluctuates    \tab indicates whether the lake's connectivity classification depends on non-permanent flow                                                                                                   \cr
#'   lake_connectivity_permanent     \tab hydrologic connectivity class of the focal lake determined from the NHD network considering only permanent flow                                                                          \cr
#'   lake_lakes1ha_upstream_ha       \tab total area of lakes >= 1 ha upstream of the focal lake, connected via surface streams                                                                                                    \cr
#'   lake_lakes4ha_upstream_ha       \tab total area of lakes >= 4 ha upstream of the focal lake, connected via surface streams                                                                                                    \cr
#'   lake_lakes10ha_upstream_ha      \tab total area of lakes >= 10 ha upstream of the focal lake, connected via surface streams                                                                                                   \cr
#'   lake_lakes1ha_upstream_n        \tab count of lakes >= 1 ha upstream of the focal lake, connected via surface streams                                                                                                         \cr
#'   lake_lakes4ha_upstream_n        \tab count of lakes >= 4 ha upstream of the focal lake, connected via surface streams                                                                                                         \cr
#'   lake_lakes10ha_upstream_n       \tab number per ha of lakes >= 10 ha upstream of the focal lake, connected via surface streams                                                                                                \cr
#'   lake_glaciatedlatewisc          \tab glaciation status during the Late Wisconsin glaciation
#' }
#'
#' @name locus_characteristics
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake watersheds
#'
#' \tabular{ll}{
#'   lagoslakeid                    \tab LAGOS sourced unique identifier for the focal lake of the zone                                                                                                                           \cr
#'   ws_zoneid                      \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                                                                                        \cr
#'   nws_zoneid                     \tab unique zone identifier equivalent to the focal lake lagoslakeid assigned by LAGOS                                                                                                        \cr
#'   ws_subtype                     \tab LAGOS watershed sub-type classification for the watershed                                                                                                                                \cr
#'   ws_equalsnws                   \tab flag indicating that the focal zone polygon is multipart                                                                                                                                 \cr
#'   ws_onlandborder                \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                                                                          \cr
#'   ws_oncoast                     \tab flag indicating the zone is adjacent to the coastline                                                                                                                                    \cr
#'   ws_inusa_pct                   \tab percent of the zone (i.e., polygon) that is within the US border                                                                                                                         \cr
#'   ws_includeshu4inlet            \tab flag indicating the ws extends beyond the focal HU4 and is connected via an inlet to an adjoining HU4                                                                                    \cr
#'   ws_ismultipart                 \tab flag indicating that the zonal polygon is multipart                                                                                                                                      \cr
#'   ws_sliver_flag                 \tab NA                                                                                                                                                                                       \cr
#'   nws_onlandborder               \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                                                                          \cr
#'   nws_oncoast                    \tab flag indicating the zone is adjacent to the coastline                                                                                                                                    \cr
#'   nws_inusa_pct                  \tab percent of the zone (i.e., polygon) that is within the US border                                                                                                                         \cr
#'   nws_includeshu4inlet           \tab flag indicating the nws extends beyond the focal HU4 and is connected via an inlet to an adjoining HU4                                                                                   \cr
#'   nws_ismultipart                \tab flag indicating that the zonal polygon is multipart                                                                                                                                      \cr
#'   ws_states                      \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                                                                                \cr
#'   ws_focallakewaterarea_ha       \tab surface area of focal lake for which the watershed (WS) is calculated                                                                                                                    \cr
#'   ws_area_ha                     \tab area of focal zone polygon                                                                                                                                                               \cr
#'   ws_perimeter_m                 \tab perimeter of the focal zone polygon including perimeters of any internal 'holes'                                                                                                         \cr
#'   ws_lake_arearatio              \tab NA                                                                                                                                                                                       \cr
#'   ws_mbgconhull_length_m         \tab the longest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                   \cr
#'   ws_mbgconhull_width_m          \tab the shortest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                  \cr
#'   ws_mbgconhull_orientation_deg  \tab orientation (from 0 to 180 degrees) of the line connecting the antipodal pairs defining the longest distance within the minimum bounding geometry convex hull enclosing the zonal polygon\cr
#'   ws_meanwidth_m                 \tab ws area (* 10000 m^2/ha) divided by the ws convex hull length of the focal zone polygon                                                                                                  \cr
#'   nws_states                     \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                                                                                \cr
#'   nws_focallakewaterarea_ha      \tab surface area of focal lake for which the watershed (NWS) is calculated                                                                                                                   \cr
#'   nws_area_ha                    \tab area of zone polygon                                                                                                                                                                     \cr
#'   nws_perimeter_m                \tab perimeter of the focal zone polygon including perimeters of any internal 'holes'                                                                                                         \cr
#'   nws_lake_arearatio             \tab NA                                                                                                                                                                                       \cr
#'   nws_mbgconhull_length_m        \tab the longest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                   \cr
#'   nws_mbgconhull_width_m         \tab the shortest distance between any two vertices of the minimum bounding geometry convex hull enclosing the zonal polygon                                                                  \cr
#'   nws_mbgconhull_orientation_deg \tab orientation (from 0 to 180 degrees) of the line connecting the antipodal pairs defining the longest distance within the minimum bounding geometry convex hull enclosing the zonal polygon\cr
#'   nws_meanwidth_m                \tab nws area (* 10000 m^2/ha) divided by the nws convex hull length of the focal zone polygon
#' }
#'
#' @name locus_ws
#' @docType data
#' @keywords datasets
#' #' @aliases watersheds
NULL
