import React from 'react'
import ReactDOM from 'react-dom'
import PayTypeSelector from 'PayTypeSelector'

document.addEventListener('turbolinks:load', () => {
  let element = document.getElementById("pay-type-component");
  element && ReactDOM.render(<PayTypeSelector />, element);
});

