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
#' @details
#' \tabular{lll}{
#' \bold{Variable name} \tab \bold{Variable description} \tab \bold{Units} \cr
#' lagoslakeid        \tab unique lake identifier developed by LAGOS-US                                                                                                                                                                              \tab               \cr
#'   lake_nhdid         \tab the unique 'Permanent_identifier' from the NHD for each LAGOS lake                                                                                                                                                        \tab               \cr
#'   lake_nhdfcode      \tab NHD five-digit integer code with feature code plus additional characteristics/values                                                                                                                                      \tab               \cr
#'   lake_nhdftype      \tab NHD three-digit integer code providing a unique identifier of feature type for the waterbody                                                                                                                              \tab               \cr
#'   lake_reachcode     \tab reach code assigned to the water feature by the NHD                                                                                                                                                                       \tab               \cr
#'   lake_namegnis      \tab lake name from the gnis database                                                                                                                                                                                          \tab               \cr
#'   lake_namelagos     \tab lake name from a combination of data sources (gnis, wqp, etc.)                                                                                                                                                            \tab               \cr
#'   lake_onlandborder  \tab flag indicating lake polygon is adjacent to or crosses the border with Canada or Mexico                                                                                                                                   \tab               \cr
#'   lake_ismultipart   \tab flag indicating that the focal lake polygon is multipart                                                                                                                                                                  \tab               \cr
#'   lake_missingws     \tab flag indicating that the lake's watershed (both ws and nws) was not delineated                                                                                                                                            \tab               \cr
#'   lake_shapeflag     \tab flag indicating lake polygon shape is excessively angular (e.g., triangle, rectangle) or elongate (very thin relative to length); may indicate the lake is not natural in origin (angular) or is more riverine (elongate) \tab               \cr
#'   lake_lat_decdeg    \tab latitude of centroid of the NHD lake polygon in decimal degrees (NAD83)                                                                                                                                                   \tab decimal degree\cr
#'   lake_lon_decdeg    \tab longitude of  centroid of the NHD lake polygon in decimal degrees (NAD83)                                                                                                                                                 \tab decimal degree\cr
#'   lake_elevation_m   \tab the elevation of the lake polygon centroid, in meters (referenced to the North American Vertical Datum of 1988 (NAVD88) and obtained from the National Elevation Dataset)                                                 \tab meter         \cr
#'   lake_centroidstate \tab abbreviation of state containing the lake centroid                                                                                                                                                                        \tab               \cr
#'   lake_states        \tab abbreviation(s) of state(s) intersecting the focal lake polygon                                                                                                                                                           \tab               \cr
#'   lake_county        \tab NULLme of county containing the focal lake polygon centroid                                                                                                                                                               \tab               \cr
#'   lake_countyfips    \tab Federal Information Processing Standard (FIPS) code for the county containing the focal lake polygon centroid                                                                                                             \tab               \cr
#'   lake_huc12         \tab the code for the HUC12 containing the lake centroid                                                                                                                                                                       \tab               \cr
#'   buff100_zoneid     \tab unique 100 m buffer identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                                                                             \tab               \cr
#'   buff500_zoneid     \tab unique 500 m buffer identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                                                                             \tab               \cr
#'   ws_zoneid          \tab unique watershed identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                                                                                \tab               \cr
#'   nws_zoneid         \tab unique network watershed identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                                                                        \tab               \cr
#'   hu12_zoneid        \tab unique identifier assigned by LAGOS-US for zones in the spatial division HU12                                                                                                                                             \tab               \cr
#'   hu8_zoneid         \tab unique identifier assigned by LAGOS-US for zones in the spatial division HU8                                                                                                                                              \tab               \cr
#'   hu4_zoneid         \tab unique identifier assigned by LAGOS-US for zones in the spatial division HU4                                                                                                                                              \tab               \cr
#'   county_zoneid      \tab unique identifier assigned by LAGOS-US for zones in the spatial division county                                                                                                                                           \tab               \cr
#'   state_zoneid       \tab unique identifier assigned by LAGOS-US for zones in the spatial division state                                                                                                                                            \tab               \cr
#'   epanutr_zoneid     \tab unique identifier assigned by LAGOS-US for zones in the spatial division EPA Nutrient Ecoregions                                                                                                                          \tab               \cr
#'   omernik3_zoneid    \tab unique identifier assigned by LAGOS-US for zones in the spatial division Omernik Level III Ecoregions                                                                                                                     \tab               \cr
#'   wwf_zoneid         \tab unique identifier assigned by LAGOS-US for zones in the spatial division World Wildlife Fund ecoregions                                                                                                                   \tab               \cr
#'   mlra_zoneid        \tab unique identifier assigned by LAGOS-US for zones in the spatial division Major Land Areas                                                                                                                                 \tab               \cr
#'   bailey_zoneid      \tab unique identifier assigned by LAGOS-US for zones in the spatial division Baileyâ€™s Ecoregions                                                                                                                            \tab               \cr
#'   neon_zoneid        \tab unique identifier assigned by LAGOS-US for zones in the spatial division National Ecological Observation Network                                                                                                          \tab
#' }
#'
#' @name locus_information
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake characteristics
#'
#' @details
#' \tabular{lll}{
#' \bold{Variable name} \tab \bold{Variable description} \tab \bold{Units} \cr
#' lagoslakeid                     \tab unique lake identifier developed by LAGOS-US                                                                                                                                    \tab        \cr
#'   lake_waterarea_ha               \tab surface area of lake waterbody polygon from NHD (excludes islands)                                                                                                              \tab hectare\cr
#'   lake_totalarea_ha               \tab surface area within outer boundary of lake waterbody polygon from NHD (includes islands)                                                                                        \tab hectare\cr
#'   lake_islandarea_ha              \tab surface area of islands within outer boundary of lake waterbody polygon from NHD                                                                                                \tab hectare\cr
#'   lake_perimeter_m                \tab perimeter of outer boundary of lake waterbody polygon from the NHD (excludes islands)                                                                                           \tab meter  \cr
#'   lake_islandperimeter_m          \tab perimeter of islands within the lake waterbody polygon from the NHD                                                                                                             \tab meter  \cr
#'   lake_shorelinedevfactor         \tab shoreline development factor = lake_perimeter / (2*?(?*waterarea))                                                                                                              \tab        \cr
#'   lake_mbgconhull_length_m        \tab the longest distance entirely within the lake polygon between any two vertices of the minimum bounding geometry convex hull that encloses the lake polygon                      \tab meter  \cr
#'   lake_mbgconhull_width_m         \tab the shortest distance entirely within the lake polygon between any two vertices of the minimum bounding geometry convex hull that encloses the lake polygon                     \tab meter  \cr
#'   lake_mbgconhull_orientation_deg \tab orientation (from 0 to 180 decimal degrees clockwise from north) of the longest line connecting two vertices entirely within both the convex hull and the lake polygon          \tab degree \cr
#'   lake_mbgrect_length_m           \tab length of the minimum bounding geometry rectangle by area enclosing the lake polygon                                                                                            \tab meter  \cr
#'   lake_mbgrect_width_m            \tab width of the minimum bounding geometry rectangle by area enclosing the lake polygon                                                                                             \tab meter  \cr
#'   lake_mbgrect_arearatio          \tab ratio between lake_waterarea_ha (* 10000 m^2/ha) and the area of the minimum bounding rectangle by area of the lake polygon; value near 1 indicates lake shape is rectangular
#'  \tab        \cr
#'   lake_meanwidth_m                \tab mean width of the lake calculated as lake water area (lake_area_ha* 10000 m^2/ha) divided by the convex hull length of the focal lake polygon (lake_mbgconhull_length_m)        \tab meter  \cr
#'   lake_connectivity_class         \tab hydrologic connectivity class of the focal lake determined from the NHD network considering both permanent and intermittent/ephemeral flow                                      \tab        \cr
#'   lake_connectivity_fluctuates    \tab indicates whether the lake's connectivity classification depends on non-permanent flow                                                                                          \tab        \cr
#'   lake_connectivity_permanent     \tab hydrologic connectivity class of the focal lake determined from the NHD network considering only permanent flow                                                                 \tab        \cr
#'   lake_lakes1ha_upstream_ha       \tab total area of lakes >= 1 ha upstream of the focal lake, connected via surface streams                                                                                           \tab hectare\cr
#'   lake_lakes4ha_upstream_ha       \tab total area of lakes >= 4 ha upstream of the focal lake, connected via surface streams                                                                                           \tab hectare\cr
#'   lake_lakes10ha_upstream_ha      \tab total area of lakes >= 10 ha upstream of the focal lake, connected via surface streams                                                                                          \tab hectare\cr
#'   lake_lakes1ha_upstream_n        \tab count of lakes >= 1 ha upstream of the focal lake, connected via surface streams                                                                                                \tab count  \cr
#'   lake_lakes4ha_upstream_n        \tab count of lakes >= 4 ha upstream of the focal lake, connected via surface streams                                                                                                \tab count  \cr
#'   lake_lakes10ha_upstream_n       \tab count of lakes >= 10 ha upstream of the focal lake, connected via surface streams                                                                                               \tab count  \cr
#'   lake_glaciatedlatewisc          \tab glaciation status during the Late Wisconsin glaciation (status = Glaciated if any part of the lake polygon is inside the glacial extent)                                        \tab
#' }
#'
#' @name locus_characteristics
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake watersheds
#'
#' @details
#' \tabular{lll}{
#' \bold{Variable name} \tab \bold{Variable description} \tab \bold{Units} \cr
#' lagoslakeid                    \tab unique lake identifier developed by LAGOS-US                                                                                                                          \tab               \cr
#'   ws_zoneid                      \tab unique watershed identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                            \tab               \cr
#'   nws_zoneid                     \tab unique network watershed identifier assigned by LAGOS-US, equivalent to the focal lake lagoslakeid                                                                    \tab               \cr
#'   ws_subtype                     \tab LAGOS watershed subtype class for the watershed (LC=local catchment, DWS=drainage-watershed, IDWS=inter-drainage-lake watershed)                                      \tab               \cr
#'   ws_equalsnws                   \tab flag indicating that the ws is equivalent to the nws (=Y where there are no upstream lakes > 10 ha and where lake connectivity class does not equal drainagelk)       \tab               \cr
#'   ws_onlandborder                \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                                                       \tab               \cr
#'   ws_oncoast                     \tab flag indicating the zone is adjacent to the coastline                                                                                                                 \tab               \cr
#'   ws_inusa_pct                   \tab percent of the zone (i.e., polygon) that is within the US border                                                                                                      \tab percent       \cr
#'   ws_includeshu4inlet            \tab flag indicating the ws extends beyond the focal HU4 and is connected via an inlet to an adjoining HU4                                                                 \tab               \cr
#'   ws_ismultipart                 \tab flag indicating that the focal zone polygon is multipart                                                                                                              \tab               \cr
#'   ws_sliverflag                  \tab flag indicating extreme cases where the watershed is comprised of slivers due to flat or constrained terrain that may not accurately reflect surface drainage         \tab               \cr
#'   nws_onlandborder               \tab flag indicating zone is adjacent to or crosses the border with Canada or Mexico                                                                                       \tab               \cr
#'   nws_oncoast                    \tab flag indicating the zone is adjacent to the coastline                                                                                                                 \tab               \cr
#'   nws_inusa_pct                  \tab percent of the zone (i.e., polygon) that is within the US border                                                                                                      \tab percent       \cr
#'   nws_includeshu4inlet           \tab flag indicating the nws extends beyond the focal HU4 and is connected via an inlet to an adjoining HU4                                                                \tab               \cr
#'   nws_ismultipart                \tab flag indicating that the focal zone polygon is multipart                                                                                                              \tab               \cr
#'   ws_states                      \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                                                             \tab               \cr
#'   ws_focallakewaterarea_ha       \tab surface area of focal lake for which the watershed (WS) is calculated                                                                                                 \tab hectare       \cr
#'   ws_area_ha                     \tab area of zone polygon                                                                                                                                                  \tab hectare       \cr
#'   ws_perimeter_m                 \tab perimeter of zone polygon including perimeters of any internal 'holes'                                                                                                \tab meter         \cr
#'   ws_lake_arearatio              \tab ratio between watershed area and lake water area                                                                                                                      \tab               \cr
#'   ws_mbgconhull_length_m         \tab the longest distance entirely within the ws polygon between any two vertices of the minimum bounding geometry convex hull that encloses the ws polygon                \tab meter         \cr
#'   ws_mbgconhull_width_m          \tab the shortest distance entirely within the ws polygon between any two vertices of the minimum bounding geometry convex hull that encloses the ws polygon               \tab meter         \cr
#'   ws_mbgconhull_orientation_deg  \tab orientation (from 0 to 180 decimal degrees clockwise from north) of the longest line connecting two vertices entirely within both the convex hull and the ws polygon  \tab degree        \cr
#'   ws_meanwidth_m                 \tab mean width of the ws calculated as ws area (ws_area_ha* 10000 m^2/ha) divided by the convex hull length of the focal ws polygon (ws_mbgconhull_length_m)              \tab meter         \cr
#'   ws_lat_decdeg                  \tab latitude of the centroid of the focal lake polygon in decimal degrees (NAD83)                                                                                         \tab decimaldegree \cr
#'   ws_lon_decdeg                  \tab longitude of the centroid of the focal lake polygon in decimal degrees (NAD83)                                                                                        \tab decimaldegree \cr
#'   nws_states                     \tab abbreviation(s) of state(s) intersecting the zone polygon                                                                                                             \tab               \cr
#'   nws_focallakewaterarea_ha      \tab surface area of focal lake for which the network watershed (NWS) is calculated                                                                                        \tab hectare       \cr
#'   nws_area_ha                    \tab area of zone polygon                                                                                                                                                  \tab hectare       \cr
#'   nws_perimeter_m                \tab perimeter of zone polygon including perimeters of any internal 'holes'                                                                                                \tab meter         \cr
#'   nws_lake_arearatio             \tab ratio between network watershed area and lake water area                                                                                                              \tab               \cr
#'   nws_mbgconhull_length_m        \tab the longest distance entirely within the nws polygon between any two vertices of the minimum bounding geometry convex hull that encloses the nws polygon              \tab meter         \cr
#'   nws_mbgconhull_width_m         \tab the shortest distance entirely within the nws polygon between any two vertices of the minimum bounding geometry convex hull that encloses the nws polygon             \tab meter         \cr
#'   nws_mbgconhull_orientation_deg \tab orientation (from 0 to 180 decimal degrees clockwise from north) of the longest line connecting two vertices entirely within both the convex hull and the nws polygon \tab degree        \cr
#'   nws_meanwidth_m                \tab mean width of the nws calculated as nws area (nws_area_ha* 10000 m^2/ha) divided by the convex hull length of the focal nws polygon (nws_mbgconhull_length_m)         \tab meter         \cr
#'   nws_lat_decdeg                 \tab latitude of the centroid of the focal lake polygon in decimal degrees (NAD83)                                                                                         \tab decimal degree\cr
#'   nws_lon_decdeg                 \tab longitude of the centroid of the focal lake polygon in decimal degrees (NAD83)                                                                                        \tab decimal degree
#' }
#'
#' @name locus_watersheds
#' @docType data
#' @keywords datasets
#' @aliases watersheds
NULL

