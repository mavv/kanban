//
var width = window.innerWidth;
var height = window.innerHeight;
var component = require('./component');
var app = document.createElement('div');
var body = document.body;
var PIXI = require('pixi.js');
var renderer = new PIXI.autoDetectRenderer(width, height);
var container = new PIXI.Container();
var spriteBg = new PIXI.Sprite.fromImage('../static/nl.jpg');
// var sprite = new PIXI.Sprite.fromImage('nl.jpg');
// var vert = require('./vert.glsl');
// var frag = require('./frag.glsl');
var uniforms = {
    resolution: {
        type: '2f',
        value: {
            x: width,
            y: height
        }
    },
    time: {
        type: '1f',
        value: 0
    }
};
var count = 0;
var filter;

// body.style.overflow = 'hidden';
// app.appendChild(component());
body.appendChild(renderer.view);


function loadProgressHandler(loader, resource) {
  console.log('loading: ' + resource.url + ' progress: ' + loader.progress + '%');
}

function setupAnimate() {
    spriteBg.anchor.set(0.5);
    spriteBg.width = width;
    // spriteBg.height = height;
    spriteBg.position.set(renderer.width / 2, renderer.height / 2);
    // console.log(frag);
    // filter = new PIXI.AbstractFilter(null, frag, uniforms);
    // sprite.shader = filter;
    // spriteBg.filters = [filter];
    container.addChild(spriteBg);

    // sprite.anchor.set(0.5);
    // sprite.position.set(renderer.width / 2, renderer.height / 2);
    // sprite.scale.set(0.5);
    // sprite.blendMode = PIXI.BLEND_MODES.ADD;
    // container.addChild(sprite);

}
window.requestAnimationFrame(animate);

function animate() {

    renderer.render(container);
    window.requestAnimationFrame(animate);
}

PIXI
  .loader
  .add(['./'])
  .on('progress', loadProgressHandler)
  .load(setupAnimate);
