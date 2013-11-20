module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dev:
        expand: true
        cwd: 'assets/js/'
        dest: '<%= coffee.dev.cwd %>'
        ext: '.js'
        src: [
          '*.coffee'
          '**/*.coffee'
        ]
        options:
          bare: true
          sourceMap: true
    coffeelint:
      all: [
        'assets/js/*.coffee',
        'assets/js/**/*.coffee',
        'Gruntfile.coffee'
      ]
      options:
        max_line_length:
          value: 120
          level: 'warn'
    compass:
      dev:
        options:
          sassDir: 'assets/css'
          cssDir: '<%= compass.dev.options.sassDir %>'
          fontsDir: 'assets/font'
          outputStyle: 'nested'
          noLineComments: false
          imagesDir: 'assets/img'
          debugInfo: false
          relativeAssets: true
    express:
      all:
        options:
          cmd: 'coffee'
          script: './server.coffee'
          port: 8000
    jade:
      dev:
        options:
          basePath: './'
          extension: '.html'
          client: false
          pretty: true
        files:
          './': [
            '*.jade'
          ]
    watch:
      coffee:
        files: [
          '<%= coffeelint.all %>'
        ]
        tasks: [
          'coffeelint'
          'coffee:dev'
        ]
        options:
          livereload: true
      compass:
        files: [
          '<%= compass.dev.options.sassDir %>/**/*.sass',
          '<%= compass.dev.options.imagesDir %>/**/*.png'
        ]
        tasks: [
          'compass:dev'
        ]
        options:
          livereload: true
      jade:
        files: [
          '*.jade'
        ]
        tasks: [
          'jade'
        ]
        options:
          livereload: true

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-jade'

  grunt.registerTask 'default', 'run the server and watch for changes', [
    'compass:dev'
    'coffee:dev'
    'jade:dev'
    'express'
    'watch'
  ]