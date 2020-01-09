
#' Get a summary of lake attribute information
#'
#' Return lake attribute information from its name and state or its lagoslakeid.
#'
#' @param dt list of data.frames. output of \code{\link[LAGOSNE]{lagosne_load}}.
#' @param name character lake name not caps sensitive
#' @param state character state name not caps sensitive
#' @param lagoslakeid numeric lake id
#' @param max_distance passed to the \code{\link[base]{agrepl}} "all" parameter
#' to control fuzzy matching lake name. Defaults to exact matching.
#' @importFrom dplyr filter
#' @importFrom lazyeval interp
#' @importFrom utils adist
#' @importFrom rlang .data
#' @export
#'
#' @examples \dontrun{
#' lg <- lagosus_load("locus")
#'
#' lake_info(lagoslakeid = 4314, lg = lg)
#' lake_info(lagoslakeid = c(21864, 2317))
#' lake_info(lagoslakeid = c(1441))
#' lake_info(lagoslakeid = c(125428, 1441), lg = lg)
#' lake_info(lagoslakeid = c(4686, 8016), lg = lg)
#'
#' # fuzzy matching to lake name
#' lake_info(name = "Duck Lake", state = "Michigan", lg = lg)
#' # exact matching to lake name
#' lake_info(name = "Duck Lake", state = "Michigan",
#'           max.distance = list(all = 0), lg = lg)
#'
#' lake_info(name = "Sunapee Lake", state = "New Hampshire", lg = lg)
#' lake_info(name = c("Sunapee Lake", "Oneida Lake"),
#'               state = c("New Hampshire", "New York"),
#'               max.distance = list(all = 0), lg = lg)
#' }

lake_info <- function(lagoslakeid = NA, name = NA, state = NA,
                                       lg = lagosus_load("locus"), max_distance = 0){

  if(class(lg) != "list"){
    stop("lg must be a list (created by the lagosus_load function).")
  }

  if((all(is.na(name)) & !all(is.na(state))) |
     (!all(is.na(name)) & all(is.na(state)))){
    stop("Must provide either a name AND state OR lagoslakeid.")
  }

  if(any(is.na(lagoslakeid)) &
     any(!(tolower(state) %in% tolower(datasets::state.name)))){
    stop("The state variable must by an unabbreivated character string from datasets::state.name")
  }

  # create data.frame of lake and state names
  if(!all(is.na(lagoslakeid))){
    name_state <- data.frame(lagoslakeid = as.integer(lagoslakeid),
                             stringsAsFactors = FALSE)

    suppressWarnings(
    name_state <- dplyr::left_join(
      name_state,
      dplyr::select(lg$locus$locus_information, .data$lagoslakeid,
                    .data$lake_centroidstate, .data$lake_namegnis,
                    .data$state_zoneid),
                               by = "lagoslakeid"))

    name_state <- dplyr::mutate(name_state,
                                name = .data$lake_namegnis,
                                state = .data$lake_centroidstate)
    name_state <- dplyr::select(name_state,
                                .data$name, .data$state, .data$lagoslakeid,
                                .data$state_zoneid)
  }else{
    lagoslakeid <- rep(NA, length(state))
    name_state  <- data.frame(name = name, state = state,
                              lagoslakeid = lagoslakeid,
                              stringsAsFactors = FALSE)
  }

  locus_state_conn <- suppressMessages(dplyr::left_join(
    lg$locus$locus_information,
    dplyr::select(lg$locus$locus_characteristics,
                  lake_connectivity_permanent, lagoslakeid,
                  lake_totalarea_ha),
    by = c("lagoslakeid" = "lagoslakeid")
  ))

  locus_state_iws <- suppressMessages(dplyr::left_join(
    locus_state_conn,
    dplyr::select(lg$locus$locus_ws,
                  lagoslakeid, ws_area_ha),
    by = c("lagoslakeid" = "lagoslakeid")
  ))

  # pull depth
  # dt <- suppressMessages(dplyr::left_join(dt$lakes_limno,
  #         locus_state_iws))
  dt <- locus_state_iws

  # ---- filtering ----
  do.call("rbind", apply(name_state, 1, function(x){
    lake_info_(dt = dt, name = x[1], state = x[2], llid = x[3],
               max_distance = max_distance)
  }))
}

lake_info_ <- function(dt, name, state, llid, max_distance){
  # name <- name_state$name[1]
  # state <- name_state$state[1]
  # llid <- name_state$lagoslakeid[1]

  state <- as.character(key_state(
    data.frame(state.name = state,
               stringsAsFactors = FALSE))$state.abb)

  if(is.na(name)){
    name  <- dplyr::filter(dt, lagoslakeid == llid) %>%
      dplyr::pull(lake_namegnis)
  }

  # dt_filter       <- dt[which(dt$lagoslakeid == llid),]
  dt_filter       <- dt[dt$lake_centroidstate %in%
                          as.character(state),]

  if(is.na(llid)){
    filter_criteria <- lazyeval::interp(~ agrepl(name,
                                                 lake_namegnis,
                                                 ignore.case = TRUE,
                                      max.distance = list(all = max_distance)))
    # dt_filter       <- dplyr::filter(dt, !is.na(state_name))
    dt_filter       <- dplyr::filter_(dt_filter, filter_criteria)
  }else{
    dt_filter <- dplyr::filter(dt, lagoslakeid == as.numeric(llid))
  }

  if(nrow(dt_filter) == 0){
    filter_criteria <- lazyeval::interp(~ agrepl(name, lake_namegnis,
                                                 ignore.case = TRUE,
                                    max.distance = list(all = max_distance)))
    dt_filter       <- dplyr::filter_(dt_filter, filter_criteria)
  }

  if(nrow(dt_filter) < 1 & !is.na(state)){
    stop(paste0("Lake '", name, "' in ", state, " not found"))
  }

  # dt_filter[which.min(adist(dt_filter$lagosname1, name)),]
  dplyr::select(dt_filter,
                lagoslakeid,
                lake_namegnis,
                lake_centroidstate,
                dplyr::contains("decdeg"),
                dplyr::contains("area"),
                dplyr::contains("connectivity")
                )
}
