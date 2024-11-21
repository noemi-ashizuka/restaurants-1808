import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="insert-review"
export default class extends Controller {
  static targets = ["form", "list"];
  connect() {
    console.log("connected!!!");
  }

  create(event) {
    event.preventDefault();
    // What are we doing in here???
    // submit the form using AJAX (so the page doesnt refresh)
    console.log(this.formTarget);

    const url = this.formTarget.action;
    fetch(url, {
      method: "POST",
      body: new FormData(this.formTarget),
      headers: { Accept: "text/plain" },
    })
      .then((response) => response.text())
      .then((data) => {
        // we want the one review back as a string
        console.log(data);
        this.listTarget.insertAdjacentHTML("beforeend", data);
        this.formTarget.reset();
      });
  }
}
