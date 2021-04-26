plots <- modules::module({
  import("tidyr")
  import("ggplot2")
  import("scales")

  avgPerMonth <- function(data, name) {
    if (!is.null(name)) {
      filtered <- data %>% dplyr::filter(gamename == name)
      filtered$month_nbr <- match(filtered$month, month.name)
      filtered$fecha <- paste0(
        filtered$year, "-",
        stringr::str_pad(filtered$month_nbr, 2, pad = "0"), "-01"
      )

      title <- stringi::stri_unescape_unicode(gsub("<U\\+(....)>", "\\\\u\\1", name))

      filtered$fecha <- as.Date(filtered$fecha)
      p <- filtered %>% ggplot(aes(x = fecha, y = avg)) +
        geom_line(size = 1.3, color = "orange") +
        scale_x_date(labels = date_format("%Y-%m"), date_breaks = "3 months") +
        scale_y_continuous(labels = function(n) {
          format(n / 1000, scientific = FALSE)
        }) +
        theme_dark() +
        xlab("") +
        ggtitle(stringr::str_interp("${title} - Promedio de jugadores en simúltaneo por mes")) +
        ylab("Promedio de jugadores mensuales (miles)") +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
    } else {
      p <- ggplot() +
        theme_dark()
    }
    return(p)
  }
})
