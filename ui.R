source("./src/ui/tabitems.R", local = TRUE, encoding = "UTF-8")

# Define UI for application that draws a histogram
ui <- shinydashboard::dashboardPage(
  skin = "green",
  header = shinydashboard::dashboardHeader(title = "Dashboard"),
  sidebar = shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      id = "sidebar",
      shinydashboard::menuItem(
        "Inicio",
        tabName = "tab0",
        icon = shiny::icon("dashboard")
      )
    ),
    collapsed = TRUE
  ),
  body = shinydashboard::dashboardBody(
    tags$head(
      htmltools::tags$link(
        rel = "preconnect",
        href = "https://fonts.gstatic.com"
      ),
      htmltools::tags$link(
        rel = "stylesheet",
        href = "https://fonts.googleapis.com/css2?family=Merienda&display=swap"
      ),
      htmltools::tags$link(
        rel = "stylesheet",
        href = "https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
      ),
      htmltools::tags$link(
        rel = "stylesheet",
        type = "text/css", href = "normalize.css"
      ),
      htmltools::tags$link(
        rel = "stylesheet",
        type = "text/css", href = "custom.css"
      )
    ),
    shiny::fluidRow(
      tabs$loadTabItems()
    ),
    # footer
    div(
      class = "my-footer",
      shiny::htmlOutput("txt_caption")
    )
  )
)
