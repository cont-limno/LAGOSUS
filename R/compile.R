
#'@name lagosus_compile
#'@title Compile LAGOSUS data
#'
#'@description Compile LAGOSUS data from component flat files. This function should rarely be called directly outside of manual updating of source data.
#'
#'@param limno_version character LAGOSUS database version string
#'@param limno_folder file.path to limno export folder
#'@param geo_version character LAGOSUS database version string
#'@param geo_folder file.path to geo export folder
#'@param locus_version character LAGOSUS database version string
#'@param locus_folder file.path to locus export folder
#'@param depth_version character LAGOSUS database version string
#'@param depth_folder file.path to depth export folder
#'@param dest_folder file.path optional will default to the location returned
#'by \code{\link[rappdirs]{user_data_dir}}
#'
#'@importFrom utils read.table
#'@importFrom rappdirs user_data_dir
#'@export
#'
#'@examples \dontrun{
#'lagosus_compile(
#'  locus_version = "0",
#'  locus_folder = "~/Downloads/LAGOS-US-LOCUS-EXPORT",
#'  depth_version = "0",
#'  depth_folder = "~/Downloads/LAGOS-US-DEPTH-EXPORT",
#'  dest_folder = lagos_path())
#' }
#'
lagosus_compile <- function(locus_version = NA, locus_folder = NA,
                            limno_version = NA, limno_folder = NA,
                            geo_version = NA, geo_folder = NA,
                            depth_version = NA, depth_folder = NA,
                            dest_folder = NA){

  if(is.na(dest_folder)){
    stop("Set the dest_folder argument to a folder on your local machine. Recommended setting is lagos_path().")
  }

  ingest <- lagos_ingest(
    locus_version = locus_version, locus_folder = locus_folder,
    limno_version = limno_version, limno_folder = limno_folder,
    geo_version = geo_version, geo_folder = geo_folder,
    depth_version = depth_version, depth_folder = depth_folder)

  geo    <- ingest$geo
  limno  <- ingest$limno
  locus  <- ingest$locus
  depth  <- ingest$depth

  dir.create(lagos_path(), recursive = TRUE, showWarnings = FALSE)

  # TODO save separate rds files
  res <- list("geo" = geo,
              "limno" = limno,
              "locus" = list(locus),
              "depth" = depth)
  # res <- purrr::flatten(res)
  #
  modules <- c("geo", "limno", "locus", "depth")
  versions <- c(geo_version, limno_version, locus_version, depth_version)
  # dest_folder <- lagos_path()
  # versions <- 1:4
  outpaths <- file.path(dest_folder, paste0(modules, "_", versions, ".rds"))

  lapply(seq_len(length(res)), function(x) saveRDS(res[x], outpaths[x]))
  message(paste0("LAGOSUS compiled to ", dest_folder))
}
