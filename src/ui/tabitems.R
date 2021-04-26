
tabs <- modules::module({
  loadTabItems <- function() {
    shinydashboard::tabItems(
      shinydashboard::tabItem(
        tabName = "tab0",
        shiny::fluidRow(
          shinydashboard::tabBox(
            id = "tab_box",
            title = htmltools::tagList(shiny::icon("steam"), "Estadísticas de Steam"),
            width = 12,
            selected = "tab1",
            side = "right",
            shiny::tabPanel(
              value = "tab3",
              title = "Top 20 menos jugados por año y mes",
              shiny::selectInput(
                inputId = "sel_year_min",
                selectize = TRUE,
                width = 100,
                label = "Año",
                choices = c()
              ),
              htmltools::div(
                DT::dataTableOutput(outputId = "tb_games_avg_min", width = "60%"),
                style = "font-size:85%",
              )
            ),
            shiny::tabPanel(
              value = "tab2",
              title = "Top 20 más jugados por año y mes",
              shiny::selectInput(
                inputId = "sel_year",
                selectize = TRUE,
                width = 100,
                label = "Año",
                choices = c()
              ),
              htmltools::div(
                DT::dataTableOutput(outputId = "tb_games_avg_max", width = "60%"),
                style = "font-size:85%",
              )
            ),
            shiny::tabPanel(
              value = "tab1", title = "Detalle por juego",
              shiny::selectInput(
                inputId = "sel_game",
                selectize = TRUE,
                width = 200,
                label = "Videojuego",
                choices = c()
              ),
              shiny::plotOutput(outputId = "plt_games")
            )
          )
        )
      )
    )
  }
})
