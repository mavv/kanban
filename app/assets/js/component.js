const tween = require('tween.js');

function element() {
  let element = document.createElement('h1');

  element.innerHTML = 'Hello world';

  return element;
}

export default element;
