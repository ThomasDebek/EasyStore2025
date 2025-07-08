import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    submitQuantityForm(event) {
        const form = event.target.closest("form")
        if (form) {
            form.requestSubmit()
        }
    }
}