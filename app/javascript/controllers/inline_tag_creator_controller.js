import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static targets = ["input"]
  static values = { url: String }

  async createTag(event) {
    event.preventDefault()

    const name = this.inputTarget.value.trim()
    if (!name) return

    const response = await post(this.urlValue, {
      body: { tag: { name } },
      responseKind: "turbo-stream"
    })

    if (response.ok) {
      this.inputTarget.value = ""
    }
  }
}
