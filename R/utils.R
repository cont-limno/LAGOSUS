#' Load LAGOSUS data from disk
#'
#' A wrapper for \code{\link[utils]{read.table}} with a default set of parameters.
#'
#' @noRd
#' @param file_name character
#' @param sep character separator (tab or comma separated values)
#' @param dictionary data.frame linking variable_name(s) to data_type(s)
#' @param ... Options passed on to \code{\link[utils]{read.table}}
#'
#' @importFrom stats setNames
#'
#' @return data.frame
load_lagos_txt <- function(file_name, sep = "\t", dictionary = NA, ...){

  if (!inherits(dictionary, "data.frame")) {
    res <- suppressWarnings(
      read.table(file_name, header = TRUE, sep = sep, quote = "\"",
                 dec = ".", strip.white = TRUE, comment.char = "",
                 ..., stringsAsFactors = FALSE))
  }else{
    res <- suppressWarnings(
      read.table(file_name, header = TRUE, sep = sep, quote = "\"",
                 dec = ".", strip.white = TRUE, comment.char = "",
                 colClasses = "character",
                 ..., stringsAsFactors = FALSE))

    # read column types from data dictionary pass to colClasses argument
    # possible colClasses : (logical, integer, numeric, complex, character, raw)
    dictionary     <- dplyr::filter(dictionary, .data$table_name ==
                    stringr::str_extract(basename(file_name), "^.*(?=.csv)"))

    colClasses_key <- data.frame(
      data_type = c("char", "factor", "int", "numeric"),
      r_type = c("character", "factor", "integer", "numeric"),
      readr_type = c("c", "f", "i", "d"),
      stringsAsFactors = FALSE)
    colClasses     <- data.frame(variable_name = names(res),
                             stringsAsFactors = FALSE) %>%
      dplyr::left_join(dplyr::select(dictionary, .data$variable_name, .data$data_type),
                       by = "variable_name") %>%
      dplyr::left_join(colClasses_key,
                       by = "data_type") %>%
      dplyr::pull(.data$r_type)
    colClasses <- setNames(colClasses, names(res))

    res <- res %>%
      dplyr::mutate(
        dplyr::across(names(colClasses[colClasses == "numeric"]), as.numeric)) %>%
      dplyr::mutate(
        dplyr::across(names(colClasses[colClasses == "integer"]), as.integer)) %>%
      dplyr::mutate(
        dplyr::across(names(colClasses[colClasses == "factor"]), as.factor))
  }

  res
}

#' @importFrom curl curl_download
get_if_not_exists <- function(url, destfile, overwrite){
  if(!file.exists(destfile) | overwrite){
    curl::curl_download(url, destfile)
  }else{
    message(paste0("A local copy of ", url, " already exists on disk"))
  }
}

stop_if_not_exists <- function(src_path) {
  if(!file.exists(src_path)){
    stop(paste0("Dataset not found at: ", src_path, "\n Try running the `lagosne_get` command."))
  }
}

#' Return the cross-platform data path designated for LAGOSUS.
#'
#' @export
lagosus_path <- function() paste0(rappdirs::user_data_dir(appname = "LAGOSUS",
                appauthor = "LAGOSUS"), .Platform$file.sep)

lagos_names <- function(dt) purrr::map(dt, names)
# unlist(lapply(dt, function(x) length(grep("connect", names(x))))) # search tables for column

#' Query LAGOSUS names
#'
#' Return a vector of table names whose associated tables have
#'  columns that grep to query.
#'
#' @param dt data.frame output of \code{\link[LAGOSUS]{lagosus_load}}
#' @param grep_string character search string to grep to table column names
#' @param scale character filter results by one of:
#' \itemize{
#'     \item county
#'     \item edu
#'     \item hu4
#'     \item hu8
#'     \item hu12
#'     \item state
#' }
#' @export
#' @examples \dontrun{
#' lg <- lagosus_load(c("locus", "depth"))
#' query_lagos_names("zoneid", dt = lg)
#' query_lagos_names("ws_meanwidth", dt = lg)
#' query_lagos_names("max_depth_m", dt = lg)
#' }
query_lagos_names <- function(grep_string, scale = NA, dt){
  dt_names      <- unlist(lapply(dt, lagos_names), recursive = FALSE)
  names_matches <- unlist(
    lapply(dt_names,
                    function(x) length(grep(grep_string, x)) > 0)
    )
  res           <- names(dt_names)[names_matches]
  res           <- stringr::str_extract(res, "(?<=\\.)\\w+")

  res_filtered  <- res[grep(scale, res)]

  if(!is.na(scale)){
    if(length(res_filtered) < 1 & length(res) > 1){
      stop(paste0("The '", scale, "' scale does not exist!"))
    }
    res_filtered
  }else{
    res
  }
}

