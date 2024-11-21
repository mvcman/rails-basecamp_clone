import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name", "description"]
  connect() {
    console.log("connected task.......");
    this.element.addEventListener("submit", (e) => this.validateForm(e))
  }

  handleSubmit(e) {
    console.log("click handle submit!");
    e.preventDefault();
    const form = e.target.closest("form");
    form.requestSubmit();
  }

  validateForm(e) {
    let isValid = true;

    if (this.nameTarget.value.trim() === "") {
        isValid = false;
        this.vibrate(this.nameTarget);
        this.nameTarget.focus();
    }
    // if (this.descriptionTarget.value.trim() === "") {
    //     isValid = false;
    //     this.vibrate(this.descriptionTarget);
    //     if (isValid) {
    //         this.descriptionTarget.focus();
    //     }
    // }
    if (!isValid) {
        e.preventDefault();
    }
  }

  vibrate(e) {
    e.classList.add("vibrate");
    e.classList.add("bg-yellow-50");
    setTimeout(() => {
        e.classList.remove("vibrate");
        e.classList.remove("bg-yellow-50")
    }, 1000);
  }
}
