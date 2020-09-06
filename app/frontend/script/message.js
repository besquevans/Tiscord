document.addEventListener("turbolinks:load", () => {
  const messageItems = document.querySelector("#message-items")
  const jumpToBottom = () => messageItems.scrollTop = messageItems.scrollHeight

  if (messageItems){ jumpToBottom() }
})
