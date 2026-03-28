import { Controller } from "@hotwired/stimulus"  

export default class extends Controller {
  static values = { element: { type: String, default: "li" } } 

  toggle(event) {
    event.target.closest(this.elementValue)?.classList.toggle("line-through")
  }
}