module.exports = (grunt) ->
  grunt.initConfig
    clean:
      reset:
        src: ['bin']
    connect:
      server:
        options:
          port: 9001
          base: 'bin/client'
          hostname: '*'
          keepalive: true
      testServer:
        options:
          port: 9002
          base: 'bin/client'
          hostname: '*'
          keepalive: false
      devServer:
        options:
          port: 9001
          base: 'bin/client'
          hostname: '*'
          keepalive: false

    less:
      styles:
        dest: 'bin/client/css/ifasecure.css'
        src: 'client/less/ifasecure.less'

    copy:       
      img:
        flatten: true
        expand: true
        src: ['client/img/*']
        dest: 'bin/client/img'
      fonts:
        flatten: true
        expand: true
        src: ['bower_modules/bootstrap/fonts/*']
        dest: 'bin/client/fonts'
      components:
        flatten: true
        expand: true
        cwd: 'bower_modules'
        src: [
          'html5shiv/dist/html5shiv.js'
          'respond/respond.min.js'
        ]
        dest: 'bin/client/js'                    
      index:
        expand: true
        cwd: 'client/'
        dest: 'bin/client/'
        src: 'index.html'

    concat:
      bootstrap:
        src: [
          'bower_modules/jquery/jquery.js'
          'bower_modules/bootstrap/js/transition.js'
          'bower_modules/bootstrap/js/collapse.js'
          'bower_modules/bootstrap/js/dropdown.js'
          'bower_modules/bootstrap/js/modal.js'
        ]
        dest: 'bin/client/js/script.js'
    s3:
      options:
        access: 'public-read'
        region: 'eu-west-1'
      test:
        options:
          bucket: 'ifa.gintellect.com'
        upload: [
          {
            src: 'bin/client/css/*.css',
            dest: '/css/'
          },
          {
            src: 'bin/client/*.html',
            dest: '/'
          },
          {
            src: 'bin/client/js/*.js'
            dest: '/js/'
          },
          {
            src: 'bin/client/fonts/*'
            dest: '/fonts/'
          },
          {
            src: 'bin/client/img/*'
            dest: '/img/'
          }
        ]
    
    watch:
      options:
        livereload: true
      dev:
        files: ['client/**/*']
        tasks: ['default']

    env:
      test:
        src: '.env'

    cucumberjs:
      e2e:
        src: 'test/e2e'
        options:
          format: "pretty"

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-s3'
  grunt.loadNpmTasks 'grunt-cucumber'

  grunt.registerTask 'default', [
    'clean:reset'
    'copy'
    'concat'
    'less:styles'
  ]
  
  grunt.registerTask 'server', [
    'default'
    'connect:server'
  ]

  grunt.registerTask 'deployTest', [
    'default'
    'env:test'
    's3:test'
  ]

  grunt.registerTask 'test', [
    'default'
    'connect:testServer'
    'cucumberjs:e2e'
  ]

  grunt.registerTask 'dev', [
    'default'
    'connect:devServer'
    'watch'
  ]