# Advanced acoustic workshop — website

Quarto + R website for the MFRI advanced acoustic workshop (5–8 October 2026, project 9277), styled to the MFRI / Hafró brand. Published to GitHub Pages.

## Upload your data (participants)

You can only upload once you have been added as a collaborator. Before that, GitHub shows *"Uploads are disabled. File uploads require push access to this repository."*

1. **Accept the invitation.** Look for an email from GitHub, or open <https://github.com/TeresaSilva/acoustic-advance-workshop/invitations> while signed in, and click **Accept invitation**. No invitation? Send your GitHub username to the organiser.
2. **Open the `data` folder** in the repository on github.com.
3. Click **Add file → Upload files**.
4. **Drag a folder named after you** (e.g. `jon-jonsson/`) onto the page, with your files inside it, so everyone's data stays separate. Do not upload loose files straight into `data/`.
5. Under *Commit changes*, write a short message (e.g. `Add Jón's EK80 files`), keep **Commit directly to the `main` branch** selected, and click **Commit changes**.

### Or from the terminal

Use this for files between 25 MB and 100 MB, or for many files. You need [Git](https://git-scm.com/downloads); on Windows, run the commands in *Git Bash*. Accept the invitation first (step 1 above).

```bash
# 1. Download the repository (first time only)
git clone --depth 1 https://github.com/TeresaSilva/acoustic-advance-workshop.git
cd acoustic-advance-workshop

# 2. Tell Git who you are (first time only)
git config user.name  "Jón Jónsson"
git config user.email "you@example.com"

# 3. Copy your files into a folder named after you
mkdir -p data/jon-jonsson
cp /path/to/your/files/* data/jon-jonsson/

# 4. Save and upload
git pull
git add data/jon-jonsson
git commit -m "Add Jón's EK80 files"
git push
```

When `git push` asks for a password, GitHub does not accept your account password. Instead, either sign in through the browser window that Git opens, or paste a [personal access token](https://github.com/settings/tokens) that has the `repo` scope.

To upload more files later, `cd` into the folder and repeat step 4, after copying the new files in.

Limits and notes:

- The browser accepts files of **25 MB or smaller**, up to 100 files per upload. The terminal accepts files of **100 MB or smaller**. If your files are bigger, contact the organiser instead of splitting them.
- Everything in this repository is **public**. Upload only data you are allowed to share openly.
- Each upload rebuilds the workshop website, which takes a few minutes. Your files are saved immediately, though.

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
