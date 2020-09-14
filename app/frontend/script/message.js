document.addEventListener("turbolinks:load", () => {
  const messageItems = document.querySelector("#message-items")
  const messageForm = document.querySelector(".message-form")
  const jumpToBottom = () => messageItems.scrollTop = messageItems.scrollHeight

  if (messageItems) { jumpToBottom() }
  if (messageForm) { messageForm.addEventListener("keyup", () => addSubmit() )}

  const addSubmit = () => {
    if (messageForm.querySelector(".message-input").value != "") {
      messageForm.querySelector(".message-btn").style.display = "block"
    } else {
      messageForm.querySelector(".message-btn").style.display = "none"
    }
  }
})
