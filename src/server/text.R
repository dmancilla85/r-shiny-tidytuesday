
texts <- modules::module({
  footerInfo <- function(ver = "1.0.0") {
    date <- format(Sys.time(), "%A, %d de %B de %Y.")
    fecha <- stringr::str_to_sentence(date)

    stringr::str_interp("${fecha} Tidy Tuesday v${ver}.  R versión ${version$major}.${version$minor} \"${version$nickname}\".")
  }
})