#' LAGOSUS Identifier links
#'
#' @details
#' \tabular{lll}{
#' \bold{Variable name} \tab \bold{Variable description} \tab \bold{Units} \cr
#' nhdhr_gnisid                     \tab unique identifier assigned by GNIS                                                                                                                        \tab                 \cr
#'   lagoslakeid                      \tab unique lake identifier developed by LAGOS-US                                                                                                              \tab                 \cr
#'   lake_nhdid                       \tab the unique 'Permanent_identifier' from the NHD for each LAGOS lake                                                                                        \tab                 \cr
#'   lake_reachcode                   \tab reach code assigned to the water feature by the NHD                                                                                                       \tab                 \cr
#'   lake_namegnis                    \tab lake name from the gnis database                                                                                                                          \tab                 \cr
#'   lake_namelagos                   \tab lake name from a combination of data sources (gnis, wqp, etc.)                                                                                            \tab                 \cr
#'   lake_county                      \tab NULLme of county containing the focal lake polygon centroid                                                                                               \tab                 \cr
#'   lake_countyfips                  \tab Federal Information Processing Standard (FIPS) code for the county containing the focal lake polygon centroid                                             \tab                 \cr
#'   lake_lat_decdeg                  \tab latitude of centroid of the NHD lake polygon in decimal degrees (NAD83)                                                                                   \tab decimal degree  \cr
#'   lake_lon_decdeg                  \tab longitude of  centroid of the NHD lake polygon in decimal degrees (NAD83)                                                                                 \tab decimal degree  \cr
#'   lake_centroidstate               \tab abbreviation of state containing the lake centroid                                                                                                        \tab                 \cr
#'   nhdhr_area_sqkm                  \tab NHD feature area in square kilometers                                                                                                                     \tab square kilometer\cr
#'   nhdhr_fdate                      \tab date of last feature modification in National Hydrography Dataset                                                                                         \tab                 \cr
#'   lagosus_legacysiteid             \tab Unique site/lake identifier from the original LAGOS-US water quality source dataset. This is not standardized and each source dataset has its own system. \tab                 \cr
#'   lagosus_legacysitelabel          \tab the column/field name used by the source dataset to label the legacy lake identifier                                                                      \tab                 \cr
#'   lagosus_legacyprogram            \tab the program name assigned in LAGOS_US to identify the source dataset provider                                                                             \tab                 \cr
#'   wqp_monitoringlocationidentifier \tab a designator used to describe the unique name, number, or code assigned to identify the monitoring location                                               \tab                 \cr
#'   wqp_monitoringlocationname       \tab the designator specified by the sampling organization for the site at which sampling or other activities are conducted                                    \tab                 \cr
#'   wqp_providername                 \tab the source system that provided data to the Water Quality Portal (NWIS, STORET, STEWARDS, etc)                                                            \tab                 \cr
#'   nhdplusv2_comid                  \tab common identifier of the NHD Waterbody feature                                                                                                            \tab                 \cr
#'   nhdplusv2_reachcode              \tab NHDplus v2 reach code assigned to the water feature.                                                                                                      \tab                 \cr
#'   nhdplusv2_area_sqkm              \tab NHD feature area in square kilometers                                                                                                                     \tab square kilometer\cr
#'   lagosne_lagoslakeid              \tab unique lake identifier developed for LAGOS-NE                                                                                                             \tab                 \cr
#'   lagosne_legacysiteid             \tab Unique site/lake identifier from the original LAGOS-NE water quality source dataset. This is not standardized and each source dataset has its own system. \tab                 \cr
#'   nla2007_siteid                   \tab lake site identifier from National Lakes Assessment 2007 survey                                                                                           \tab                 \cr
#'   nla2012_siteid                   \tab lake site identifier from National Lakes Assessment 2012 survey                                                                                           \tab                 \cr
#'   nhdplusv2_lakes_n                \tab count of WQP sites within the LAGOS-US lake                                                                                                               \tab count           \cr
#'   lagosne_lakes_n                  \tab count of NHDPlusV2 polygons matching the LAGOS-US lagoslakeid                                                                                             \tab count           \cr
#'   wqp_sites_n                      \tab count of LAGOS-NE lagoslakeids matching the LAGOS-US lagoslakeid                                                                                          \tab count           \cr
#'   lagosus_legacyids_n              \tab count of all LAGOS-US legacy (original) sampling site identifiers linked to the lagoslakeid in this table                                                 \tab count
#' }
#'
#' @name locus_link
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Data sources
#'
#' @details
#' \tabular{lll}{
#' \bold{Variable name} \tab \bold{Variable description} \tab \bold{Units} \cr
#' source_code               \tab a short codename used for the source dataset in LAGOS-US variables or metadata                                                   \tab \cr
#'   source_name               \tab the name of the source dataset                                                                                                   \tab \cr
#'   source_shortname          \tab the abbreviated name used to refer to the source dataset in LAGOS-US documentation                                               \tab \cr
#'   source_description        \tab a brief description of the source dataset                                                                                        \tab \cr
#'   source_provider           \tab the provider of the source dataset (government agency, publication citation, etc.)                                               \tab \cr
#'   source_citation           \tab the citation for the source dataset, including the download link used to acquire the dataset at the time of LAGOS-US creation    \tab \cr
#'   source_url                \tab The principal website associated with the source dataset. This may not be the same as the download URL included in the citation. \tab \cr
#'   source_metadata_url       \tab a website URL where metadata and data use guidance for the source dataset can be found                                           \tab \cr
#'   source_spatial_resolution \tab the spatial resolution of the source dataset, if applicable                                                                      \tab \cr
#'   source_time_period        \tab the time period captured by the source dataset, if applicable                                                                    \tab \cr
#'   source_access_date        \tab the date(s) the source dataset was acquired for use in creating LAGOS-US                                                         \tab \cr
#'   source_data_type          \tab the data value type contained in the source dataset, if applicable                                                               \tab
#' }
#'
#' @name locus_source
#' @docType data
#' @keywords datasets
NULL
