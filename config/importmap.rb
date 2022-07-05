# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "codemirror", to: "https://cdn.jsdelivr.net/npm/codemirror@6.0.1/dist/index.js"
pin "@codemirror/autocomplete", to: "https://cdn.jsdelivr.net/npm/@codemirror/autocomplete@6.0.2/dist/index.js"
pin "@codemirror/commands", to: "https://cdn.jsdelivr.net/npm/@codemirror/commands@6.0.1/dist/index.js"
pin "@codemirror/language", to: "https://cdn.jsdelivr.net/npm/@codemirror/language@6.2.0/dist/index.js"
pin "@codemirror/lint", to: "https://cdn.jsdelivr.net/npm/@codemirror/lint@6.0.0/dist/index.js"
pin "@codemirror/search", to: "https://cdn.jsdelivr.net/npm/@codemirror/search@6.0.0/dist/index.js"
pin "@codemirror/state", to: "https://cdn.jsdelivr.net/npm/@codemirror/state@6.1.0/dist/index.js"
pin "@codemirror/view", to: "https://cdn.jsdelivr.net/npm/@codemirror/view@6.0.2/dist/index.js"
pin "@lezer/common", to: "https://cdn.jsdelivr.net/npm/@lezer/common@1.0.0/dist/index.js"
pin "@lezer/highlight", to: "https://cdn.jsdelivr.net/npm/@lezer/highlight@1.0.0/dist/index.js"
pin "crelt", to: "https://cdn.jsdelivr.net/npm/crelt@1.0.5/index.es.js"
pin "style-mod", to: "https://cdn.jsdelivr.net/npm/style-mod@4.0.0/src/style-mod.js"
pin "w3c-keyname", to: "https://cdn.jsdelivr.net/npm/w3c-keyname@2.2.4/index.es.js"
pin "@codemirror/lang-html", to: "https://cdn.jsdelivr.net/npm/@codemirror/lang-html@6.1.0/dist/index.js"
pin "@codemirror/lang-css", to: "https://cdn.jsdelivr.net/npm/@codemirror/lang-css@6.0.0/dist/index.js"
pin "@codemirror/lang-javascript", to: "https://cdn.jsdelivr.net/npm/@codemirror/lang-javascript@6.0.1/dist/index.js"
pin "@lezer/css", to: "https://cdn.jsdelivr.net/npm/@lezer/css@1.0.0/dist/index.es.js"
pin "@lezer/html", to: "https://cdn.jsdelivr.net/npm/@lezer/html@1.0.0/dist/index.es.js"
pin "@lezer/javascript", to: "https://cdn.jsdelivr.net/npm/@lezer/javascript@1.0.1/dist/index.es.js"
pin "@lezer/lr", to: "https://cdn.jsdelivr.net/npm/@lezer/lr@1.1.0/dist/index.js"