#' Query column names
#'
#' Return a vector of column names, given a table name and grep query string.
#'
#' @param dt data.frame
#' @param table_name character
#' @param grep_string character
#' @examples \dontrun{
#' dt <- lagosne_load("1.087.3")
#' query_column_names(dt, "hu4.chag", "_dep_")
#' query_column_names(dt, "county.chag", "baseflowindex")
#' }
query_column_names <- function(dt, table_name, grep_string){
  dt_names <- lagos_names(dt)
  dt_names[table_name][[1]][grep(grep_string, dt_names[table_name][[1]])]
}

#' Query column keywords
#'
#' Return a vector of column names, given a table name and keyword string.
#'
#' @param dt data.frame
#' @param table_name character
#' @param keyword_string character
#' @examples \dontrun{
#' dt <- lagosne_load("1.087.3")
#' query_column_keywords(dt, "hu12.chag", "hydrology")
#' }
query_column_keywords <- function(dt, table_name, keyword_string){

  if(!(keyword_string %in% keyword_partial_key()[,1])){
    stop("keyword not found in keyword_partial_key()")
  }

  if(!(table_name %in% names(dt))){
    stop("table not found in 'dt'")
  }

  dt_names <- lagos_names(dt)

  match <- keyword_partial_key()[
    keyword_partial_key()[,1] %in% keyword_string, 2]

  unlist(lapply(match,
                function(x) dt_names[table_name][[1]][
                  grep(x, dt_names[table_name][[1]])
                ]))

}

#' @importFrom curl curl_fetch_memory
#' @importFrom stringr str_extract
get_file_names <- function(url){
  handle <- curl::new_handle(nobody = TRUE)

  headers <- curl::parse_headers(
    curl::curl_fetch_memory(url, handle)$headers)
  fname <- headers[grep("filename", headers)]

  res <- stringr::str_extract(fname, "(?<=\\=)(.*?)\\.csv")
  gsub('\\"', "", res)
}

get_lagos_module <- function(edi_url, pasta_url, folder_name, overwrite){

  files <- suppressWarnings(paste0(edi_url, "&entityid=",
                            readLines(pasta_url)))
  file_names <- sapply(files, get_file_names)

  files      <- files[!is.na(file_names)]
  file_names <- file_names[!is.na(file_names)]

  local_dir   <- file.path(tempdir(), folder_name)
  dir.create(local_dir, showWarnings = FALSE)

  file_paths <- file.path(local_dir, file_names)

  invisible(lapply(seq_len(length(files)),
    function(i){
      message(paste0("Downloading ", file_names[i], " ..."))
      get_if_not_exists(files[i], file_paths[i], overwrite)
      }))

  local_dir
}

# from the Hmisc package
capitalize <- function(string) {
  capped <- grep("^[A-Z]", string, invert = TRUE)
  substr(string[capped], 1, 1) <- toupper(substr(string[capped], 1, 1))
  return(string)
}

pad_huc_ids <- function(dt, col_name, len){
  id_num <- as.numeric(dt[, col_name])
  res <- formatC(id_num, width = len, digits = 0, format = "f", flag = "0")
  dt[,col_name] <- as.character(res)
  dt
}

format_nonscientific <- function(x){
  if(is.na(as.numeric(x))){
    x
  }else{
    trimws(
      format(
        as.numeric(x), scientific = FALSE, drop0trailing = TRUE)
    )
  }
}

