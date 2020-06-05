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
#' @eval get_table_metadata("locus", "lake_information")
#'
#' @name locus_information
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake characteristics
#'
#' @eval get_table_metadata("locus", "lake_characteristics")
#'
#' @name locus_characteristics
#' @docType data
#' @keywords datasets
NULL

#' LAGOSUS Lake watersheds
#'
#' @eval get_table_metadata("locus", "lake_watersheds")
#'
#' @name locus_watersheds
#' @docType data
#' @keywords datasets
#' @aliases watersheds
NULL

#' LAGOSUS Identifier links
#'
#' @eval get_table_metadata("locus", "lake_link")
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
#' @eval get_table_metadata("depth", "depth")
#'
#' @name depth
#' @docType data
#' @keywords datasets
NULL
