1. Clone this git repo...
2. docker run -v ${PWD}:/hugo hugo new site ../src
3. preview.sh

# used versions

pagefind v1.3.0
hugo 0.145
go 1.24.1

# Anpassungen für current hugo version:

- Replace `.Site.IsServer` with `hugo.IsServer`
- Replace `paginate = 3` with `pagerSize = 3`
- Minor CSS changes

# ToDos

[x] texte einstellen / überführen
[ ] github page muss von als source "github action" haben. wichtig für die readme.md
[ ] richtige readme.md schreiben
[ ] SEO optimization: title strangely doubled?
    https://seositecheckup.com/seo-audit/christophdb.github.io
[x] auf richtige domain überführen
[ ] seo optimieren
[x] add next/previous in den blog-posts
[x] add search function
[x] add Tags am Ende eines Posts
[x] x min read time
[x] local fonts instead of google fonts
[x] icons am ende der seite vereinheitlichen
[x] 404 page
[ ] tabellendarstellung für mobile view
[ ] youtube videos einbetten
[optional] Vorschau anpassen wie hier: https://demo.stack.jimmycai.com/ mit tags und kleinen icons bei date und read time...


## Midnight:

- Group of robots coding, purple background, cartoon style, digital illustration --ar 2:1
- two robots talking with each other, purple background, cartoon style, digital illustration --ar 2:1 
- Cute robot character, purple background, cartoon style, digital illustration --ar 2:1 
1000:500px