tidy_name_prefixes <- function(nms){

  prefixes_key <- data.frame(prefix      = c("ws_", "hu4_", "iws_", "state_",
                                             "nhd_", "hu8_", "hu12_",
                                             "edu_", "county_", "hu6_",
                                             "^lakes_",
                                             "tp_", "toc_", "tn_", "tkn_",
                                             "tdp_", "tdn_", "srp_",
                                             "secchi_", "no2no3_", "no2_",
                                             "nh4_", "doc_", "dkn_", "colort_",
                                             "colora_", "chla_", "ton_"),
                             stringsAsFactors = FALSE)
  prefixes_key$replacement <- rep("", nrow(prefixes_key))

  prefix_matches <- list()
  for(i in seq_along(prefixes_key$prefix)){
    prefix_matches[[i]] <- stringr::str_which(
      nms$raw, prefixes_key$prefix[i])
  }

  prefix_matches <- tidyr::unnest(tibble::enframe(prefix_matches))
  prefix_matches <- apply(prefix_matches, 1, function(x)
    c(nms$raw[x[2]], prefixes_key$prefix[x[1]]))
  prefix_matches <- data.frame(t(prefix_matches), stringsAsFactors = FALSE)

  if(nrow(prefix_matches) != 0 & ncol(prefix_matches) != 0){
    names(prefix_matches) <- c("raw", "prefix")
    nms <- merge(nms, prefix_matches, all.x = TRUE)
  }

  for(i in seq_along(nms$formatted[!is.na(nms$prefix)])){
    nms$formatted[!is.na(nms$prefix)][i] <-
      gsub(
        nms$prefix[!is.na(nms$prefix)][i], "",
        nms$raw[!is.na(nms$prefix)][i])
  }
  nms$formatted[is.na(nms$formatted)] <- nms$raw[is.na(nms$formatted)]

  nms
}

key_names <- function(nms){
  # match cleaned names to a key
  name_key <- data.frame(formatted  = c("ha", "perimkm",
                                        "maxdepth", "lake_perim_meters",
                                        "lakeareaha", "samplemonth",
                                        "sampleyear", "sampledate",
                                        "meandepth", "zoneid"),
                         cleaned = c("Area (ha)", "Perimeter (km)",
                                     "Max Depth", "Perimeter (m)",
                                     "Lake Area (ha)", "Month",
                                     "Year", "Date",
                                     "Mean Depth", "ID"),
                         stringsAsFactors = FALSE)
  nms <- merge(nms, name_key, all.x = TRUE)

  nms$formatted[is.na(nms$formatted)] <-
    nms$raw[is.na(nms$formatted)]
  nms$cleaned[is.na(nms$cleaned)] <- nms$formatted[is.na(nms$cleaned)]

  nms
}

tidy_name_suffixes <- function(nms){
  # match suffixes to a key
  suffixes_key <- data.frame(raw       = c("_count$", "_ha$", "_km$",
                                           "_m$", "_pct$", "_mperha$",
                                           "_pointsperha$", "_pointspersqkm$",
                                           "_pointcount$"),
                             formatted = c(" (n)", " (ha)", " (km)",
                                           " (m)", " (%)", " (n/ha)",
                                           " (n/ha)", " (n/km2)", " (n)"),
                             stringsAsFactors = FALSE)

  for(i in seq_along(suffixes_key$raw)){
    nms$cleaned <- gsub(suffixes_key$raw[i],
                        suffixes_key$formatted[i],
                        nms$cleaned, fixed = FALSE)
  }

  nms
}

url_exists <- function(url){
  handle <- curl::new_handle(nobody = TRUE)

  tryCatch(
    length(curl::parse_headers(
      curl::curl_fetch_memory(url, handle)$headers)) > 0,
    error = function(e) FALSE
  )
}

key_state <- function(x){
    key <- data.frame(state.abb = datasets::state.abb,
                      state.name = datasets::state.name,
                      stringsAsFactors = FALSE)
    dplyr::left_join(x, key,
                     by = c("state.name"))
}

# copied from jsta::tabular
tabular <- function(df, ...) {
  stopifnot(is.data.frame(df))

  align <- function(x) if (is.numeric(x)) "r" else "l"
  col_align <- vapply(df, align, character(1))

  cols <- lapply(df, format, ...)
  contents <- do.call("paste",
                      c(cols, list(sep = " \\tab ", collapse = "\\cr\n  ")))
  col_names <- paste0("\\bold{",
                      do.call("paste",
                              c(names(df), list(sep = "} \\tab \\bold{", collapse = "\\cr\n  "))),
                      "} \\cr")

  paste("\\tabular{", paste(col_align, collapse = ""), "}{\n",
        col_names,
        "\n",
        contents, "\n}\n", sep = "")
}
