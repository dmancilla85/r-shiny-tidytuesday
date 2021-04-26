source("./src/load_data.R", local = TRUE, encoding = "UTF-8")
source("./src/server/text.R", local = TRUE, encoding = "UTF-8")
source("./src/server/plots.R", local = TRUE, encoding = "UTF-8")
source("./src/server/datatables.R", local = TRUE, encoding = "UTF-8")

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  games_data <- tidy_tuesday$get_games()

  # boxes
  shiny::observe({
    years <- games_data %>%
      dplyr::distinct(year) %>%
      dplyr::arrange(year)

    shiny::updateSelectInput(session, "sel_year",
      label = "Año",
      choices = years,
      selected = "2021"
    )

    shiny::updateSelectInput(session, "sel_year_min",
      label = "Año",
      choices = years,
      selected = "2021"
    )
  })

  shiny::observe({
    games <- games_data %>%
      dplyr::distinct(gamename) %>%
      dplyr::arrange(gamename)
    gamenames <- games$gamename
    names(gamenames) <- stringi::stri_unescape_unicode(gsub(
      "<U\\+(....)>", "\\\\u\\1",
      games$gamename
    ))

    shiny::updateSelectInput(session, "sel_game",
      label = "Videojuego",
      choices = gamenames
    )
  })

  output$plt_games <- shiny::renderPlot({
    name <- input$sel_game
    plots$avgPerMonth(data = games_data, name)
  })

  output$tb_games_avg_max <- DT::renderDataTable({
    tables$tbMaxAvgPerMonth(games_data, input$sel_year)
  })

  output$tb_games_avg_min <- DT::renderDataTable({
    tables$tbMinAvgPerMonth(games_data, input$sel_year_min)
  })


  # footer
  output$txt_caption <- shiny::renderUI({
    htmltools::HTML(texts$footerInfo())
  })
}
