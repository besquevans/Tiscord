document.addEventListener("turbolinks:load", () => {
  const messageItems = document.querySelector("#message-items")
  messageItems.scrollTop = messageItems.scrollHeight
  // console.log("111")
})
