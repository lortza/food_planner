import { Controller } from "@hotwired/stimulus"                                                                                                                                                                    
export default class extends Controller {
  toggle(event) {
    event.target.closest("li")?.classList.toggle("line-through")
  }
}