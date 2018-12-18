cart = document.getElementById('cart')
cart.innerHTML = "<%= escape_javascript render(@cart) %>"
