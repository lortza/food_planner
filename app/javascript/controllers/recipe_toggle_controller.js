import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const column = document.getElementById(event.params.columnId)
    column?.classList.toggle("hidden", !event.target.checked)
  }
}
