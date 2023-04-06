sidebar <- function() {sidebarPanel(width = 3,
              # The next line create a scrolling window for the sidebar panel
              # See: https://stackoverflow.com/questions/66582335/dynamically-sized-sidebarpanel-and-mainpanel-in-shiny
                style = "height: 100vh; overflow-y: auto;position:fixed;;width:20%;",

                div(tags$img(src="https://github.com/pr2database/metapr2-shiny/blob/main/inst/img/pr2_logo.png?raw=true",
                             width="80"),
                    p(),
                    actionButton("button_help", "Help", class = "btn-info",
                                 onclick ="window.open('https://pr2database.github.io/pr2database/articles/vignette-shiny-presentation.html', '_blank')"),
                    actionButton("button_disconnect", "Disconnect", class = "btn-info"),
                    h4(str_c("PR2 18S rRNA database v. ", global$version)),
                    tags$b(str_c(format(nrow(pr2$main), big.mark=","), " sequences")),
                    style="text-align: center;"),

                 conditionalPanel(
                    condition = '
                       input.panel == "Taxonomy" ||
                       input.panel == "Sequences" ||
                       input.panel == "Download selected sequences"',

                     mod_filter_sequences_sample_type_ui("filter_sequences"),
                     mod_filter_sequences_length_min_ui("filter_sequences"),
                     mod_select_taxonomy_ui("select_taxonomy")
                    ),


)

}
