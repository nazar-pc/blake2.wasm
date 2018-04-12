/**
 * @package blake2.wasm
 * @author  Nazar Mokrynskyi <nazar@mokrynskyi.com>
 * @license 0BSD
 */
exec		= require('child_process').exec
glob		= require('glob')
gulp		= require('gulp')
rename		= require('gulp-rename')
uglify		= require('gulp-uglify')

gulp
	.task('build', ['wasm', 'minify'])
	.task('wasm', (callback) !->
		functions	= JSON.stringify([
			'_malloc'
			'_free'

			'_blake2b_init_key'
			'_blake2b_init'
			'_blake2b_update'
			'_blake2b_final'
			'_blake2s_init_key'
			'_blake2s_init'
			'_blake2s_update'
			'_blake2s_final'
		])
		# Options that are only specified to optimize resulting file size and basically remove unused features
		optimize	= "-Oz --llvm-lto 1 --closure 1 -s NO_EXIT_RUNTIME=1 -s NO_FILESYSTEM=1 -s EXPORTED_RUNTIME_METHODS=[] -s DEFAULT_LIBRARY_FUNCS_TO_INCLUDE=[]"
		clang_opts	= "-I src"
		command		= "EMMAKEN_CFLAGS='#clang_opts' emcc vendor/ref/blake2b-ref.c vendor/ref/blake2s-ref.c --post-js src/bytes_allocation.js -o src/blake2.js -s MODULARIZE=1 -s 'EXPORT_NAME=\"__blake2_wasm\"' -s EXPORTED_FUNCTIONS='#functions' -s WASM=1 #optimize"
		exec(command, (error, stdout, stderr) !->
			if stdout
				console.log(stdout)
			if stderr
				console.error(stderr)
			callback(error)
		)
	)
	.task('minify', ->
		gulp.src("src/index.js")
			.pipe(uglify())
			.pipe(rename(
				suffix: '.min'
			))
			.pipe(gulp.dest('src'))
	)
