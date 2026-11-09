import { Controller } from "@hotwired/stimulus"

// Drives the "Plan with Claude" page: keeps the "This week" tray of picked
// recipes, sends the tray with each chat message, and builds the link that
// opens the new meal plan form with those recipes pre-checked.
export default class extends Controller {
  static targets = [
    "trayList", "trayEmpty", "trayCount", "trayInputs", "createLink",
    "addButton", "conversation", "thinking", "form", "message"
  ]
  static values = { newPlanUrl: String }

  connect() {
    this.tray = new Map()
    this.render()
  }

  add({ params: { id, title, servings } }) {
    if (this.tray.has(id)) return

    this.tray.set(id, { title, servings: Number(servings) || 0 })
    this.render()
  }

  remove({ params: { id } }) {
    this.tray.delete(id)
    this.render()
  }

  // Cards streamed in after the tray already has recipes should reflect that.
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
    this.formTarget.querySelectorAll("button, textarea, input[type=submit]").forEach((el) => { el.disabled = true })
  }

  submitEnd(event) {
    this.thinkingTarget.classList.add("hidden")
    this.formTarget.querySelectorAll("button, textarea, input[type=submit]").forEach((el) => { el.disabled = false })

    if (event.detail.success) this.messageTarget.value = ""
    this.conversationTarget.lastElementChild?.scrollIntoView({ behavior: "smooth", block: "start" })
    this.messageTarget.focus()
  }

  render() {
    this.renderTrayList()
    this.renderTrayInputs()
    this.renderSummary()
    this.addButtonTargets.forEach((button) => this.syncAddButton(button))
  }

  renderTrayList() {
    const items = [...this.tray].map(([id, recipe]) => {
      const li = document.createElement("li")
      li.className = "list-group-item d-flex justify-content-between align-items-center px-0"

      const label = document.createElement("span")
      label.textContent = recipe.servings ? `${recipe.title} (serves ${recipe.servings})` : recipe.title

      const removeButton = document.createElement("button")
      removeButton.type = "button"
      removeButton.className = "btn btn-sm btn-link text-danger"
      removeButton.textContent = "Remove"
      removeButton.dataset.action = "meal-plan-assistant#remove"
      removeButton.dataset.mealPlanAssistantIdParam = id

      li.append(label, removeButton)
      return li
    })

    this.trayListTarget.replaceChildren(...items)
  }

  renderTrayInputs() {
    const inputs = [...this.tray.keys()].map((id) => {
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = "tray_recipe_ids[]"
      input.value = id
      return input
    })

    this.trayInputsTarget.replaceChildren(...inputs)
  }

  renderSummary() {
    const count = this.tray.size
    const servings = [...this.tray.values()].reduce((sum, recipe) => sum + recipe.servings, 0)

    this.trayEmptyTarget.classList.toggle("hidden", count > 0)
    this.createLinkTarget.classList.toggle("hidden", count === 0)
    this.trayCountTarget.textContent = count === 0
      ? ""
      : `${count} ${count === 1 ? "recipe" : "recipes"} · ${servings} servings`

    const url = new URL(this.newPlanUrlValue, window.location.origin)
    this.tray.forEach((_recipe, id) => url.searchParams.append("recipe_ids[]", id))
    this.createLinkTarget.href = url.pathname + url.search
  }

  syncAddButton(button) {
    const added = this.tray.has(Number(button.dataset.mealPlanAssistantIdParam))
    button.disabled = added
    button.textContent = added ? "Added" : "+ Add"
  }
}
