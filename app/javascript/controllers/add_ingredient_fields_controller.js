import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "container"]
  
  add(event) {
    event.preventDefault()
    const content = this.templateTarget.content.cloneNode(true)                                                                                                       
    const index = Date.now()

    content.querySelectorAll('[name*="NEW_RECORD"], [id*="NEW_RECORD"]').forEach(el => {
      if (el.name) el.name = el.name.replace('NEW_RECORD', index)
      if (el.id) el.id = el.id.replace('NEW_RECORD', index)
    })

    this.containerTarget.appendChild(content)
  } 
  
  remove(event) {                                                                                                                                                     
    event.preventDefault()                                                                                                                                            
    event.target.closest('[data-add-ingredient-fields-target="ingredientFieldsRow"]').remove()                                                                                   
  } 
}
