import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "js_half_scale", "js_full_scale", "js_double_scale"]

  select(event) {
    // remove active from all buttons, set the clicked one active
    this.buttonTargets.forEach((button) => button.classList.remove("active"))
    event.currentTarget.classList.add("active")

    // hide all lists explicitly, then show the one this button names
    this.js_half_scaleTarget.classList.add("hidden")
    this.js_full_scaleTarget.classList.add("hidden")
    this.js_double_scaleTarget.classList.add("hidden")

    this[`${event.params.list}Target`].classList.remove("hidden")
  }
}
