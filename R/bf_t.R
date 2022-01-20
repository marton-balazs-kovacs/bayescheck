bf_t <- function(t_value, df, direction, rscale) {
  # Set direction of the test
  nullInterval <- switch(direction,
                         "equal" = NULL,
                         "greater" = c(0, Inf),
                         "smaller" = c( -Inf , 0))
  # Run the test
  BayesFactor::ttest.tstat(
    t = t_value,
    n1 = n1,
    n2 = n2,
    nullInterval = nullInterval,
    rscale = rscale,
    simple = TRUE
  )

}
