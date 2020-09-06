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
      document.querySelector("#message-items").innerHTML += data.html
      const messageItems = document.querySelector("#message-items")
      const messageForm = document.querySelector(".message-form")
      messageItems.scrollTop = messageItems.scrollHeight
      messageForm.querySelector("#message_content").value = ""
      // if (data.cableReady) CableReady.perform(data.operations);
    },
  });
})
