  library (dplyr)


  pr2 <- dvutils::pr2_read()
  pr2  <- pr2 %>%
    dplyr::filter (is.na(removed_version)) %>%
    dplyr::filter(!is.na(species))

  # pr2_fields <- data.frame(colname=colnames(pr2))
  # pr2_fields <- pr2_fields %>% mutate(help=stringr::str_c("#'   \\item{",colname,"}{}" ) )
  #
  # readr::write_tsv(data.frame(pr2_fields$help), "raw-data/pr2_fields.txt")

#  dvutils::pr2_export_sqlite("inst/extdata/pr2.sqlite")

  usethis::use_data(pr2, overwrite = TRUE)

# Generate the documentation file
#  var$string
