# Karma configuration


# base path, that will be used to resolve files and exclude
module.exports = (config) ->
  config.set
    basePath: '../../../'
    frameworks: ['mocha', 'sinon-chai']
    files :[
      'bower_modules/jquery/jquery.js'
      'bower_modules/angular/angular.js'
      'bower_modules/angular-mocks/angular-mocks.js'
      'test/unit/client/app.coffee'
      'client/coffee/controllers/*.coffee'
      'client/coffee/directives/*.coffee'
      'client/coffee/services/*.coffee'
      'client/coffee/filters/*.coffee'
      'bin/client/js/views.js'
      'test/unit/client/**/*.coffee'
    ]
    preprocessors:
      '**/*.coffee': 'coffee'
    reporters = 'dots'
    port: 8080
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: false
    browsers: ['PhantomJS']
    singleRun: false
    plugins: [
      'karma-mocha'
    ]