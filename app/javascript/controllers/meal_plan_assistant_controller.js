import { Controller } from "@hotwired/stimulus"

// Drives the "Plan with Claude" page. The tray itself is server-rendered (it's
// the real meal plan); this controller keeps each suggestion's "+ Add" button
// in sync with the tray and handles the chat form's loading state.
export default class extends Controller {
  static targets = ["trayItem", "addButton", "conversation", "thinking", "form", "message"]

  trayItemTargetConnected() {
    this.syncAddButtons()
  }

  trayItemTargetDisconnected() {
    this.syncAddButtons()
  }

  addButtonTargetConnected(button) {
    this.syncAddButton(button)
  }

  submitOnEnter(event) {
    if (event.shiftKey || event.isComposing) return

    event.preventDefault()
    if (this.messageTarget.value.trim() === "") return
    this.formTarget.requestSubmit()
  }

  submitStart() {
    this.thinkingTarget.classList.remove("hidden")
    this.formControls().forEach((el) => { el.disabled = true })
  }

  submitEnd(event) {
    this.thinkingTarget.classList.add("hidden")
    this.formControls().forEach((el) => { el.disabled = false })

    if (event.detail.success) this.messageTarget.value = ""
    this.conversationTarget.lastElementChild?.scrollIntoView({ behavior: "smooth", block: "start" })
    this.messageTarget.focus()
  }

  // private

  formControls() {
    return this.formTarget.querySelectorAll("button, textarea, input[type=submit]")
  }

  syncAddButtons() {
    this.addButtonTargets.forEach((button) => this.syncAddButton(button))
  }

  syncAddButton(button) {
    const trayIds = new Set(this.trayItemTargets.map((item) => item.dataset.recipeId))
    const added = trayIds.has(button.dataset.recipeId)
    button.disabled = added
    button.textContent = added ? "Added" : "+ Add"
  }
}
