// import CableReady from 'cable_ready';
import consumer from './consumer';

document.addEventListener("turbolinks:load", () => {
  const boardId = document.querySelector(".message-board h3").dataset.board

  consumer.subscriptions.create({channel: "BoardChannel", board_id: boardId}, {
    connected() {
      console.log("connected...")
    },
    received(data) {
      console.log("received!!!!!!")
      // console.log(data)
      // console.log(data.html)
      const current_user = document.querySelector("#main-navbar").dataset.user
      console.log(current_user)
      console.log(data.sender)
      if (data.sender == current_user) {
        const dataArr = data.html.split("sender")
        data.html = dataArr[0] + " me" + dataArr[1]
      }

      document.querySelector("#message-items").innerHTML += data.html
      const messageItems = document.querySelector("#message-items")
      const messageForm = document.querySelector(".message-form")
      messageItems.scrollTop = messageItems.scrollHeight
      messageForm.querySelector("#message_content").value = ""
      messageForm.commit.removeAttribute("disabled")
      // if (data.cableReady) CableReady.perform(data.operations);
    },
  });
})
