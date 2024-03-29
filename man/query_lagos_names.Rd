% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{query_lagos_names}
\alias{query_lagos_names}
\title{Query LAGOSUS names}
\usage{
query_lagos_names(grep_string, scale = NA, dt)
}
\arguments{
\item{grep_string}{character search string to grep to table column names}

\item{scale}{character filter results by one of:
\itemize{
\item county
\item edu
\item hu4
\item hu8
\item hu12
\item state
}}

\item{dt}{data.frame output of \code{\link[LAGOSUS]{lagosus_load}}}
}
\description{
Return a vector of table names whose associated tables have
columns that grep to query.
}
\examples{
\dontrun{
lg <- lagosus_load(c("locus", "depth"))
query_lagos_names("zoneid", dt = lg)
query_lagos_names("ws_meanwidth", dt = lg)
query_lagos_names("max_depth_m", dt = lg)
}
}
