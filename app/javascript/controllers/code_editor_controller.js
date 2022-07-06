import { Controller } from "@hotwired/stimulus"
import {basicSetup} from "codemirror"
import {EditorView, keymap} from "@codemirror/view"
import {indentWithTab} from "@codemirror/commands"
import {html} from "@codemirror/lang-html"

// Connects to data-controller="code-editor"
export default class extends Controller {
  static targets = ['editor']

  connect() {
    const codeEditor = this.editorTarget

    const textArea = document.getElementById('page_html')
    let htmlContent = "<!doctype html>\n" +
        "\n" +
        "<html lang=\"en\">\n" +
        "<head>\n" +
        "  <meta charset=\"utf-8\">\n" +
        "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
        "\n" +
        "  <title>My page</title>\n" +
        "  <meta name=\"description\" content=\"A simple description of my page\">\n" +
        "  <meta name=\"author\" content=\"Author Name\">\n" +
        "\n" +
        "  <!-- <meta property=\"og:title\" content=\"A Basic HTML5 Template\">\n" +
        "  <meta property=\"og:type\" content=\"website\">\n" +
        "  <meta property=\"og:url\" content=\"https://www.sitepoint.com/a-basic-html5-template/\">\n" +
        "  <meta property=\"og:description\" content=\"A simple HTML5 Template for new projects.\">\n" +
        "  <meta property=\"og:image\" content=\"image.png\"> -->\n" +
        "\n" +
        "  <!-- <link rel=\"icon\" href=\"/favicon.ico\">\n" +
        "  <link rel=\"icon\" href=\"/favicon.svg\" type=\"image/svg+xml\">\n" +
        "  <link rel=\"apple-touch-icon\" href=\"/apple-touch-icon.png\"> -->\n" +
        "\n" +
        "\n" +
        "  <meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'; img-src https://*; style-src 'unsafe-inline'; script-src 'unsafe-inline';\">\n" +
        "\n" +
        "</head>\n" +
        "\n" +
        "<body>\n" +
        "  <!-- your content here... -->\n" +
        "</body>\n" +
        "</html>"

    if (textArea.value.length > 0) {
      htmlContent = textArea.value
    }

    let view = new EditorView({
      doc: htmlContent,
      extensions: [basicSetup, keymap.of([indentWithTab]), html()],
      parent: codeEditor
    })

    // For both "Create/Update" and "Preview" buttons
    const submitButtons = document.querySelectorAll("input[type=\"submit\"]")

    submitButtons.forEach((submitButton) => {
      submitButton.addEventListener('click', (event) => {
        textArea.value = view.state.sliceDoc();
      })
    })
  }
}
