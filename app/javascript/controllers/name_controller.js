import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.elements.name.focus()
  }

  check() {
    let name = this.element.elements.name
    if (name.value.trim().length == 0)
      name.value = "Cowardly Human"
  }

  echo() {
    this.element.elements.name.disabled = true
    let name = this.element.elements.name.value
    let frame = document.getElementById("messages")
    frame.insertAdjacentHTML("beforeend", `<p class="text-yellow-500">(${name} joins the chat)</p>`)
  }
}
