options_picker_taxo <- shinyWidgets::pickerOptions(
  actionsBox = TRUE,
  selectedTextFormat = "count > 3",
  liveSearch = TRUE,
  noneSelectedText = "All",
  showTick = TRUE,
  size = 5
)

options_picker_taxo_domain <- shinyWidgets::pickerOptions(
  actionsBox = TRUE,
  selectedTextFormat = "count > 3",
  liveSearch = TRUE,
  noneSelectedText = "None",
  showTick = TRUE,
  size = 5
)

# =================================

# Small function to return the taxo level number
#
# @param taxo_level character
#
# @return the taxo_level number
#
# @noRd
#
# @examples taxo_level_number("genus")
# # [1] 7
#
#
taxo_level_number <- function(taxo_level) {
  which(pr2$taxo_levels == taxo_level)
}


#
# =================================

# Small function to return the taxo level and taxon name
#
# @param kingdom
# @param supergroup
# @param division
# @param class
# @param order
# @param family
# @param genus
# @param species
#
# @return A named vector with 3 elements. The first level which is not NULL, the corresponding name or names and the taxo as a list
#
# @noRd
# #
# @examples
#
# taxo_return("Eukaryota","S", "D", "C", "O", c("F", "F1"), NULL, NULL)
# # $level
# # [1] "family"
# #
# # $name
# # [1] "F"  "F1"
# #
# # $kingdom
# # [1] "Eukaryota"
# #
# # $supergroup
# # [1] "S"
# #
# # $division
# # [1] "D"
# #
# # $class
# # [1] "C"
# #
# # $order
# # [1] "O"
# #
# # $family
# # [1] "F"  "F1"
# #
# # $genus
# # NULL
# #
# # $species
# # NULL


taxo_return <- function(domain, supergroup, division, subdivision, class, order, family, genus, species) {


  taxo_1 <- c(domain[1], supergroup[1], division[1], subdivision[1], class[1], order[1], family[1], genus[1], species[1])
  taxo_list <- list(domain = domain, supergroup = supergroup, division=division, subdivision=subdivision,
                    class=class, order = order, family = family, genus = genus, species = species)

  # The levels for which nothing is selected return NULL and the length of the vector gives the first rank which is NULL

  if (length(taxo_1) == 0) {
    return( c(level = "domain", list(name = unique(pr2$domains)), taxo_list))
  }


  taxo_level <- pr2$taxo_levels[length(taxo_1)]
  message("Taxo level: ", taxo_level)


  # Then the name(s) are just extracted from the list for the taxo_level

  taxo_name <- taxo_list[[taxo_level]]

  message("Taxo name: ", taxo_name)

  # Very strange, the if one puts the name in the list then if there are more than one it is returned as several names (name1, name2 etc...)
  # See: https://stackoverflow.com/questions/9031819/add-named-vector-to-a-list

  return( c(level = taxo_level, list(name = taxo_name), taxo_list))
}

