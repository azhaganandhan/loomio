gulp       = require 'gulp'
pipe       = require 'gulp-pipe'
browserify = require 'browserify'
vueify     = require 'vueify'
coffeeify  = require 'coffeeify'
source     = require 'vinyl-source-stream'
paths      = require './paths'

module.exports =
  browserify: ->
    pipe browserify(
      entries: [paths.vue.main]
      transform: [coffeeify, vueify]
      paths: ['./', './node_modules']
    ).plugin('vueify-extract-css', out: "#{paths.dist.assets}/vue.css").bundle(), [
       source('vue.js'),
       gulp.dest(paths.dist.assets)
     ]
