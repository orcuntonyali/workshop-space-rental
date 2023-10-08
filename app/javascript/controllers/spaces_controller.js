import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "spaces"];

  connect() {
    this.loadSpaces(); // Trigger the AJAX request on initial page load
  }

  change(event) {
    event.preventDefault();
    this.loadSpaces();
  }

  loadSpaces() {
    const url = new URL(this.formTarget.action);
    const formData = new FormData(this.formTarget);
    url.search = new URLSearchParams(formData).toString();

    fetch(url, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then(response => response.text())
      .then(html => {
        this.spacesTarget.innerHTML = html;
        this.reInitializeScripts(); // Re-initialize any plugins or custom scripts
    });
  }

  reInitializeScripts() {
    // Re-initialize any plugins or custom scripts here
    // For example, if you're using a jQuery plugin:
    // $('.some-plugin').pluginFunction();
  }
}
