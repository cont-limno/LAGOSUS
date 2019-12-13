
#'@name lagosus_compile
#'@title Compile LAGOSUS data
#'
#'@description Compile LAGOSUS data from component flat files. This function should rarely be called directly outside of manual updating of source data.
#'
#'@param limno_version character LAGOSUS database version string
#'@param limno_folder file.path to limno export folder
#'@param limno_overwrite logical overwrite existing data?
#'@param geo_version character LAGOSUS database version string
#'@param geo_folder file.path to geo export folder
#'@param geo_overwrite logical overwrite existing data?
#'@param locus_version character LAGOSUS database version string
#'@param locus_folder file.path to locus export folder
#'@param locus_overwrite logical overwrite existing data?
#'@param depth_version character LAGOSUS database version string
#'@param depth_folder file.path to depth export folder
#'#'@param depth_overwrite logical overwrite existing data?
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
#'  dest_folder = lagosus_path())
#' }
#'
lagosus_compile <- function(locus_version = NA, locus_folder = NA, locus_overwrite = FALSE,
                            limno_version = NA, limno_folder = NA, limno_overwrite = FALSE,
                            geo_version = NA, geo_folder = NA, geo_overwrite = FALSE,
                            depth_version = NA, depth_folder = NA, depth_overwrite = FALSE,
                            dest_folder = NA){

  if(is.na(dest_folder)){
    stop("Set the dest_folder argument to a folder on your local machine. Recommended setting is lagosus_path().")
  }
  dir.create(dest_folder, recursive = TRUE, showWarnings = FALSE)

  modules <- c("locus", "limno", "geo", "depth")[
    !is.na(c(locus_folder, limno_folder, geo_folder, depth_folder))]
  pb <- progress::progress_bar$new(format = "  Reading :type [:bar]",
                                   total = length(modules),
                                   clear = FALSE)

  locus_path <- file.path(dest_folder, paste0("locus_", locus_version, ".rds"))
  if(file.exists(locus_path)){message(paste0("locus module version ", locus_version,
                                             " already exists at: ", dest_folder))}
  if(!is.na(locus_folder) & (!file.exists(locus_path) | locus_overwrite)){
    pb$tick(tokens = list(type = "locus data"))
    locus <- lagos_ingest(locus_folder = locus_folder)
    saveRDS(locus, locus_path)
  }

  limno_path <- file.path(dest_folder, paste0("limno_", limno_version, ".rds"))
  if(file.exists(limno_path)){message(paste0("limno module version ", limno_version,
                                             " already exists at: ", dest_folder))}
  if(!is.na(limno_folder) & (!file.exists(limno_path) | limno_overwrite)){
    pb$tick(tokens = list(type = "limno data"))
    limno <- lagos_ingest(limno_folder = limno_folder)
    saveRDS(limno, limno_path)
  }

  geo_path <- file.path(dest_folder, paste0("geo_", geo_version, ".rds"))
  if(file.exists(geo_path)){message(paste0("geo module version ", geo_version,
                                             " already exists at: ", dest_folder))}
  if(!is.na(geo_folder) & (!file.exists(geo_path) | geo_overwrite)){
    pb$tick(tokens = list(type = "geo data"))
    geo <- lagos_ingest(geo_folder = geo_folder)
    saveRDS(geo, geo_path)
  }

  depth_path <- file.path(dest_folder, paste0("depth_", depth_version, ".rds"))
  if(file.exists(depth_path)){message(paste0("depth module version ", depth_version,
                                             " already exists at: ", dest_folder))}
  if(!is.na(depth_folder) & (!file.exists(depth_path) | depth_overwrite)){
    pb$tick(tokens = list(type = "depth data"))
    depth <- lagos_ingest(depth_folder = depth_folder)
    saveRDS(depth, depth_path)
  }

  message(paste0("LAGOSUS compiled to ", dest_folder))
}
