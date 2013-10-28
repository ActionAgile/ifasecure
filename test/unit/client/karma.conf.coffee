# Karma configuration


# base path, that will be used to resolve files and exclude
module.exports = (config) ->
  config.set
    basePath: '../../../'
    frameworks: ['sinon-chai']
    files :[
      {pattern: 'node_modules/karma-cucumberjs/vendor/cucumber-html.css', watched: false, included: false, served: true}
      {pattern: 'test/unit/client/app.template', watched: false, included: false, served: true}
      {pattern: 'test/unit/client/features/**/*.feature', watched: true, included: false, served: true}
      {pattern: 'node_modules/karma-cucumberjs/lib/adapter.js', watched: false, included: true, served: true}
      {pattern: 'test/unit/client/features/stepDefinitions/**/*.js', watched: true, included: true, served: true}
    ]
    preprocessors:
      '**/*.coffee': 'coffee'
    reporters = 'progress'
    port: 9876
    runnerPort = 9100
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: false
    browsers: ['Chrome']
    singleRun: false