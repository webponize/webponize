var gulp = require('gulp');

gulp.task('copy', function () {

  gulp.src([
    'bower_components/octicons/octicons/*'
  ]).pipe(gulp.dest('css/octicons'));

  gulp.src([
    'bower_components/primer-css/css/primer.css',
    'bower_components/primer-markdown/dist/user-content.min.css'
  ]).pipe(gulp.dest('css'));

});

gulp.task('build', function () {

  gulp.start('copy');

});