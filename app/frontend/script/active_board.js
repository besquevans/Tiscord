document.addEventListener("turbolinks:load", () => {
  console.log("123")
  const borderItems = document.querySelector(".board-items")
  if (!borderItems) return

  Array.from(borderItems.children).forEach(board => {
    console.log(board.children[0])
    console.log(board.children[0].classList)
    board.children[0].classList.remove("bg-secondary")
    if (board.pathname == document.location.pathname) {
      console.log("1q1q1q")
      console.log(board.children[0].classList)
      board.children[0].classList.remove("bg-dark")
      board.children[0].classList.add("bg-secondary")
      console.log(board.children[0].classList)
    }
  });
})
