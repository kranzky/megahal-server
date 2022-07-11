import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let loading = document.getElementById("loading")
    loading.remove()
    this.element.elements.message.focus()
  }

  enable() {
    let loading = document.getElementById("loading")
    loading.remove()
    setTimeout(() => {
      this.element.elements.message.disabled = false
      this.element.reset()
      this.element.elements.message.focus()
      let messages = document.getElementById("messages").parentElement
      messages.scrollTop = messages.scrollHeight
    }, 100)
  }

  echo() {
    this.element.elements.message.disabled = true
    let name = this.element.elements.name.value
    let message = this.element.elements.message.value
    if (message.trim().length == 0)
      message = "..."
    let frame = document.getElementById("messages")
    frame.insertAdjacentHTML("beforeend", `<p class="text-blue-400">${name}: ${message}</p>`)
    frame.insertAdjacentHTML("afterend", `<img id="loading" src="loading.gif" style="width: 60px; margin-left: -15px;"/>`)
    let messages = document.getElementById("messages").parentElement
    messages.scrollTop = messages.scrollHeight
  }
}
