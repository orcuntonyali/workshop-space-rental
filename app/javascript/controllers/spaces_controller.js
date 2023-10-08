import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "spaces"];

  change(event) {
    event.preventDefault();
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
        console.log(html);
        this.spacesTarget.innerHTML = html;
      });
  }
}
