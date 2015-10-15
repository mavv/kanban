var path = require('path');
var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: [
    './app/some.less',
    './app/index'
    ],
    devtool: "source-map",
    debug: true,
    output: {
    path: 'build',
    filename: 'bundle.js'
    },
    devServer: {
    historyApiFallback: true,
    hot: true,
    inline: true,
    progress: true,
    contentBase: './build/assets/'
    },
    plugins: [
    new HtmlWebpackPlugin({
      title: '@play',
      filename: 'index.html'
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
    ],
    node: {
        fs: "empty" // this is for pixi.js
    },
    module: {
        loaders: [
            {
                test: /\.json$/,
                include: path.join(__dirname, 'node_modules', 'pixi.js'),
                loader: 'json'
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel'
            },
            {
                test: /\.less$/,
                loader: "style!css!autoprefixer!less"
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                loader: 'file?limit=10000!img?progressive=true'
            },
            {
                test: /\.glsl$/,
                loader: 'shader'
            },
        ],
        postLoaders: [
            {
                loader: "transform?brfs"
            }
        ],
    },
    resolve: {
    // you can now require('file') instead of require('file.js')
    extensions: ['', '.js', '.json', 'less', 'glsl']
    },
    glsl: {
        chunkPath: 'chunks'
    }
};
