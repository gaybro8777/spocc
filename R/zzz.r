#' Capitalize the first letter of a character string.
#'
#' @param s A character string
#' @param strict Should the algorithm be strict about capitalizing. Defaults to FALSE.
#' @param onlyfirst Capitalize only first word, lowercase all others. Useful for
#' taxonomic names.
#' @examples  \dontrun{
#' capwords(c('using AIC for model selection'))
#' capwords(c('using AIC for model selection'), strict=TRUE)
#' }
#' @export
#' @keywords internal
spocc_capwords <- function(s, strict = FALSE, onlyfirst = FALSE) {
    cap <- function(s) paste(toupper(substring(s, 1, 1)), {
        s <- substring(s, 2)
        if (strict)
            tolower(s) else s
    }, sep = "", collapse = " ")
    if (!onlyfirst) {
        vapply(strsplit(s, split = " "), cap, "", USE.NAMES = !is.null(names(s)))
    } else {
        vapply(s, function(x) paste(toupper(substring(x, 1, 1)), tolower(substring(x,
            2)), sep = "", collapse = " "), "", USE.NAMES = F)
    }
}

#' Coerces data.frame columns to the specified classes
#'
#' @param d A data.frame.
#' @param colClasses A vector of column attributes, one of:
#'    numeric, factor, character, etc.
#' @examples  \dontrun{
#' dat <- data.frame(xvar = seq(1:10), yvar = rep(c('a','b'),5)) # make a data.frame
#' str(dat)
#' str(colClasses(dat, c('factor','factor')))
#' }
#' @export
#' @keywords internal
spocc_colClasses <- function(d, colClasses) {
    colClasses <- rep(colClasses, len = length(d))
    d[] <- lapply(seq_along(d), function(i) switch(colClasses[i], numeric = as.numeric(d[[i]]),
        character = as.character(d[[i]]), Date = as.Date(d[[i]], origin = "1970-01-01"),
        POSIXct = as.POSIXct(d[[i]], origin = "1970-01-01"), factor = as.factor(d[[i]]),
        as(d[[i]], colClasses[i])))
    d
}

#' Custom ggplot2 theme
#' @import grid
#' @export
#' @keywords internal
spocc_blanktheme <- function() {
    theme(axis.line = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank(),
        axis.ticks = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), plot.background = element_blank(), plot.margin = rep(unit(0,
            "null"), 4))
}

sc <- function(l) Filter(Negate(is.null), l)

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}
