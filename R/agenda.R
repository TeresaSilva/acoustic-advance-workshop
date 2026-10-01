# Helpers to render the workshop agenda from data/agenda.csv
read_agenda <- function(path = here_path("data/agenda.csv")) {
  read.csv(path, encoding = "UTF-8", stringsAsFactors = FALSE, na.strings = "")
}

# Resolve paths from the project root so pages in sub-folders work too
here_path <- function(p) {
  root <- Sys.getenv("QUARTO_PROJECT_DIR", unset = ".")
  file.path(root, p)
}

esc <- function(x) {
  x[is.na(x)] <- ""
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  gsub(">", "&gt;", x, fixed = TRUE)
}

# HTML table for one day (works in both website pages and revealjs slides)
agenda_table <- function(d) {
  rows <- sprintf(
    '<tr class="%s"><td>%s–%s</td><td><strong>%s</strong>%s</td></tr>',
    ifelse(d$type == "break", "break", d$type),
    d$start, d$end,
    ifelse(d$type == "break", "", esc(d$session)),
    ifelse(d$type == "break", esc(d$session),
           ifelse(is.na(d$speakers), "",
                  paste0('<br><span class="is">', esc(d$speakers), "</span>")))
  )
  cat('\n```{=html}\n<table class="table agenda"><tbody>\n',
      paste(rows, collapse = "\n"),
      "\n</tbody></table>\n```\n\n", sep = "")
}

# Full programme: one heading + table per day
agenda_all <- function(agenda = read_agenda(), level = 2) {
  for (k in unique(agenda$day)) {
    d <- agenda[agenda$day == k, ]
    cat(strrep("#", level), " Day ", k, " · ", d$date_en[1], "\n\n", sep = "")
    cat('<span class="is">', d$date_is[1], " — ", esc(d$theme[1]), "</span>\n\n", sep = "")
    agenda_table(d)
  }
}
