tables <- modules::module({
  import("tidyr")

  # URL para lenguaje de datatables
  lang_ES <- "//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json"

  tbMinAvgPerMonth <- function(data, year) {
    stat <- data %>%
      split(.$year) %>%
      purrr::map(dplyr::arrange, avg) %>%
      purrr::map(utils::head, 20)

    stat <- as.data.frame(stat[[year]]) %>%
      dplyr::select(
        "Videojuego" = gamename,
        "Mes" = month,
        "Media de jugadores en simultáneo" = avg,
        "Pico de jugadores en simultáneo" = peak,
        "% de la media en el valor máximo" = avg_peak_perc
      )

    DT::datatable(stat,
      style = "bootstrap",
      class = "compact stripe",
      caption = "Top 20 de los juegos menos jugados en simultáneo por mes en Steam",
      options = list(language = list(url = lang_ES), dom = "tip")
    )
  }

  tbMaxAvgPerMonth <- function(data, year) {
    stat <- data %>%
      split(.$year) %>%
      purrr::map(dplyr::arrange, dplyr::desc(avg)) %>%
      purrr::map(utils::head, 20)

    stat <- as.data.frame(stat[[year]]) %>%
      dplyr::select(
        "Videojuego" = gamename,
        "Mes" = month,
        "Media de jugadores en simultáneo" = avg,
        "Pico de jugadores en simultáneo" = peak,
        "% de la media en el valor máximo" = avg_peak_perc
      )

    DT::datatable(stat,
      style = "bootstrap",
      class = "compact stripe",
      caption = "Top 20 de los juegos más jugados en simultáneo por mes en Steam",
      options = list(language = list(url = lang_ES), dom = "tip")
    )
  }
})
