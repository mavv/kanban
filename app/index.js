
var component = require('./component');
var app = document.createElement('div');
var body = document.body;
const PIXI = require('pixi.js');
const renderer = new PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight);
const container = new PIXI.Container();
const sprite = new PIXI.Sprite.fromImage('');

// body.style.overflow = 'hidden';
// app.appendChild(component());
body.appendChild(renderer.view);
window.requestAnimationFrame(animate);

function loadProgressHandler(loader, resource) {
  console.log('loading: ' + resource.url + ' progress: ' + loader.progress + '%');
}


function setupAnimate() {
    sprite.anchor.set(0.5);
    sprite.position.set(renderer.width / 2, renderer.height / 2);
    sprite.scale.set(0.3);
    container.addChild(sprite);
}

function animate() {
  requestAnimationFrame(animate);
  renderer.render(container);
}

PIXI
  .loader
  .add(['./assets/myhouse.jpg'])
  .on('progress', loadProgressHandler)
  .load(setupAnimate);
