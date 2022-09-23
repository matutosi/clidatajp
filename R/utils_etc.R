sleep <- function(sec = 5){ Sys.sleep(sec) }
as_numeric_without_warnings <- function(x) { suppressWarnings(as.numeric(x)) }
head_3 <- function(x) utils::head(x ,3)
