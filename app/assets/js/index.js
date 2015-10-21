
var component = require('./component');
var app = document.createElement('div');
var body = document.body;
const PIXI = require('pixi.js');
const tween = require('tween.js')
const renderer = new PIXI.autoDetectRenderer(window.innerWidth / 2, window.innerHeight / 2);
const container = new PIXI.Container();
const sprite = new PIXI.Sprite.fromImage(require('../img/myhouse.jpg'));

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
    sprite.scale.set(0.5);
    container.addChild(sprite);
}

function animate() {
  requestAnimationFrame(animate);
  renderer.render(container);
}

PIXI
  .loader
  .add(['./'])
  .on('progress', loadProgressHandler)
  .load(setupAnimate);
