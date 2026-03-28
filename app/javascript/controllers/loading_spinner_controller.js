import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "loading"]

  show() {
    this.loadingTarget.classList.remove("hidden")
    this.formTarget.classList.add("hidden")
  }
}