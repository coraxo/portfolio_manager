import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateCheckboxState() {
    let darkMode = localStorage.getItem('darkMode')

    if (darkMode === "true") {
      document.querySelector('.theme-controller').checked = true
    } else {
      document.querySelector('.theme-controller').checked = false
    }
  }

  connect() {
    this.updateCheckboxState()
    document.addEventListener("turbo:load", this.updateCheckboxState.bind(this))
  }

  change() {
    localStorage.setItem('darkMode', document.querySelector('.theme-controller').checked)
  }
}
