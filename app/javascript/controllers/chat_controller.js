import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.elements.message.focus()
  }

  echo() {
    let name = this.element.elements.name.value
    let message = this.element.elements.message.value
    if (message.trim().length == 0)
      message = "..."
    let frame = document.getElementById("messages")
    frame.insertAdjacentHTML("beforeend", `<h3>${name}: ${message}</h3>`)
    this.element.reset()
  }
}
