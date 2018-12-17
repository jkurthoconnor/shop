flashMessage = document.querySelector('#notice')

if flashMessage
  flashMessage.style.display = 'none'

cart = document.getElementById('cart')
cart.innerHTML = "<%= escape_javascript render(@cart) %>"
