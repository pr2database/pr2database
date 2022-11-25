#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic

    # --- Page with side bar layout
    fluidPage(

      # Message for disconnection

      shinydisconnect::disconnectMessage(
        text = "Server lost connection.",
        refresh = "Reload now"
      ),

      title = "PR2 reference database",
      sidebarLayout(sidebar(),
                    mainpanel()
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  add_resource_path(
    "readme",
    app_sys("app/readme")
  )

  add_resource_path(
    "data-qs",
    app_sys("app/data-qs")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "PR2 database"
    ),

    # Script to close the windows after some inactivity - ACTIVATE for web application
    tags$script(inactivity),


  )
}
