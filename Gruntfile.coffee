module.exports = (grunt) ->
    JS_FILE = 'js/main.js'
    LESS_FILES = 'less/_*.less'
    LESS_MAIN = 'less/style.less'
    CSS_MAIN = 'style.css'

    grunt.initConfig
        jshint:
            options:
                jshintrc: '.jshintrc'
            all: [JS_FILE]

        uglify:
            compress:
                options:
                    report: 'min'
                files:
                    'js/main.min.js' : [JS_FILE]
        less:
            development:
                options:
                    dumpLineNumbers: 'comments'
                files: [{
                    src: LESS_MAIN
                    dest: CSS_MAIN
                }]
            production:
                options:
                    yuicompress: true
                files: [{
                    src: LESS_MAIN
                    dest: CSS_MAIN
                }]
        watch:
            options:
               livereload: true
               debounceDelay: 600
            js:
               files: JS_FILE
               tasks: 'jshint'
               options:
                   spawn:false
            less:
                files: [LESS_FILES,LESS_MAIN]
                tasks: 'less:development'
            uglify:
                options:
                    report: 'min'
                files: [JS_FILE]
                tasks: 'uglify'

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-less'

    grunt.event.on 'watch', (action, filepath) ->
        grunt.config ['jshint', 'all'], filepath

    grunt.registerTask 'production', [
        'jshint'
        'less:production'
        'uglify:compress'
    ]

    grunt.registerTask 'default', [
        'jshint'
        'less:development'
        'uglify:compress'
    ]
