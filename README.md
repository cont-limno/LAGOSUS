
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build
Status](https://travis-ci.org/cont-limno/LAGOSUS.svg?branch=master)](https://travis-ci.org/cont-limno/LAGOSUS)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/LAGOSUS)](https://cran.r-project.org/package=LAGOSUS)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/LAGOSUS)](https://cran.r-project.org/package=LAGOSUS)

# LAGOSUS <img src="man/figures/logo.png" align="right" height=140/>

The `LAGOSUS` package provides an R interface to download LAGOS-US data,
store this data locally, and perform a variety of filtering and
subsetting operations.

LAGOS-US contains data for X lakes and reservoirs larger than 1 ha in
continental US. The database includes 3 data modules for: lake location
and physical characteristics for all lakes; ecological context (i.e.,
the land use, geologic, climatic, and hydrologic setting of lakes) for
all lakes; and in situ measurements of lake water quality for a subset
of the lakes from the past 3 decades for approximately Y-Z lakes
depending on the variable (see Soranno et al. 2017
[below](https://github.com/cont-limno/LAGOSUS#references)).

## Installation

``` r
# install development version from Github
# install devtools if not found - install.packages("devtools")
devtools::install_github("cont-limno/LAGOSUS", update_dependencies = TRUE)
```

### Data

The `lagosus_get` function downloads the LAGOSUS files corresponding to
the specified version from the [EDI data
repository](https://portal.edirepository.org/nis/home.jsp). Files are
stored in a temporary directory before being “compiled” to an `R` data
format in the location specified by the `dest_folder` argument.
Recommended setting is `lagos_path()`. Data only needs to be downloaded
one time per version per machine. Each `LAGOSUS`
[module](https://cont-limno.github.io/LAGOSUS/articles/lagosus_structure.html)
has a unique version number.

``` r
library(LAGOSUS)
lagosus_get(dest_folder = lagos_path())
```

## Usage

### Load Package

``` r
library(LAGOSUS)
```

### Load data

The `lagosus_load` function returns a named list of `data.frame`
objects. Use the `names()` function to see a list of available data
frames `names(dt)`.

``` r
dt <- lagosus_load()
names(dt)
```

#### Locate tables containing a variable

``` r
query_lagos_names("secchi")
```

#### Preview a table

``` r
head(dt$state)
```

#### Preview a specific lake

``` r
lake_info(name = "Pine Lake", state = "Iowa")
# or using a lagoslakeid
# lake_info(lagoslakeid = 4389)
```

#### Read table metadata

``` r
help.search("datasets", package = "LAGOSUS")
```

### Select data

`lagosus_select` is a convenience function whose primary purpose is to
provide users with the ability to select subsets of LAGOS tables that
correspond to specific keywords (see `LAGOSUS:::keyword_partial_key()`
and `LAGOSUS:::keyword_full_key()`). See
[here](http://adv-r.had.co.nz/Subsetting.html) for a comprehensive
tutorial on generic `data.frame` subsetting.

``` r
# specific variables
head(lagosus_select(table = "epi_nutr", vars = c("tp", "tn"), dt = dt))
head(lagosus_select(table = "iws.lulc", vars = c("iws_nlcd2011_pct_95"), dt = dt))

# categories
head(lagosus_select(table = "locus", categories = "id", dt = dt))
head(lagosus_select(table = "epi_nutr", categories = "waterquality", dt = dt))
head(lagosus_select(table = "hu4.chag", categories = "deposition", dt = dt)[,1:4])

# mix of specific variables and categories
head(lagosus_select(table = "epi_nutr", vars = "programname", 
                    categories = c("id", "waterquality"), dt = dt))
```

## References

Soranno, P.A., Bacon, L.C., Beauchene, M., Bednar, K.E., Bissell, E.G.,
Boudreau, C.K., Boyer, M.G., Bremigan, M.T., Carpenter, S.R., Carr, J.W.
Cheruvelil, K.S., and … , 2017. LAGOS-NE: A multi-scaled geospatial and
temporal database of lake ecological context and water quality for
thousands of US lakes. GigaScience,
<https://doi.org/10.1093/gigascience/gix101>
