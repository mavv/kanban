var path = require('path');
var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    app: [
      './app/assets/less/some.less',
      './app/assets/js/index'
    ],
    vendor: [
      'pixi.js'
    ]
  },
  output: {
    path: 'build',
    chunkFilename: '[name]',
    filename: '[name].[ext]',
    sourceMapFilename: '[name].map'
  },
  debug: true,
  devtool: 'source-map',
  devServer: {
    historyApiFallback: true,
    hot: true,
    inline: true,
    progress: true,
    contentBase: './build/'
  },
  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor",
      children: true,
      // filename: "vendor.js"
      // (Give the chunk a different name)

      minChunks: Infinity,
      // (with more entries, this ensures that no other module
      //  goes into the vendor chunk)
    }),
    new HtmlWebpackPlugin({
      title: '@play',
      filename: 'app/assets/html/index-tmpl'
    }),
    new webpack.NoErrorsPlugin(),
    new webpack.HotModuleReplacementPlugin(),
  ],
  module: {
    loaders: [
      {
        test: /\.(woff|ttf|otf|eot)$/,
        loader: 'file-loader?name=app/assets/img/fonts/[name].[ext]'
      },
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
        test: /\.(jpe?g|png|gif|svg)$/i, loader: 'file?limit=10000!img?progressive=true'
      } // inline base64 URLs for <=8k images, direct URLs for the rest
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
