gulp = require('gulp')
jscs = require('gulp-jscs')
gutil = require('gulp-util')
batch = require('gulp-batch')
watch = require('gulp-watch')
plumber = require('gulp-plumber')
prettify = require('gulp-jsbeautifier')
sourcemaps = require('gulp-sourcemaps')
gulpLiveScript = require('gulp-livescript');

scripts = 'src/**/*.ls';

gulp.task('build', function() {
    return gulp
        .src(scripts)
        .pipe(watch(scripts))
        .pipe(plumber())
        .pipe(sourcemaps.init())
        .pipe(gulpLiveScript({bare: true}))
        .pipe(jscs({fix:true}))
        .pipe(prettify({
            js: {
                indentWithTabs: true,
                braceStyle: 'end-collapse'
            }
        }))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('bin'));
})
gulp.task('compile', function() {
    gulp
        .src(scripts)
        .pipe(plumber())
        .pipe(sourcemaps.init())
        .pipe(gulpLiveScript({bare: true}))
        .pipe(jscs({fix:true}))
        .pipe(prettify({
            js: {
                indentWithTabs: true,
                braceStyle: 'end-collapse'
            }
        }))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('bin'));
})
gulp.task('watch', function() {
    watch(scripts, batch(function(events, done){
        gulp.start('build', done)
    }));
})
gulp.task('default', ['compile', 'watch']);
