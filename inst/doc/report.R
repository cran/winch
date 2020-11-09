## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
library(winch)

## -----------------------------------------------------------------------------
foo <- function() {
  bar()
}

bar <- function() {
  baz()
}

baz <- function() {
  sys.calls()
}

tail(foo(), 3)

## -----------------------------------------------------------------------------
library(winch)

foo <- function() {
  winch_call(bar)
}

bar <- function() {
  winch_call(baz)
}

tail(foo(), 5)

## -----------------------------------------------------------------------------
baz <- function() {
  funs <- winch:::sys_functions()
  lapply(funs, body)
}

tail(foo(), 5)

## ----eval = winch::winch_available()------------------------------------------
baz <- function() {
  winch_trace_back()
}

trace <- foo()
nrow(trace)
head(trace, 25)
table(trace$pathname)

## ----eval = FALSE-------------------------------------------------------------
#  baz <- function() {
#    rlang::trace_back()
#  }
#  
#  foo()

## ----eval = FALSE-------------------------------------------------------------
#  baz <- function() {
#    trace <- rlang::trace_back()
#    winch_add_trace_back(trace)
#  }
#  
#  foo()

## ----eval = FALSE-------------------------------------------------------------
#  options(rlang_trace_use_winch = TRUE)
#  
#  baz <- function() {
#    rlang::trace_back()
#  }
#  
#  foo()

## ----error, eval = FALSE------------------------------------------------------
#  options(
#    error = rlang::entrace,
#    rlang_backtrace_on_error = "full",
#    rlang_trace_use_winch = TRUE
#  )
#  
#  vctrs::vec_as_location(quote, 2)

