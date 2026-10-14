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

# Markdown table for non-HTML output (the PDF of the programme)
agenda_table_md <- function(d) {
  md <- function(x) gsub("([*_|\\[\\]])", "\\\\\\1", ifelse(is.na(x), "", x))
  rows <- ifelse(
    d$type == "break",
    sprintf("| %s–%s | *%s* |", d$start, d$end, md(d$session)),
    sprintf("| %s–%s | **%s**%s |", d$start, d$end, md(d$session),
            ifelse(is.na(d$speakers), "", paste0(" · *", md(d$speakers), "*")))
  )
  cat("\n| Time | Session |\n|---------|-------------------------------------------------------------|\n", paste(rows, collapse = "\n"), "\n\n", sep = "")
}

# HTML table for one day (works in both website pages and revealjs slides)
agenda_table <- function(d) {
  if (!knitr::is_html_output()) return(agenda_table_md(d))
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
    cat("[", d$date_is[1], " — ", d$theme[1], "]{.is}\n\n", sep = "")
    agenda_table(d)
  }
}

# Participant list from data/participants.csv (markdown table, used in the PDF).
# Uses every column in the file, with the CSV header as the table header.
participants_table <- function(path = here_path("data/participants.csv")) {
  p <- read.csv(path, encoding = "UTF-8", stringsAsFactors = FALSE,
                na.strings = "", check.names = FALSE)
  # Alphabetical by the first column; accents are ignored so Á sorts with A
  key <- tolower(iconv(p[[1]], from = "UTF-8", to = "ASCII//TRANSLIT"))
  key <- gsub("[^a-z ]", "", key)
  p <- p[order(key), , drop = FALSE]
  md <- function(x) gsub("([*_|\\[\\]])", "\\\\\\1", ifelse(is.na(x), "", x))
  row <- function(x) paste0("| ", paste(x, collapse = " | "), " |")
  rows <- apply(p, 1, function(r) row(md(trimws(r))))
  cat("\n", row(names(p)), "\n", row(rep("--------------------", ncol(p))), "\n",
      paste(rows, collapse = "\n"), "\n\n", sep = "")
}
