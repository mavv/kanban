var path = require('path');
var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: [
    './app/some.less',
    './app/index'
  ],
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
  module: {
    loaders: [
        {
            test: /\.js$/,
            exclude: /node_modules/,
            loader: 'babel'
        },
        {
            test: /\.json$/,
            loader: 'json'
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
          loader: "transform-loader?brfs",
          include: path.resolve('/node_modules/pixi.js')
      }
    ],
  },
  resolve: {
    // you can now require('file') instead of require('file.js')
    extensions: ['', '.js', '.json', 'less']
  },
  node: {
    fs: "empty"
  }
};
