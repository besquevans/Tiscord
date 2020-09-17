document.addEventListener("turbolinks:load", () => {
  const messageItems = document.querySelector("#message-items")
  const messageForm = document.querySelector(".message-form")
  const jumpToBottom = () => messageItems.scrollTop = messageItems.scrollHeight

  if (messageItems) { jumpToBottom() }
  if (messageForm) {
    messageForm.addEventListener("keyup", () => addSubmit() )
    messageForm.addEventListener("submit", (e) => submitForm(e))
  }

  const addSubmit = () => {
    if (not_empty(messageForm.querySelector(".message-input").value)) {
      messageForm.querySelector(".message-btn").style.display = "block"
    } else {
      messageForm.querySelector(".message-btn").style.display = "none"
    }
  }

  const submitForm = (e) => {
    e.preventDefault()
    if (not_empty(messageForm.querySelector(".message-input").value)) {
      messageForm.submit()
    }
  }

  const not_empty = (string) => {
    return string.split(" ").join("") != ""
  }
})
