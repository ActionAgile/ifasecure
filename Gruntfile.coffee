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

    env:
      test:
        src: '.env'

        # upload:
        #   src: 'bin/client/index.html'
        #   dest: 'index.html'

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-s3'

  grunt.registerTask 'default', [
    'clean:reset'
    'copy'
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