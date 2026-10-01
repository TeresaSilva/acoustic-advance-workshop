# Advanced acoustic workshop — website

Quarto + R website for the MFRI advanced acoustic workshop (5–8 October 2026, project 9277), styled to the MFRI / Hafró brand. Published to GitHub Pages.

## Run locally

Requires [Quarto](https://quarto.org) and R with `knitr` and `rmarkdown`.

```r
install.packages(c("knitr", "rmarkdown"))
```

```bash
quarto preview      # live preview
quarto render       # build into _site/
```

Or open `acoustic-workshop-site.Rproj` in RStudio and click **Render**.

## Add a presentation

1. Copy `presentations/_new-talk/` to `presentations/<talk-name>/`.
2. Edit `index.qmd`: title, author, `date` (the session day), slides.
3. Commit and push — it appears automatically on the Presentations page.

Slides are Reveal.js: `## Heading` starts a new slide, `::: {.notes}` holds speaker notes, R chunks render figures.

## Update the agenda

Edit `data/agenda.csv`. The Programme page and the programme slides are both generated from it.

## Publish on GitHub Pages

1. Create a repo on GitHub and push this folder to `main`.
2. Run once locally: `quarto publish gh-pages` (creates the `gh-pages` branch).
3. In the repo: **Settings → Pages → Source: Deploy from branch → `gh-pages`**.
4. In **Settings → Actions → General**, set workflow permissions to *Read and write*.

After that, every push to `main` rebuilds and publishes the site.

## Structure

```
_quarto.yml               site config, navbar, theme
index.qmd                 home
programme.qmd             agenda (from data/agenda.csv)
instructors.qmd
presentations.qmd         auto-listing of presentations/*/index.qmd
presentations/_new-talk/  copy this to start a new talk
presentations/workshop-programme/
R/agenda.R                agenda helpers
data/agenda.csv
theme/mfri.scss           website theme
theme/mfri-slides.scss    slide theme
images/hafro-emblem.png
```
