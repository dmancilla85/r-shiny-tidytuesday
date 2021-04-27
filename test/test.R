# load required libraries
source("./src/load_libraries.R", local = TRUE, encoding = "UTF-8")
# load data
source("./src/load_data.R", local = TRUE, encoding = "UTF-8")

my_data <- tidy_tuesday$get_games()

games <- my_data %>%
  distinct(gamename) %>%
  arrange(gamename)

gsub("<U\\+(....)>", "\\\\u\\1", games$gamename)

years <- my_data %>%
  distinct(year) %>%
  arrange(year)

min(my_data[["year"]])
# juego año mes media ganancia pico pico_promedio_perc

# top 10 juegos con mayor <?> mensual en el año YY
stat <- my_data %>%
  split(.$year) %>%
  map(arrange, desc(avg)) %>%
  map(head, 10)

dt <- as.data.frame(stat[["2020"]])

dt %>%
  dplyr::select(
    "Videojuego" = gamename,
    "Mes" = month,
    "Media de jugadores en simultáneo" = avg,
    "Pico de jugadores en simultáneo" = peak,
    "% de la media en el valor máximo" = avg_peak_perc
  )


month <- factor(c(
  "January" = 1, "February" = 2, "March" = 3, "April" = 4, "May" = 5, "June" = 6,
  "July" = 7, "August" = 8, "September" = 9, "October" = 10, "November" = 5, "December" = 6
),
ordered = TRUE
)

my_data %>%
  dplyr::distinct(gamename) %>%
  nrow()
my_data$month_nbr <- match(my_data$month, month.name)
my_data$fecha <- paste0(my_data$year, "-", str_pad(my_data$month_nbr, 2, pad = "0"), "-01")
my_data$fecha <- as.Date(my_data$fecha)

filtered <- my_data %>% dplyr::filter(gamename == "Dota 2")
filtered %>% ggplot(aes(x = fecha, y = avg)) +
  geom_line(size = 1.3, color = "orange") +
  scale_x_date(labels = date_format("%Y-%m"), date_breaks = "3 months") +
  scale_y_continuous(labels = function(n) {
    format(n / 1000, scientific = FALSE)
  }) +
  theme_dark() +
  xlab("") +
  ylab("Promedio de jugadores mensuales (por mil)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
