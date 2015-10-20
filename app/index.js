
var width = window.innerWidth;
var height = window.innerHeight;
var component = require('./component');
var app = document.createElement('div');
var body = document.body;
var PIXI = require('pixi.js');
var renderer = new PIXI.autoDetectRenderer(width, height, {
    // transparent: true
});
var container = new PIXI.Container();
// var spriteBg = new PIXI.Sprite.fromImage(require('./assets/bg.jpg'));
var spriteBg = new PIXI.Sprite.fromImage(require('./assets/bean.jpg'));

var sprite = new PIXI.Sprite.fromImage(require('./assets/bean.jpg'));
var vert = require('./vert.glsl');
var frag = require('./frag.glsl');
var uniforms = {
    resolution: {
        type: '2f',
        value: {
            x: width,
            y: height
        }
    },
    timeLapse: {
        type: '1f',
        value: 0.1
    },
    noiseValue: {
        type: '1f',
        value: 0.2
    },
    scratchValue: {
        type: '1f',
        value: 80./// 0.5
    },
    randomValue: {
        type: '1f',
        value: 80.// 0.1 //Math.random()
    }
};
var count = 0;
var filter = new PIXI.AbstractFilter(vert, frag, uniforms);

// body.style.overflow = 'hidden';
// app.appendChild(component());
body.appendChild(renderer.view);


function loadProgressHandler(loader, resource) {
  console.log('loading: ' + resource.url + ' progress: ' + loader.progress + '%');
}
function rand(min, max) {
    return Math.random() * (max - min) + min;
}

function setupAnimate() {
    spriteBg.anchor.set(0.5);
    // spriteBg.width = width;
    // spriteBg.height = height;
    container.pivot.set(0.0, 0.0);
    container.position.set(renderer.width / 2, renderer.height / 2);
    spriteBg.filters = [filter];
    container.addChild(spriteBg);

    sprite.anchor.set(0.5);
    sprite.position.set(renderer.width / 2, renderer.height / 2);
    // sprite.scale.set(0.6);
    // sprite.blendMode = PIXI.BLEND_MODES.SCREEN;
    // sprite.filters = [filter];
    // container.addChild(sprite);

}
window.requestAnimationFrame(animate);
function animate() {

    filter.uniforms.timeLapse.value += 1.;
    filter.uniforms.randomValue.value = rand(0, 100);
    filter.uniforms.scratchValue.value = rand(0, 100);
    // filter.getShader(renderer).syncUniforms();
    renderer.render(container);
    window.requestAnimationFrame(animate);
}

PIXI
  .loader
  .add(['./'])
  .on('progress', loadProgressHandler)
  .load(setupAnimate);
