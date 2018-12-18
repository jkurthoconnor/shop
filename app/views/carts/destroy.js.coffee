cart = document.getElementById('cart')

cart.innerHTML = "<%= escape_javascript (render_if @cart && @cart.line_items.any?, @cart) %>"
