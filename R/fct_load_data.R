
read_qs_from_url <- function(url) {
  board <- pins::board_url(c(url = url))
  qs_file <- pins::pin_download(board, "url")
  qs_object <- qs::qread(qs_file)
}

# Examples:
#
# global <- read_qs_from_url("https://storage.googleapis.com/pr2database-data/pr2database/data-qs/global.qs")
#
# pr2 <- read_qs_from_url("https://storage.googleapis.com/pr2database-data/pr2database/data-qs/pr2.qs")

# Using the pins package and bucket

# # A tibble: 1 x 13
# expression      min median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory time  gc
# <bch:expr> <bch:tm> <bch:>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list> <lis> <lis>
#   1 f()           8.34s  8.34s     0.120     120MB    0.120     1     1      8.34s <name~ <Rpro~ <ben~ <tib~

# Using direct reading
# A tibble: 1 x 13
# expression      min median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory time  gc
# <bch:expr> <bch:tm> <bch:>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list> <lis> <lis>
#   1 g()           5.87s  5.87s     0.171     120MB        0     1     0      5.87s <name~ <Rpro~ <ben~ <tib~
